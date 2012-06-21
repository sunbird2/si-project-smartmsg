package component.send
{
	import flash.events.MouseEvent;
	
	import lib.CustomEvent;
	import lib.Gv;
	import lib.Paging;
	import lib.RemoteSingleManager;
	import lib.SLibrary;
	
	import mx.collections.ArrayCollection;
	import mx.core.ClassFactory;
	import mx.core.IFactory;
	import mx.rpc.events.ResultEvent;
	
	import skin.emoticon.EmoticonRenderer;
	import skin.emoticon.MyRenderer;
	
	import spark.components.List;
	import spark.events.IndexChangeEvent;

	public class Emoticon
	{
		
		[Bindable]
		private var alEmt:ArrayCollection = new ArrayCollection();
		private var _gubun:String = "테마문자";
		private var cate:String = "";
		private var currTotalCount:int = 0;
		
		private var _category:List;
		private var _msgBox:List;
		private var _paging:Paging;
		
		
		public function Emoticon(){}
		
		public function get gubun():String { return _gubun;	}
		public function set gubun(value:String):void { _gubun = value; }

		public function get paging():Paging { return _paging; }
		public function set paging(value:Paging):void { _paging = value; }
		public function get msgBox():List { return _msgBox; }
		public function set msgBox(value:List):void { _msgBox = value; }
		public function get category():List { return _category; }
		public function set category(value:List):void {	_category = value; }
		
		/**
		 * emoticon Click
		 * */
		public function emoticon_clickHandler(event:MouseEvent):void {
			
			paging.viewDataCount = 6;
			gubun = "테마문자";
			RemoteSingleManager.getInstance.addEventListener("getEmotiCateList", emoticonCate_resultHandler, false, 0, true);
			RemoteSingleManager.getInstance.callresponderToken 
				= RemoteSingleManager.getInstance.service.getEmotiCateList(gubun);
		}
		/**
		 * myMessage Click
		 * */
		public function myMessage_clickHandler(event:MouseEvent):void {
			
			if (Gv.bLogin) {
				paging.viewDataCount = 6;
				gubun = "my";
				
				getEmotiList();
			}else {
				SLibrary.alert("로그인 후 이용가능 합니다.");
			}
				
		}
		/**
		 * sentMessage Click
		 * */
		public function sentMessage_clickHandler(event:MouseEvent):void {
			
			if (Gv.bLogin) {
				paging.viewDataCount = 6;
				gubun = "sent";
				RemoteSingleManager.getInstance.addEventListener("getSentListPage", emoticon_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.getSentListPage(0, paging.viewDataCount);
				
			}else {
				SLibrary.alert("로그인 후 이용가능 합니다.");
			}
			
		}
		public function emoticonCate_resultHandler(event:ResultEvent):void {
			
			var ac:ArrayCollection =  event.result as ArrayCollection;
			category.dataProvider = ac;
			getEmotiList();
			
		}
		public function getEmotiList():void {
			
			RemoteSingleManager.getInstance.addEventListener("getEmotiListPage", emoticon_resultHandler, false, 0, true);
			RemoteSingleManager.getInstance.callresponderToken 
				= RemoteSingleManager.getInstance.service.getEmotiListPage(gubun, cate, 0, paging.viewDataCount);
		}
		public function emoticon_resultHandler(event:ResultEvent):void {
			
			alEmt = event.result as ArrayCollection;
			
			if (alEmt != null && alEmt.length > 0) {
				paging.totalDataCount = Object(alEmt.getItemAt(0)).cnt;
				
				if (currTotalCount != paging.totalDataCount)paging.init();
				currTotalCount = paging.totalDataCount;
				
				if (gubun == "my") {
					category.visible = false;
					msgBox.itemRenderer = new ClassFactory(MyRenderer);
				}else if (gubun == "sent") {
					msgBox.itemRenderer = new ClassFactory(EmoticonRenderer);
				}
				else {
					category.visible = true;
					msgBox.itemRenderer = new ClassFactory(EmoticonRenderer);
				}
				msgBox.visible = true;
			}
			msgBox.dataProvider = alEmt;
		}
		public function category_changeHandler(event:IndexChangeEvent):void {
			this.cate = category.selectedItem as String;
			getEmotiList();
		}
		public function paging_clickPageHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.addEventListener("getEmotiListPage", emoticon_resultHandler, false, 0, true);
			RemoteSingleManager.getInstance.callresponderToken 
				= RemoteSingleManager.getInstance.service.getEmotiListPage(gubun, cate, int(event.obj), paging.viewDataCount);
		}
		
		
		
		
		
		
		public function clean():void {
			
			category = null;
			msgBox = null;
			paging = null;
		}
		
	}
}