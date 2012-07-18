package component.paste
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import lib.CustomEvent;
	import lib.SLibrary;
	
	import mx.collections.ArrayCollection;
	
	import skin.paste.PasteSkin;
	
	import spark.components.Button;
	import spark.components.RichText;
	import spark.components.TextArea;
	import spark.components.supportClasses.SkinnableComponent;
	
	import valueObjects.PhoneVO;
	
	
	[Event(name="getPhone", type="lib.CustomEvent")]
	[Event(name="close", type="flash.events.Event")]
	/* A component must identify the view states that its skin supports. 
	Use the [SkinState] metadata tag to define the view states in the component class. 
	[SkinState("normal")] */
	[SkinState("normal")]
	[SkinState("phones")]
	
	public class Paste extends SkinnableComponent
	{
		/* To declare a skin part on a component, you use the [SkinPart] metadata. 
		[SkinPart(required="true")] */
		[SkinPart(required="true")] public var ta:TextArea;
		[SkinPart(required="true")] public var phones:TextArea;
		[SkinPart(required="true")] public var send:Button;
		[SkinPart(required="true")] public var close:Button;
		
		private var state:String = "normal";
		private var arrPhone:Array;
		
		public function Paste()
		{
			//TODO: implement function
			super();
			setStyle("skinClass", PasteSkin);
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
			if (instance == ta) ta.addEventListener(KeyboardEvent.KEY_UP, ta_keyboardUpHandler);
			else if (instance == phones) {
				phones.editable = false;
				phones.text = arrPhone.join("\n");
			}
			else if (instance == send) send.addEventListener(MouseEvent.CLICK, send_clickHandler);
			else if (instance == close)	close.addEventListener(MouseEvent.CLICK, close_clickHandler);
		}
		
		/* Implement the partRemoved() method to remove the even handlers added in partAdded() */
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
			if (instance == ta) ta.removeEventListener(KeyboardEvent.KEY_UP, ta_keyboardUpHandler);
			else if (instance == send) send.removeEventListener(MouseEvent.CLICK, send_clickHandler);
			else if (instance == close)	close.removeEventListener(MouseEvent.CLICK, close_clickHandler);
		}
		
		private function ta_keyboardUpHandler(event:KeyboardEvent):void {
			var onlyNumber:RegExp = /[^\d]/g;
			var number:String = ta.text.replace(onlyNumber, '');
			var chkPhoneNum:RegExp = /0[17][016789]-?\d{3,4}-?\d{4}/g;
			var nextStat:String;
			
			arrPhone = number.match(chkPhoneNum);
			
			if (arrPhone != null && arrPhone.length > 0) {
				nextStat = "phones";
				if (phones) phones.text = arrPhone.join("\n");
			}
			else nextStat = "normal";

			if (state != nextStat){
				state = nextStat;
				this.invalidateSkinState();
			}
				
			
		}
		
		private function send_clickHandler(event:MouseEvent):void {
			
			if (ta.text == "") {
				SLibrary.alert("입력하거나 붙여넣으세요.");
			} 
			else {
				dispatchPhone();
			}
			
		}
		
		private function dispatchPhone():void {
			
			if (phones.text == ""){
				SLibrary.alert("형식에 맞는 전화번호가 없습니다.");
			}else {
				var ac:ArrayCollection = new ArrayCollection();
				var pvo:PhoneVO = null;
				var arr:Array = phones.text.split("\n");
				if (arr != null) {
					var cnt:int = arr.length;
					for (var i:int = 0; i < cnt; i++) {
						pvo = new PhoneVO();
						pvo.pNo = arr[i] as String;
						pvo.pName = "";
						ac.addItem(pvo);
					}
					this.dispatchEvent( new CustomEvent("getPhone", ac) );
				}
			}
		}
		
		private function close_clickHandler(event:MouseEvent):void {
			this.dispatchEvent(new Event("close"));
		}
		
	}
}