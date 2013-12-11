package module.url.att
{
	import flash.events.KeyboardEvent;
	
	import module.url.att.skin.InputSkin;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.Button;
	import spark.components.ButtonBar;
	import spark.components.DropDownList;
	import spark.components.Group;
	import spark.components.TextArea;
	import spark.components.TextInput;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.IndexChangeEvent;
	
	[SkinState("default")]
	[SkinState("view")]
	[SkinState("actEmpty")]
	[SkinState("actContent")]
	public class Input extends SkinnableComponent implements IAtt
	{
		[SkinPart(required="true")]public var ele:Group;
		[SkinPart(required="true")]public var attribute:Group;
		
		[SkinPart(required="true")]public var oneBox:Group;
		[SkinPart(required="true")]public var ti:TextInput;
		[SkinPart(required="true")]public var btni:Button;
		
		[SkinPart(required="true")]public var multiBox:Group;
		[SkinPart(required="true")]public var ta:TextArea;
		[SkinPart(required="true")]public var btna:Button;
		
		[SkinPart(required="true")]public var inputLayout:ButtonBar;
		[SkinPart(required="true")]public var buttonInput:TextInput;
		[SkinPart(required="true")]public var commitInput:TextInput;
		[SkinPart(required="true")]public var nextPage:DropDownList;
		
		
		[Bindable]
		private var _att:Object;
		
		public function set att(val:Object):void { _att = val; }
		public function get att():Object { return _att; }
		
		private var _stat:String = "default";
		public function get state():String { return _stat; }
		public function set state(value:String):void {
			_stat = value;
			invalidateSkinState();
		}
		
		[Bindable]
		public var buttonLabel:String = "확인";
		[Bindable]
		public var layoutIndex:int = 0;
		[Bindable]
		public var commitMsg:String = "감사합니다";
		
		private var acNext:ArrayCollection = new ArrayCollection(["페이지 이동 안함","다음 페이지 이동"]);
		
		public function Input(val:Object){ 
			super();
			att = val;
			init();
			setStyle("skinClass", InputSkin);
		}
		private function init():void {
			if (att != null) {
				layoutIndex = att.layout == "one"? 0 : 1;
				buttonLabel = att.btnText;
				commitMsg = att.commitMsg;
			}
		}
		
		public function getJson():String
		{
			return null;
		}
		
		public function setJson(json:String):void
		{
		}
		
		override protected function getCurrentSkinState():String
		{
			if (att != null && _stat == "actEmpty") _stat = "actContent";
			else if (att != null && _stat == "default") {
				_stat = "view";
			}
			return this._stat;
		} 
		
		override protected function partAdded(partName:String, instance:Object) : void
		{
			super.partAdded(partName, instance);
			if (instance == inputLayout) {
				if (att != null && att.layout) { inputLayout.selectedIndex = layoutIndex }
				
				inputLayout.addEventListener(IndexChangeEvent.CHANGE, inputLayout_changeHandler);
			}
			else if (instance == btni) btni.label = buttonLabel;
			else if (instance == btna) btna.label = buttonLabel;
			else if (instance == buttonInput) {
				buttonInput.text = buttonLabel;
				buttonInput.addEventListener(KeyboardEvent.KEY_UP, buttonInput_keyupHandler);
			}
			else if (instance == commitInput) {
				commitInput.text = commitMsg;
				commitInput.addEventListener(KeyboardEvent.KEY_UP, commitInput_keyupHandler);
			}
			else if (instance == nextPage) {
				nextPage.dataProvider = acNext;
				nextPage.addEventListener(IndexChangeEvent.CHANGE, nextPage_changeHandler);
				callLater(initNextPage);
				
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
		}
		
		private function inputLayout_changeHandler(event:IndexChangeEvent):void {
			layoutIndex = event.newIndex;
			att.layout = layoutIndex;
		}
		
		private function buttonInput_keyupHandler(event:KeyboardEvent):void {
			buttonLabel = buttonInput.text;
			att.btnText  = buttonLabel;
		}
		private function commitInput_keyupHandler(event:KeyboardEvent):void {
			att.commitMsg  = commitInput.text;
		}
		
		
		private function initNextPage():void {

			if ( att.next != null ) {
				nextPage.selectedIndex = att.next as int;
			}
		}
		private function nextPage_changeHandler(event:IndexChangeEvent):void {
			att.next = nextPage.selectedIndex;
		}
		
	}
}