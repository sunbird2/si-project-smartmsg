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
	import mx.collections.AsyncListView;
	import mx.rpc.CallResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import services.Smt;
	
	import skin.emoticon.EmoticonSkin;
	
	import spark.components.Button;
	import spark.components.ButtonBar;
	import spark.components.List;
	import spark.components.RichText;
	import spark.components.TabBar;
	import spark.components.TileGroup;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.IndexChangeEvent;
	import spark.primitives.BitmapImage;
	
	import valueObjects.CommonVO;
	
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
		[SkinPart(required="false")] public var icon:BitmapImage;
		[SkinPart(required="false")] public var title_text:RichText;
		[SkinPart(required="false")] public var titleSub_text:RichText;
		
		[SkinPart(required="true")] public var gubunBar:TabBar;
		[SkinPart(required="true")] public var category:List;
		[SkinPart(required="true")] public var msgBox:List;
		//[SkinPart(required="true")] public var paging:Paging;
		[SkinPart(required="true")] public var specialCharGroup:List;

		
		private var _state:String;
		private var acGubun:ArrayCollection = new ArrayCollection(["테마문자","업종별문자"]);
		private var acCate:ArrayCollection = new ArrayCollection();
		private var acEmt:ArrayCollection = new ArrayCollection();
		private var currTotalCount:int = 0;
		private var viewDataCount:int = 9;
		
		private var spcChar:ArrayCollection = new ArrayCollection( new Array(
			"＃","＆","＊","＠","※","☆","★","○","●","◎","◇","◆","§",
			"□","■","△","▲","▽","▼","→","←","↑","↓","↔","〓","◁",
			"◀","▷","▶","♤","♠","♡","♥","♧","♣","∠","◈","▣","◐",
			"◑","▒","▤","▥","▨","▧","▦","▩","♨","☏","☎","☜","☞",
			"¶","†","‡","↕","↗","↙","↖","↘","♭","♩","♪","♬","㉿",
			"㈜","№","㏇","™","㏂","㏘","℡","®","ª","º","！","˝","＇",
			"．","／","：","；","？","＾","＿","｀","｜","￣","、","。","·",
			"」","『","』","【","】","＋","－","√","＝","∽","±","×","÷",
			"≠","≤","≥","∞","♂","♀","∝","∵","∫","∬","∈","∋","⊆",
			"⊇","⊂","⊃","∪","∩","∧","∨","￢","⇒","⇔","∀","∃","∮",
			"∑","∏","＋","－","＜","＝","＞","±","×","÷","≠","≤","≥",
			"∞","∴","♂","♀","∠","⊥","⌒","∂","∇","≡","≒","≡","≒",
			"‥","¨","…","〃","⊥","⌒","∥","＼","∴","´","～","ˇ","˘",
			"˚","˙","¸","˛","¡","¿","∂","，","＂","（","）","［","］",
			"｛","｝","‘","’","“","”","〔","〕","〈","〉","《","》","「",
			"㉠","㉡","㉢","㉣","㉤","㉥","㉦","㉧","㉨","㉩","㉪","㉫","㉬",
			"㉭","㉮","㉯","㉰","㉱","㉲","㉳","㉴","㉵","㉶","㉷","㉸","㉹",
			"㉺","㉻","ⓐ","ⓑ","ⓒ","ⓓ","ⓔ","ⓕ","ⓖ","ⓗ","ⓘ","ⓙ","ⓚ",
			"ⓛ","ⓜ","ⓝ","ⓞ","ⓟ","ⓠ","ⓡ","ⓢ","ⓣ","ⓤ","ⓥ","ⓦ","ⓧ",
			"ⓨ","ⓩ","①","②","③","④","⑤","⑥","⑦","⑧","⑨","⑩","½"
		));
		
		// paging
		[Bindable] public var asyncListView:AsyncListView = new AsyncListView();
		[Bindable] public var callResponder:CallResponder =  new CallResponder();
		public var smt:Smt;
		
		public function Emoticon(defaultState:String) {
			super();
			PagedFilterSmtInit();
			setStyle("skinClass", EmoticonSkin);
			state = defaultState;
			addEventListener(Event.REMOVED_FROM_STAGE, destroy, false, 0, true);
		}
		
		
		

		public function get state():String { return _state;	}
		public function set state(value:String):void {
			
			_state = value;
			
			if (state == "emoticon") emoticonCateAndMsg();
			else if (state == "myMessage") getEmotiList();
			else if (state == "sentMessage") getEmotiList();
			
			this.invalidateSkinState();
		}
		
		public function get gubun():String {
			
			if (state == "emoticon") {
				if (gubunBar) return gubunBar.selectedItem as String;
				else return "테마문자";
			}
			else if (state == "myMessage")  return "my";
			else if (state == "sentMessage")  return "sent";
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
				msgBox.dataProvider = asyncListView;
				msgBox.addEventListener(IndexChangeEvent.CHANGE, msgBox_changeHandler);
				msgBox.addEventListener(KeyboardEvent.KEY_UP, msgBox_keyboardUpHandler);
			}
			/*else if (instance == paging) {
				paging.viewDataCount = viewDataCount;
				pagingInit();
				paging.addEventListener("clickPage", paging_clickPageHandler);
			}*/
			else if (instance == specialCharGroup) {
				specialCharGroup.dataProvider = spcChar;
				specialCharGroup.addEventListener(IndexChangeEvent.CHANGE, specialCharGroup_changeHandler);
			}
			else if (instance == icon)	icon.source = getTitleIcon();
			else if (instance == title_text)	title_text.text = getTitle();
			else if (instance == titleSub_text)	titleSub_text.text = "메시지를 클릭하시면 적용됩니다.";

			
			
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
				smt.removeEventListener("fault", smt_fault);
			}
			//else if (instance == paging) paging.removeEventListener("clickPage", paging_clickPageHandler);
			else if (instance == specialCharGroup) {
				specialCharGroup.removeEventListener(IndexChangeEvent.CHANGE, specialCharGroup_changeHandler);
				removeSpecialChar();
				spcChar.removeAll();
				spcChar = null;
				
			}

		}
		
		private function PagedFilterSmtInit():void {
			if (smt == null) {
				smt = new services.Smt();
				smt.showBusyCursor = true;
				smt.addEventListener("fault", smt_fault);
				smt.initialized(this, "smt")
			}
			
		}
		public function smt_fault(event:FaultEvent):void { SLibrary.alert(event.fault.faultString + '\n' + event.fault.faultDetail); }
		
		private function getTitleIcon():String {
			
			if (state == "myMessage") return "/skin/ics/assets/light/icon/3-rating-important.png";
			else if (state == "emoticon") return "/skin/ics/assets/light/icon/4-collections-view-as-grid.png";
			else if (state == "specialChar") return "/skin/ics/assets/light/icon/12-hardware-keyboard.png";
			else return "/skin/ics/assets/light/icon/5-content-email.png";

		}
		private function getTitle():String {
			
			if (state == "myMessage") return "내메시지";
			else if (state == "emoticon") return "이모티콘";
			else if (state == "specialChar") return "특수문자";
			else return "최근발송메시지";
			
		}
		
		/*public function pagingInit():void {
			
			if (acEmt != null && acEmt.length > 0 && paging) {
				
				if (paging.totalDataCount != Object(acEmt.getItemAt(0)).cnt) {
					paging.totalDataCount = Object(acEmt.getItemAt(0)).cnt;
					
				}else {
					paging.init();
				}
			}
		}*/
		
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
		/*private function getSentMessage():void {
			
			if (Gv.bLogin) {
				RemoteSingleManager.getInstance.addEventListener("getSentListPage", sent_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.getSentListPage(0, viewDataCount);
				
			}else {
				SLibrary.alert("로그인 후 이용가능 합니다.");
			}
			
		}*/
		
		private function getEmotiList():void {
			
			callResponder.addEventListener(ResultEvent.RESULT, callResponder_resultHandler);
			callResponder.token = smt.getEmotiList_pagedFiltered(gubun, cate);
			/*RemoteSingleManager.getInstance.addEventListener("getEmotiListPage", emoticon_resultHandler, false, 0, true);
			RemoteSingleManager.getInstance.callresponderToken 
				= RemoteSingleManager.getInstance.service.getEmotiListPage(gubun, cate, 0, viewDataCount);*/
		}
		private function callResponder_resultHandler(event:ResultEvent):void {
			
			callResponder.removeEventListener(ResultEvent.RESULT, callResponder_resultHandler);
			//if (asyncListView.list)	asyncListView.list.removeAll();
			asyncListView.list = callResponder.lastResult;
			
		}
		
		private function emoticon_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("getEmotiListPage", emoticon_resultHandler);
			acEmt.removeAll();
			var ac:ArrayCollection = event.result as ArrayCollection;
			if (ac != null)
				acEmt.addAll(ac);
			//pagingInit();
		}
		private function sent_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("getSentListPage", sent_resultHandler);
			acEmt.removeAll();
			var ac:ArrayCollection = event.result as ArrayCollection;
			if (ac != null)
				acEmt.addAll(ac);
			//pagingInit();
		}
		
		
		private function category_changeHandler(event:IndexChangeEvent):void {
			getEmotiList();
		}
		
		private function paging_clickPageHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.addEventListener("getEmotiListPage", emoticon_resultHandler, false, 0, true);
			RemoteSingleManager.getInstance.callresponderToken 
				= RemoteSingleManager.getInstance.service.getEmotiListPage(gubun, cate, int(event.result), viewDataCount);
		}
		
		/*private function createSpecialChar():void {
			
			var cnt:uint = Gv.spcData.length;
			var char:RichText = null;
			
			for ( var i:int = 0; i < cnt; i++) {
				char = new RichText();
				char.text = Gv.spcData[i];
				char.setStyle("fontSize",20);
				
				specialCharGroup.addElement(char);
				char.addEventListener(MouseEvent.CLICK, charClickHandler);
			}
			
		}*/
		private function removeSpecialChar():void {
			
			specialCharGroup.dataProvider.removeAll();
		}
		
		private function msgBox_changeHandler(event:IndexChangeEvent):void {
			var obj:Object = msgBox.selectedItem as Object;
			if (obj && obj.message)
				this.dispatchEvent(new CustomEvent("message", obj.message));
			
		}
		protected function charClickHandler(e:MouseEvent):void { 
			
			this.dispatchEvent(new CustomEvent("specialChar", RichText(e.currentTarget).text));
		}
		
		private function specialCharGroup_changeHandler(event:IndexChangeEvent):void {
			
			if (specialCharGroup.selectedItem)
				this.dispatchEvent(new CustomEvent("specialChar", specialCharGroup.selectedItem ));
			
			
			specialCharGroup.selectedIndex = -1;
			
		}
		
		/**
		 * delete message
		 * */
		private function msgBox_keyboardUpHandler(event:KeyboardEvent):void {
			
			if (event.keyCode == 46
				&& state == "myMessage"
				&& msgBox.selectedItem
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
			
			var bvo:CommonVO = event.result as CommonVO;
			if (bvo.rslt) {
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
			//paging = null;
			specialCharGroup = null;
		}
		
	}
}