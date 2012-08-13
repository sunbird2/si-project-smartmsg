package component.emoticon
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import lib.CustomEvent;
	import lib.Gv;
	import lib.Paging;
	import lib.RemoteSingleManager;
	import lib.SLibrary;
	
	import mx.collections.ArrayCollection;
	
	import skin.emoticon.EmoticonSkin;
	
	import spark.components.Button;
	import spark.components.ButtonBar;
	import spark.components.List;
	import spark.components.RichText;
	import spark.components.TileGroup;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.IndexChangeEvent;
	
	import valueObjects.BooleanAndDescriptionVO;
	
	[Event(name="message", type="lib.CustomEvent")]
	[Event(name="specialChar", type="lib.CustomEvent")]
	[Event(name="close", type="flash.events.Event")]
	
	/* A component must identify the view states that its skin supports. 
	Use the [SkinState] metadata tag to define the view states in the component class. 
	[SkinState("normal")] */
	[SkinState("specialChar")]
	[SkinState("myMessage")]
	[SkinState("emoticon")]
	[SkinState("sentMessage")]
	
	public class Emoticon extends SkinnableComponent
	{
		/* To declare a skin part on a component, you use the [SkinPart] metadata. 
		[SkinPart(required="true")] */
		[SkinPart(required="true")] public var gubunBar:ButtonBar;
		[SkinPart(required="true")] public var category:List;
		[SkinPart(required="true")] public var msgBox:List;
		[SkinPart(required="true")] public var paging:Paging
		[SkinPart(required="true")] public var specialCharGroup:TileGroup;

		
		private var _state:String;
		private var acGubun:ArrayCollection = new ArrayCollection(["테마문자","업종별문자"]);
		private var acCate:ArrayCollection = new ArrayCollection();
		private var acEmt:ArrayCollection = new ArrayCollection();
		private var currTotalCount:int = 0;
		private var viewDataCount:int = 9;
		
		public function Emoticon(defaultState:String) {
			super();
			setStyle("skinClass", EmoticonSkin);
			state = defaultState;
			addEventListener(Event.REMOVED_FROM_STAGE, destroy, false, 0, true);
		}
		
		

		public function get state():String { return _state;	}
		public function set state(value:String):void {
			
			_state = value;
			
			if (state == "emoticon") emoticonCateAndMsg();
			else if (state == "myMessage") getEmotiList();
			else if (state == "sentMessage") getSentMessage();
			
			this.invalidateSkinState();
		}
		
		public function get gubun():String {
			
			if (state == "emoticon") {
				if (gubunBar) return gubunBar.selectedItem as String;
				else return "테마문자";
			}
			else if (state == "myMessage")  return "my";
			else return "테마문자"; 
			
		}
		public function get cate():String {
			
			var c:String = "";
			if (category && category.selectedItem) c = category.selectedItem as String;
			
			return c;
		}
		
		

		/* Implement the getCurrentSkinState() method to set the view state of the skin class. */
		override protected function getCurrentSkinState():String
		{
			return state;
		} 
		
		/* Implement the partAdded() method to attach event handlers to a skin part, 
		configure a skin part, or perform other actions when a skin part is added. */	
		override protected function partAdded(partName:String, instance:Object) : void
		{
			super.partAdded(partName, instance);
			if (instance == gubunBar) {
				gubunBar.dataProvider = acGubun;
				gubunBar.selectedIndex = 0;
				gubunBar.addEventListener(IndexChangeEvent.CHANGE, gubunBar_changeHandler);
			}
			else if (instance == category) {
				category.dataProvider = acCate;
				category.addEventListener(IndexChangeEvent.CHANGE, category_changeHandler);
			}
			else if (instance == msgBox) {
				msgBox.dataProvider = acEmt;
				msgBox.addEventListener(IndexChangeEvent.CHANGE, msgBox_changeHandler);
				msgBox.addEventListener(KeyboardEvent.KEY_UP, msgBox_keyboardUpHandler);
			}
			else if (instance == paging) {
				paging.viewDataCount = viewDataCount;
				pagingInit();
				paging.addEventListener("clickPage", paging_clickPageHandler);
			}
			else if (instance == specialCharGroup) {
				createSpecialChar();
			}

			
			
		}
		
		/* Implement the partRemoved() method to remove the even handlers added in partAdded() */
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
			if (instance == gubunBar) ArrayCollection(gubunBar.dataProvider).removeAll();
			else if (instance == category) {
				ArrayCollection(category.dataProvider).removeAll();
				category.removeEventListener(IndexChangeEvent.CHANGE, category_changeHandler);
			}
			else if (instance == msgBox) {
				ArrayCollection(msgBox.dataProvider).removeAll();
				msgBox.removeEventListener(IndexChangeEvent.CHANGE, msgBox_changeHandler);
			}
			else if (instance == paging) paging.removeEventListener("clickPage", paging_clickPageHandler);
			else if (instance == specialCharGroup) removeSpecialChar();

		}
		
		public function pagingInit():void {
			
			if (acEmt != null && acEmt.length > 0 && paging) {
				
				if (paging.totalDataCount != Object(acEmt.getItemAt(0)).cnt) {
					paging.totalDataCount = Object(acEmt.getItemAt(0)).cnt;
					
				}else {
					paging.init();
				}
			}
		}
		
		private function gubunBar_changeHandler(event:IndexChangeEvent):void {

			state = "emoticon";
		}
		
		private function emoticonCateAndMsg():void {
			
			RemoteSingleManager.getInstance.addEventListener("getEmotiCateList", emoticonCate_resultHandler, false, 0, true);
			RemoteSingleManager.getInstance.callresponderToken 
				= RemoteSingleManager.getInstance.service.getEmotiCateList(gubun);
		}
		private function emoticonCate_resultHandler(event:CustomEvent):void {
			RemoteSingleManager.getInstance.removeEventListener("getEmotiCateList", emoticonCate_resultHandler);
			
			acCate.removeAll();
			
			var ac:ArrayCollection = event.result as ArrayCollection;
			if (ac != null)
				acCate.addAll(ac);
			
			getEmotiList();
		}
		private function getSentMessage():void {
			
			if (Gv.bLogin) {
				RemoteSingleManager.getInstance.addEventListener("getSentListPage", sent_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.getSentListPage(0, viewDataCount);
				
			}else {
				SLibrary.alert("로그인 후 이용가능 합니다.");
			}
			
		}
		
		private function getEmotiList():void {
			
			RemoteSingleManager.getInstance.addEventListener("getEmotiListPage", emoticon_resultHandler, false, 0, true);
			RemoteSingleManager.getInstance.callresponderToken 
				= RemoteSingleManager.getInstance.service.getEmotiListPage(gubun, cate, 0, viewDataCount);
		}
		
		private function emoticon_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("getEmotiListPage", emoticon_resultHandler);
			acEmt.removeAll();
			var ac:ArrayCollection = event.result as ArrayCollection;
			if (ac != null)
				acEmt.addAll(ac);
			pagingInit();
		}
		private function sent_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("getSentListPage", sent_resultHandler);
			acEmt.removeAll();
			var ac:ArrayCollection = event.result as ArrayCollection;
			if (ac != null)
				acEmt.addAll(ac);
			pagingInit();
		}
		
		
		private function category_changeHandler(event:IndexChangeEvent):void {
			getEmotiList();
		}
		
		private function paging_clickPageHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.addEventListener("getEmotiListPage", emoticon_resultHandler, false, 0, true);
			RemoteSingleManager.getInstance.callresponderToken 
				= RemoteSingleManager.getInstance.service.getEmotiListPage(gubun, cate, int(event.result), viewDataCount);
		}
		
		private function createSpecialChar():void {
			
			var cnt:uint = Gv.spcData.length;
			var char:RichText = null;
			
			for ( var i:int = 0; i < cnt; i++) {
				char = new RichText();
				char.text = Gv.spcData[i];
				char.setStyle("fontSize",20);
				
				specialCharGroup.addElement(char);
				char.addEventListener(MouseEvent.CLICK, charClickHandler);
			}
			
		}
		private function removeSpecialChar():void {
			
			var cnt:uint = Gv.spcData.length;
			for ( var i:int = 0; i < cnt; i++) {
				specialCharGroup.getElementAt(i).removeEventListener(MouseEvent.CLICK, charClickHandler);
			}
			specialCharGroup.removeAllElements();
			
		}
		
		private function msgBox_changeHandler(event:IndexChangeEvent):void {
			var obj:Object = msgBox.selectedItem as Object;
			this.dispatchEvent(new CustomEvent("message", obj.msg));
			
		}
		protected function charClickHandler(e:MouseEvent):void { 
			
			this.dispatchEvent(new CustomEvent("specialChar", RichText(e.currentTarget).text));
		}
		
		/**
		 * delete message
		 * */
		private function msgBox_keyboardUpHandler(event:KeyboardEvent):void {
			
			if (event.keyCode == 46
				&& state == "myMessage"
				&& Object(msgBox.selectedItem).idx != null) {
				
				delMymessage( int(msgBox.selectedItem.idx) );
			}
			
		}
		public function delMymessage(idx:int):void {
			if (idx != 0) {
				RemoteSingleManager.getInstance.addEventListener("delMymsg", delMymessage_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.delMymsg(idx);
			}else {
				SLibrary.alert("키가 없습니다.");
			}
		}
		private function delMymessage_resultHandler(event:CustomEvent):void {
			
			var bvo:BooleanAndDescriptionVO = event.result as BooleanAndDescriptionVO;
			if (bvo.bResult) {
				SLibrary.alert("삭제되었습니다.");
				getEmotiList();
			}else {
				SLibrary.alert("실패");
			}
		}
		
		private function close_clickHandler(event:MouseEvent):void {
			this.dispatchEvent(new Event("close"));
		}
		
		public function destroy(event:Event):void {
			
			acGubun.removeAll();
			acCate.removeAll();
			acEmt.removeAll();
			
			acGubun = null;
			acCate = null;
			acEmt = null;
			
			gubunBar = null;
			category = null;
			msgBox = null;
			paging = null;
			specialCharGroup = null;
		}
		
	}
}