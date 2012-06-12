package component
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import lib.BooleanAndDescriptionVO;
	import lib.RemoteManager;
	import lib.SLibrary;
	
	import mx.rpc.events.ResultEvent;
	import mx.validators.StringValidator;
	import mx.validators.ValidationResult;
	
	import spark.components.Button;
	import spark.components.CheckBox;
	import spark.components.ComboBox;
	import spark.components.Label;
	import spark.components.TextInput;
	import spark.components.supportClasses.SkinnableComponent;
	
	
	/* A component must identify the view states that its skin supports. 
	Use the [SkinState] metadata tag to define the view states in the component class. 
	[SkinState("normal")] */
	[SkinState("step1")]
	[SkinState("step2")]
	[SkinState("step3")]
	
	public class Join extends SkinnableComponent
	{
		/* To declare a skin part on a component, you use the [SkinPart] metadata. 
		[SkinPart(required="true")] */
		[SkinPart(required="false")]public var agree1:CheckBox;
		[SkinPart(required="false")]public var agree2:CheckBox;
		[SkinPart(required="false")]public var next1:Button;
		[SkinPart(required="false")]public var cancel1:Button;
		[SkinPart(required="false")]public var userid:TextInput;
		[SkinPart(required="false")]public var useridh:Label;
		[SkinPart(required="false")]public var userpw:TextInput;
		[SkinPart(required="false")]public var userpwh:Label;
		[SkinPart(required="false")]public var userrepw:TextInput;
		[SkinPart(required="false")]public var userrepwh:Label;
		[SkinPart(required="false")]public var userhp1:ComboBox;
		[SkinPart(required="false")]public var userhp2:TextInput;
		[SkinPart(required="false")]public var userhp3:TextInput;
		[SkinPart(required="false")]public var userhph:Label;
		[SkinPart(required="false")]public var next2:Button;
		[SkinPart(required="false")]public var cancel2:Button;
		
		private var VALID_COLOR:Number = 0x0000FF;
		private var INVALID_COLOR:Number = 0xFF0000;
		
		private var _step:uint = 0;
		public function get step():uint { return _step; }
		public function set step(value:uint):void { _step = value; }
		
		private var sv:StringValidator = new StringValidator();

		
		public function Join()
		{
			super();
		}
		
		/* Implement the getCurrentSkinState() method to set the view state of the skin class. */
		override protected function getCurrentSkinState():String
		{
			var stat:String = "";
			switch(step){
				
				case 0:	{ stat = "step1"; break; }
				case 1:	{ stat = "step2"; break; }
				case 2:	{ stat = "step3"; break; }
				default:{ stat = "step1"; }
			}
			return stat;
		} 

		override protected function partAdded(partName:String, instance:Object) : void {
			
			super.partAdded(partName, instance);
			if (instance == next1) next1.addEventListener( MouseEvent.CLICK, next1_clickHandler );
			else if (instance == cancel1) cancel1.addEventListener( MouseEvent.CLICK, cancel1_clickHandler );
			else if (instance == userid) userid.addEventListener(KeyboardEvent.KEY_UP, userid_keyUpHandler );
			else if (instance == userpw) userpw.addEventListener(KeyboardEvent.KEY_UP, userpw_keyUpHandler);
			else if (instance == userrepw) userrepw.addEventListener(KeyboardEvent.KEY_UP, userrepw_keyUpHandler);
			else if (instance == userhp2) userhp2.addEventListener(KeyboardEvent.KEY_UP, tiHp_keyUpHandler);
			else if (instance == userhp3) userhp3.addEventListener(KeyboardEvent.KEY_UP, tiHp_keyUpHandler);
			else if (instance == next2) next2.addEventListener(MouseEvent.CLICK, next2_clickHandler);
			
			
			
			
		}
		
		override protected function partRemoved(partName:String, instance:Object) : void {
			super.partRemoved(partName, instance);
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void	{
			
			super.updateDisplayList(unscaledWidth, unscaledHeight);
		}
		
		/**
		 * agree handler
		 * */
		private function next1_clickHandler(event:MouseEvent):void {
			
			if (agree1.selected == false) SLibrary.alert("이용약관에 동의해 주세요");
			else if (agree1.selected == false) SLibrary.alert("이용약관에 동의해 주세요");
			else {
				step = 1;
				invalidateSkinState();
			}
		}
		/**
		 * cancel
		 * */
		private function cancel1_clickHandler(event:MouseEvent):void {
			this.visible = false;
		}
		
		
		/**
		 * userid valid
		 * */
		private function userid_keyUpHandler(event:KeyboardEvent):void {
			
			var ti:TextInput = TextInput(event.currentTarget);
			sv.minLength = 4;
			sv.maxLength = 12;
			sv.tooShortError = "4자리 이상 입력하세요";
			sv.tooLongError = "12자리 이상 입력하실 수 없습니다.";
			
			var arr:Array = StringValidator.validateString(sv, ti.text);
			
			if (arr.length > 0) {
				
				ti.setStyle("borderColor",INVALID_COLOR);
				useridh.text = ValidationResult(arr[0]).errorMessage;
			}else {
				
				useridh.text = "";
				dupleIdCheck(ti.text);
			}
		}
		/**
		 * userid duple valid
		 * */
		private function dupleIdCheck(id:String):void {
			
			if (id != "") {
				RemoteManager.getInstance.result = idCheck_ResultEventHandler;
				RemoteManager.getInstance.callresponderToken 
					= RemoteManager.getInstance.service.checkID(id);
			}
		}
		private function idCheck_ResultEventHandler(event:ResultEvent):void {
			
			var bVO:BooleanAndDescriptionVO = event.result as BooleanAndDescriptionVO;
			if (bVO.bResult) {
				userid.setStyle("borderColor",VALID_COLOR);
				useridh.text = "확인";
			} else {
				userid.setStyle("borderColor",INVALID_COLOR);
				useridh.text = "사용할수 없는 아이디 입니다.";
			}
		}

		/**
		 * userpw valid
		 * */
		protected function userpw_keyUpHandler(event:KeyboardEvent):void
		{
			var ti:TextInput = TextInput(event.currentTarget);
			sv.minLength = 4;
			sv.maxLength = 12;
			sv.tooShortError = "4자리 이상 입력하세요";
			sv.tooLongError = "12자리 이상 입력하실 수 없습니다.";
			
			var arr:Array = StringValidator.validateString(sv, ti.text);
			
			if (arr.length > 0) {
				ti.setStyle("borderColor",INVALID_COLOR);
				userpwh.text = ValidationResult(arr[0]).errorMessage;
			}else {
				ti.setStyle("borderColor",VALID_COLOR);
				userpwh.text = "확인";
			}
		}
		/**
		 * userrepw valid
		 * */
		protected function userrepw_keyUpHandler(event:KeyboardEvent):void
		{
			var ti:TextInput = TextInput(event.currentTarget);
			sv.minLength = 4;
			sv.maxLength = 12;
			sv.tooShortError = "4자리 이상 입력하세요";
			sv.tooLongError = "12자리 이상 입력하실 수 없습니다.";
			
			var arr:Array = StringValidator.validateString(sv, ti.text);
			
			if (arr.length > 0) {
				ti.setStyle("borderColor",INVALID_COLOR);
				userrepwh.text = ValidationResult(arr[0]).errorMessage;
			}else {
				if (userpw.text == ti.text) {
					ti.setStyle("borderColor",VALID_COLOR);
					userrepwh.text = "확인";
				}else {
					userrepwh.text = "비밀번호와 일치 하지 않습니다.";
				}
			}
		}
		/**
		 * hp valid
		 * */
		protected function tiHp_keyUpHandler(event:KeyboardEvent):void
		{
			var phone:String = String(userhp1.selectedItem.data)+userhp2.text+userhp3.text;
			sv.minLength = 4;
			sv.maxLength = 12;
			sv.tooShortError = "10자리 이상 입력하세요";
			sv.tooLongError = "13자리 이상 입력하실 수 없습니다.";
			
			var arr:Array = StringValidator.validateString(sv, phone);
			
			if (arr.length > 0) {
				userhp2.setStyle("borderColor",INVALID_COLOR);
				userhp3.setStyle("borderColor",INVALID_COLOR);
				userhph.text = ValidationResult(arr[0]).errorMessage;
			}else {
				userhp2.setStyle("borderColor",VALID_COLOR);
				userhp3.setStyle("borderColor",VALID_COLOR);
				userhph.text = "";
			}
		}
		
		
		/**
		 * all valid
		 * */
		private function checkAll():Boolean {
			
			var b:Boolean = false;
			if (userid.getStyle("borderColor") == VALID_COLOR 
				&&userpw.getStyle("borderColor") == VALID_COLOR
				&&userrepw.getStyle("borderColor") == VALID_COLOR
				&&userhp2.getStyle("borderColor") == VALID_COLOR
				&&userhp3.getStyle("borderColor") == VALID_COLOR
			) b = true;
			
			return b;
		}
		
		
		/**
		 * join service call
		 * */
		private function next2_clickHandler(event:MouseEvent):void {
			
			if (checkAll == false) SLibrary.alert("붉은색 부분을 확인해 주세요.");
			else {
				RemoteManager.getInstance.result = next2_resultHandler;
				RemoteManager.getInstance.callresponderToken 
					= RemoteManager.getInstance.service.join(userid.text, userpw.text, userrepw.text, String(userhp1.selectedItem.data) + userhp2.text + userhp3.text );
				
			}
		}
		private function next2_resultHandler(event:ResultEvent):void {
			
			step = 2;
			invalidateSkinState();
		}
		
		
	}
}