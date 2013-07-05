package component
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import lib.CustomEvent;
	import lib.RemoteSingleManager;
	import lib.SLibrary;
	
	import mx.events.FlexEvent;
	import mx.validators.StringValidator;
	import mx.validators.ValidationResult;
	
	import skin.JoinSkin;
	
	import spark.components.Button;
	import spark.components.CheckBox;
	import spark.components.ComboBox;
	import spark.components.FormItem;
	import spark.components.Label;
	import spark.components.TextInput;
	import spark.components.supportClasses.SkinnableComponent;
	
	import valueObjects.BooleanAndDescriptionVO;
	
	
	[Event(name="complete", type="flash.events.Event")]
	[Event(name="cancel", type="flash.events.Event")]
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
		[SkinPart(required="false")]public var sec:Label;
		
		[SkinPart(required="false")]public var certItem:FormItem;
		[SkinPart(required="false")]public var certBtn:Button;
		[SkinPart(required="false")]public var certNumber:TextInput;
		[SkinPart(required="false")]public var certh:Label;
		
		private var inTimer:Timer;
		
		private var VALID_COLOR:Number = 0x33B5E5;
		private var INVALID_COLOR:Number = 0xFF4444;
		
		private var _step:uint = 0;
		public function get step():uint { return _step; }
		public function set step(value:uint):void { _step = value; }
		
		private var sv:StringValidator = new StringValidator();

		
		public function Join()
		{
			super();
			setStyle("skinClass", JoinSkin);
			addEventListener(Event.REMOVED_FROM_STAGE, destory, false, 0, true);
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
			/*else if (instance == agree1) agree1.addEventListener( Event.CHANGE, autoNext1 );
			else if (instance == agree2) agree2.addEventListener( Event.CHANGE, autoNext1 );*/
			else if (instance == cancel1) cancel1.addEventListener( MouseEvent.CLICK, cancel_clickHandler );
			else if (instance == userid) userid.addEventListener(KeyboardEvent.KEY_UP, userid_keyUpHandler );
			else if (instance == userpw) userpw.addEventListener(KeyboardEvent.KEY_UP, userpw_keyUpHandler);
			else if (instance == userrepw) userrepw.addEventListener(KeyboardEvent.KEY_UP, userrepw_keyUpHandler);
			else if (instance == userhp2) {
				userhp2.maxChars = 4;
				userhp2.addEventListener(KeyboardEvent.KEY_UP, tiHp_keyUpHandler);
			}
			else if (instance == userhp3) {
				userhp3.maxChars = 4;
				userhp3.addEventListener(KeyboardEvent.KEY_UP, tiHp_keyUpHandler);
			}
			else if (instance == certBtn) {
				certBtn.addEventListener(MouseEvent.CLICK, certBtn_clickHandler);
			}
			else if (instance == certNumber) {
				certNumber.maxChars = 5;
				certNumber.addEventListener(KeyboardEvent.KEY_UP, certNumber_keyUpHandler);
			}
			
			else if (instance == next2) next2.addEventListener(MouseEvent.CLICK, next2_clickHandler);
			else if (instance == sec) autoIn();
			else if (instance == cancel2) cancel2.addEventListener(MouseEvent.CLICK, cancel_clickHandler);
			
			
		}
		
		override protected function partRemoved(partName:String, instance:Object) : void {
			super.partRemoved(partName, instance);
			if (instance == next1) next1.removeEventListener( MouseEvent.CLICK, next1_clickHandler );
			/*else if (instance == agree1) agree1.removeEventListener( Event.CHANGE, autoNext1 );
			else if (instance == agree2) agree2.removeEventListener( Event.CHANGE, autoNext1 );*/
			else if (instance == cancel1) cancel1.removeEventListener( MouseEvent.CLICK, cancel_clickHandler );
			else if (instance == userid) userid.removeEventListener(KeyboardEvent.KEY_UP, userid_keyUpHandler );
			else if (instance == userpw) userpw.removeEventListener(KeyboardEvent.KEY_UP, userpw_keyUpHandler);
			else if (instance == userrepw) userrepw.removeEventListener(KeyboardEvent.KEY_UP, userrepw_keyUpHandler);
			else if (instance == userhp2) {
				userhp2.maxChars = 4;
				userhp2.removeEventListener(KeyboardEvent.KEY_UP, tiHp_keyUpHandler);
			}
			else if (instance == userhp3) {
				userhp3.maxChars = 4;
				userhp3.removeEventListener(KeyboardEvent.KEY_UP, tiHp_keyUpHandler);
			}
			else if (instance == certBtn) {
				certBtn.removeEventListener(MouseEvent.CLICK, certBtn_clickHandler);
			}
			else if (instance == certNumber) {
				certNumber.maxChars = 5;
				certNumber.removeEventListener(KeyboardEvent.KEY_UP, certNumber_keyUpHandler);
			}
			else if (instance == next2) next2.removeEventListener(MouseEvent.CLICK, next2_clickHandler);
			else if (instance == sec) {
				inTimer.stop();
				inTimer.removeEventListener("timer", timerHandler);
			}
			else if (instance == cancel2) cancel2.removeEventListener(MouseEvent.CLICK, cancel_clickHandler);
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void	{
			
			super.updateDisplayList(unscaledWidth, unscaledHeight);
		}
		
		private function tracker(msg:String):void {
			MunjaNote(parentApplication).googleTracker("join/"+msg);
		}
		
		private function autoNext1(event:Event):void {
			
			if (agree1.selected == true && agree2.selected == true) {
				step = 1;
				invalidateSkinState();
			}
		}
		
		/**
		 * agree handler
		 * */
		private function next1_clickHandler(event:MouseEvent):void {
			
			if (agree1.selected == false) SLibrary.alert("이용약관에 동의해 주세요");
			else if (agree2.selected == false) SLibrary.alert("개인정보에 동의해 주세요");
			else {
				tracker("joinStart");
				step = 1;
				invalidateSkinState();
			}
		}
		/**
		 * cancel
		 * */
		private function cancel_clickHandler(event:MouseEvent):void { dispatchEvent(new Event("cancel")); }
		
		
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
				
				useridh.setStyle("color",INVALID_COLOR);
				useridh.text = ValidationResult(arr[0]).errorMessage;
			}else {
				
				useridh.text = "확인";
				useridh.setStyle("color",VALID_COLOR);
				dupleIdCheck(ti.text);
			}
		}
		/**
		 * userid duple valid
		 * */
		private function dupleIdCheck(id:String):void {
			
			if (id != "") {
				RemoteSingleManager.getInstance.addEventListener("checkID", idCheck_CustomEventHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.checkID(id);
			}
		}
		private function idCheck_CustomEventHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("checkID", idCheck_CustomEventHandler);
			var bVO:BooleanAndDescriptionVO = event.result as BooleanAndDescriptionVO;
			if (bVO.bResult) {
				useridh.setStyle("color",VALID_COLOR);
				useridh.text = "확인";
			} else {
				useridh.setStyle("color",INVALID_COLOR);
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
				userpwh.setStyle("color",INVALID_COLOR);
				userpwh.text = ValidationResult(arr[0]).errorMessage;
			}else {
				userpwh.setStyle("color",VALID_COLOR);
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
				userrepwh.setStyle("color",INVALID_COLOR);
				userrepwh.text = ValidationResult(arr[0]).errorMessage;
			}else {
				if (userpw.text == ti.text) {
					userrepwh.setStyle("color",VALID_COLOR);
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
			sv.minLength = 10;
			sv.maxLength = 11;
			sv.tooShortError = "10자리 이상 입력하세요";
			sv.tooLongError = "13자리 이상 입력하실 수 없습니다.";
			
			var arr:Array = StringValidator.validateString(sv, phone);
			
			if (arr.length > 0) {
				userhph.setStyle("color",INVALID_COLOR);
				userhph.text = ValidationResult(arr[0]).errorMessage;
				
				showCert(false);
			}else {
				userhph.setStyle("color",VALID_COLOR);
				userhph.text = "확인";
				
				showCert(true);
			}
			
			// focus move
			var tg:TextInput = TextInput(event.currentTarget);
			if (tg.id == "userhp2" && tg.text.length == 4) userhp3.setFocus();
		}
		
		/**
		 * cert view
		 * */
		private function showCert(b:Boolean):void {
			
			if (b == true) {
				certItem.visible = true;
				certBtn.visible = true;
				certNumber.visible = false;	
			} else {
				certItem.visible = false;
			}
			
		}
		
		/**
		 * request certNumber
		 * */
		private function certBtn_clickHandler(event:MouseEvent):void {
			
			var phone:String = String(userhp1.selectedItem.data)+userhp2.text+userhp3.text;
			if (phone != "" && userid.text != "") {
				RemoteSingleManager.getInstance.addEventListener("sendCert", certBtn_CustomEventHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.sendCert(userid.text, phone);
			} else {
				SLibrary.alert("아이디와 휴대폰번호를 입력해 주세요.");
			}
		}
		private function certBtn_CustomEventHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("sendCert", idCheck_CustomEventHandler);
			var bVO:BooleanAndDescriptionVO = event.result as BooleanAndDescriptionVO;
			if (bVO.bResult) {
				tracker("joinCertSend");
				certh.setStyle("color",INVALID_COLOR);
				certh.text = "인증번호를 입력해 주세요.";
				
				certBtn.visible = false;
				certNumber.visible = true;
				
			} else {
				certh.setStyle("color",INVALID_COLOR);
				certh.text = bVO.strDescription;
			}
		}
		
		/**
		 * certNumber valid
		 * */
		protected function certNumber_keyUpHandler(event:KeyboardEvent):void
		{
			var cert:String = certNumber.text;
			sv.minLength = 5;
			sv.maxLength = 5;
			sv.tooShortError = "5자리 입력하세요";
			sv.tooLongError = "5자리 입력하세요";
			
			var arr:Array = StringValidator.validateString(sv, cert);
			
			if (arr.length > 0) {
				certh.setStyle("color",INVALID_COLOR);
				certh.text = ValidationResult(arr[0]).errorMessage;
				
			}else {
				certh.setStyle("color",VALID_COLOR);
				certh.text = "확인";
				certCheck();
			}
		}
		
		/**
		 * certNumber server valid
		 * */
		private function certCheck():void {
			
			var uid:String = userid.text;
			var cn:String = certNumber.text;
			
			if (uid != "" && cn != "") {
				RemoteSingleManager.getInstance.addEventListener("getCert", certCheck_CustomEventHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.getCert(uid, cn);
			}
		}
		private function certCheck_CustomEventHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("getCert", certCheck_CustomEventHandler);
			var bVO:BooleanAndDescriptionVO = event.result as BooleanAndDescriptionVO;
			if (bVO.bResult) {
				tracker("joinCertOk");
				certh.setStyle("color",VALID_COLOR);
				certh.text = "확인";
			} else {
				certh.setStyle("color",INVALID_COLOR);
				certh.text = "잘못된 인증번호 입니다.";
			}
		}
		
		/**
		 * all valid
		 * */
		private function checkAll():Boolean {
			
			var b:Boolean = false;
			if (useridh.getStyle("color") == VALID_COLOR 
				&&userpwh.getStyle("color") == VALID_COLOR
				&&userrepwh.getStyle("color") == VALID_COLOR
				&&userhph.getStyle("color") == VALID_COLOR
				&&certh.getStyle("color") == VALID_COLOR
			) b = true;
			
			return b;
		}
		
		
		/**
		 * join service call
		 * */
		private function next2_clickHandler(event:MouseEvent):void {
			
			if (checkAll() == false) SLibrary.alert("붉은색 부분을 확인해 주세요.");
			else {
				RemoteSingleManager.getInstance.addEventListener("join", next2_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.join(userid.text, userpw.text, userrepw.text, String(userhp1.selectedItem.data)+userhp2.text+userhp3.text);
			}
		}
		private function next2_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("join", next2_resultHandler);
			var bVO:BooleanAndDescriptionVO = event.result as BooleanAndDescriptionVO;
			if (bVO.bResult) {
				tracker("joinComplete");
				step = 2;
				invalidateSkinState();
				
			} else {
				SLibrary.alert("가입 실패");
			}
			
		}
		
		
		
		private function autoIn():void {
			inTimer = new Timer(1000, 5);
			inTimer.addEventListener("timer", timerHandler);
			inTimer.start();
		}
		
		private function timerHandler(event:TimerEvent):void {
			
			var num:Number = Number(sec.text);
			num--;
			sec.text = String(num);
			
			if (num <= 0) {
				inTimer.stop();
				inTimer.removeEventListener("timer", timerHandler);
				dispatchEvent(new Event("complete"));
			}
			
		}
		
		
		public function destory(e:Event):void {
			
			removeEventListener(Event.REMOVED_FROM_STAGE, destory);
			agree1 = null;
			agree2 = null;
			next1 = null;
			cancel1 = null;
			userid = null;
			useridh = null;
			userpw = null;
			userpwh = null;
			userrepw = null;
			userrepwh = null;
			userhp1 = null;
			userhp2 = null;
			userhp3 = null;
			userhph = null;
			next2 = null;
			cancel2 = null;
			
			sv = null;
			if (inTimer)
				inTimer.removeEventListener("timer", timerHandler);
		}
		
		
	}
}