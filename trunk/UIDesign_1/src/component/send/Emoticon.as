package component.send
{
	import flash.events.MouseEvent;
	
	import lib.CustomEvent;
	import lib.Paging;
	import lib.RemoteManager;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	
	import spark.components.List;
	import spark.events.IndexChangeEvent;

	public class Emoticon
	{
		
		[Bindable]
		private var alEmt:ArrayCollection = new ArrayCollection();
		private var gubun:String = "테마문자";
		private var cate:String = "";
		private var currTotalCount:int = 0;
		
		private var category:List;
		private var msgBox:List;
		private var paging:Paging;
		
		
		public function Emoticon(category:List, msgBox:List, paging:Paging)
		{
			this.category = category;
			this.msgBox = msgBox;
			this.paging = paging;
		}
		
		public function emoticon_clickHandler(event:MouseEvent):void {
			
			paging.viewDataCount = 6;
			RemoteManager.getInstance.result = emoticonCate_resultHandler;
			RemoteManager.getInstance.callresponderToken 
				= RemoteManager.getInstance.service.getEmotiCateList(gubun);
		}
		public function emoticonCate_resultHandler(event:ResultEvent):void {
			
			var ac:ArrayCollection =  event.result as ArrayCollection;
			category.dataProvider = ac;
			getEmotiList();
			
		}
		public function getEmotiList():void {
			
			RemoteManager.getInstance.result = emoticon_resultHandler;
			RemoteManager.getInstance.callresponderToken 
				= RemoteManager.getInstance.service.getEmotiListPage(gubun, cate, 0, paging.viewDataCount);
		}
		public function emoticon_resultHandler(event:ResultEvent):void {
			
			alEmt = event.result as ArrayCollection;
			
			if (alEmt != null && alEmt.length > 0) {
				paging.totalDataCount = Object(alEmt.getItemAt(0)).cnt;
				
				if (currTotalCount != paging.totalDataCount)paging.init();
				currTotalCount = paging.totalDataCount;
				
				category.visible = true;
				msgBox.visible = true;
			}
			msgBox.dataProvider = alEmt;
		}
		public function category_changeHandler(event:IndexChangeEvent):void {
			this.cate = category.selectedItem as String;
			getEmotiList();
		}
		public function paging_clickPageHandler(event:CustomEvent):void {
			
			RemoteManager.getInstance.result = emoticon_resultHandler;
			RemoteManager.getInstance.callresponderToken 
				= RemoteManager.getInstance.service.getEmotiListPage(gubun, cate, int(event.obj), paging.viewDataCount);
		}
		
	}
}