package module.url.att
{
	import flash.events.KeyboardEvent;
	
	import module.url.att.skin.BtnSkin;
	
	import mx.collections.ArrayCollection;
	import mx.controls.RichTextEditor;
	
	import spark.components.Button;
	import spark.components.DropDownList;
	import spark.components.Group;
	import spark.components.TextInput;
	import spark.components.supportClasses.SkinnableComponent;
	
	[SkinState("default")]
	[SkinState("view")]
	[SkinState("actEmpty")]
	[SkinState("actContent")]
	public class Btn extends SkinnableComponent implements IAtt
	{
		[SkinPart(required="true")]public var ele:Group;
		[SkinPart(required="true")]public var attribute:Group;
		[SkinPart(required="true")]public var btn:Button;
		[SkinPart(required="true")]public var buttonInput:TextInput;
		[SkinPart(required="true")]public var nextPage:DropDownList;
		[SkinPart(required="true")]public var nextInput:TextInput;
		
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
		public var nextValue:String = "";
		
		private var acNext:ArrayCollection = new ArrayCollection(["페이지이동","링크연결","전화걸기","문자보내기"]);
		
		
		public function Btn(val:Object){ 
			super(); 
			att = val;
			init();
			setStyle("skinClass", BtnSkin);
		}
		private function init():void {
			if (att != null) {
				buttonLabel = att.btnText;
				nextValue = att.next.value;
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
			if (instance == btn) btn.label = buttonLabel;
			else if (instance == buttonInput) {
				buttonInput.text = buttonLabel;
				buttonInput.addEventListener(KeyboardEvent.KEY_UP, buttonInput_keyupHandler);
			}
			else if (instance == nextPage) {
				nextPage.dataProvider = acNext;
				callLater(initNextPage);
				
			}
			else if (instance == nextInput) {
				nextInput.text = nextValue;
			}
			
		}
		
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
		}
		
		
		private function buttonInput_keyupHandler(event:KeyboardEvent):void {
			buttonLabel = buttonInput.text;
		}
		private function initNextPage():void {
			
			if ( att.next != null ) {
				//0:page, 1:link, 2:phone, 3:sms
				nextPage.selectedIndex = att.next.type as int;
			}
		}
		
	}
}