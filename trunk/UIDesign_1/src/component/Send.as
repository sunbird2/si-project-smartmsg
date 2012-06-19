package component
{
	
	import component.send.Emoticon;
	import component.send.ReturnPhone;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import lib.CustomEvent;
	import lib.Gv;
	import lib.KoreaPhoneNumberFormatter;
	import lib.Paging;
	import lib.RemoteManager;
	import lib.SLibrary;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	import mx.rpc.events.ResultEvent;
	
	import spark.components.Button;
	import spark.components.CheckBox;
	import spark.components.ComboBox;
	import spark.components.List;
	import spark.components.RichEditableText;
	import spark.components.RichText;
	import spark.components.TextInput;
	import spark.components.TileGroup;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.IndexChangeEvent;
	
	import valueObjects.BooleanAndDescriptionVO;
	import valueObjects.PhoneVO;
	import valueObjects.SendMessageVO;
	
	
	[SkinState("message")]
	[SkinState("sendList")]
	[SkinState("send")]
	
	public class Send extends SkinnableComponent
	{
		/* To declare a skin part on a component, you use the [SkinPart] metadata. 
		[SkinPart(required="true")] */
		
		// message
		[SkinPart(required="false")]public var message:RichEditableText;
		[SkinPart(required="false")]public var byte:RichText;
		[SkinPart(required="false")]public var messageSaveBtn:Button;
		[SkinPart(required="false")]public var specialChar:RichText;
		[SkinPart(required="false")]public var specialCharGroup:TileGroup;
		[SkinPart(required="false")]public var myMessage:RichText;
		[SkinPart(required="false")]public var sentMessage:RichText;
		[SkinPart(required="false")]public var emoticon:RichText;
		[SkinPart(required="false")]public var category:List;
		[SkinPart(required="false")]public var msgBox:List;
		[SkinPart(required="false")]public var paging:Paging;
		
		
		// phones
		[SkinPart(required="false")]public var sendListInput:TextInput;
		[SkinPart(required="false")]public var sendListInputBtn:Button;
		[SkinPart(required="false")]public var sendList:List;
		[SkinPart(required="false")]public var countPhone:RichText;
		[SkinPart(required="false")]public var sendListFromAddress:RichText;
		[SkinPart(required="false")]public var sendListFromExcel:RichText;
		[SkinPart(required="false")]public var sendListFromSent:RichText;
		[SkinPart(required="false")]public var sendListFromCopy:RichText;
		[SkinPart(required="false")]public var dupleDelete:Button;
		
		
		// callback
		[SkinPart(required="false")]public var callback:ComboBox;
		[SkinPart(required="false")]public var callbackSave:Button;
		
		
		
		// sendBtn
		[SkinPart(required="false")]public var sendReservation:CheckBox;
		[SkinPart(required="false")]public var sendInterval:CheckBox;
		[SkinPart(required="false")]public var sendBtn:Button;
		[SkinPart(required="false")]public var resetBtn:Button;
		
		
		
		[SkinPart(required="false")]public var helpText:RichText;
		[SkinPart(required="false")]public var subHelpText:RichText;
		
		
		/**
		 * message properties 
		 * */
		private var _sendMode:String = "SMS";
		private function get maxByte():Number {
			var bt:uint = 0;
			if (sendMode == "LMS") bt =  Gv.LMS_BYTE;
			else if (sendMode == "MMS") bt =  Gv.MMS_BYTE;
			else bt =  Gv.SMS_BYTE;
			
			return bt;
		}
		private var _currentByte:int = 0;
		
		public function get msg():String { return message.text; }
		public function set msg(value:String):void {
			message.text = value; 
			msg_ByteCheck();
		}
		
		public function msg_ByteCheck():void {			
			this.currentByte = SLibrary.getByte(this.msg);
			isValid();
		}
		
		public function get sendMode():String {	return _sendMode; }
		public function set sendMode(value:String):void	{ _sendMode = value; }
		
		public function get currentByte():int {	return _currentByte; }
		public function set currentByte(value:int):void	{ _currentByte = value; this.byte.text = String( value ); }
		
		
		/**
		 * phones properties
		 * */
		[Bindable]
		private var alPhone:ArrayCollection = new ArrayCollection();
		private var Kpf:KoreaPhoneNumberFormatter = new KoreaPhoneNumberFormatter();
		
		
		/**
		 * emoticon properties
		 * */
		private var emt:Emoticon;
		
		
		/**
		 * returnPhone properties
		 * */
		public var rt:ReturnPhone;

		public function Send() { 
			super();
			emt = new Emoticon();
			rt = new ReturnPhone();
			
		}
		override protected function getCurrentSkinState():String { return super.getCurrentSkinState(); } 
		override protected function partAdded(partName:String, instance:Object) : void {
			
			super.partAdded(partName, instance);
			
			if (instance == specialChar) specialChar.addEventListener(MouseEvent.CLICK, specialChar_clickHandler );
			else if (instance == message) message.addEventListener(KeyboardEvent.KEY_UP, message_keyUpHandlerAutoMode);
			else if (instance == sendListInput)	sendListInput.addEventListener(FlexEvent.ENTER, sendListInput_enterHandler);
			else if (instance == sendListInputBtn) sendListInputBtn.addEventListener(MouseEvent.CLICK, sendListInput_enterHandler);
			else if (instance == dupleDelete) dupleDelete.addEventListener(MouseEvent.CLICK, dupleDelete_clickHandler);
			else if (instance == sendList) sendList.dataProvider = alPhone;
			else if (instance == callback) callback.addEventListener(IndexChangeEvent.CHANGE, callback_changeHandler);
			else if (instance == sendBtn) sendBtn.addEventListener(MouseEvent.CLICK, sendBtn_clickHandler);
			else if (instance == emoticon) emoticon.addEventListener(MouseEvent.CLICK, emt.emoticon_clickHandler);
			else if (instance == category) category.addEventListener(IndexChangeEvent.CHANGE, emt.category_changeHandler);
			else if (instance == paging) paging.addEventListener("clickPage", emt.paging_clickPageHandler);
			else if (instance == msgBox) msgBox.addEventListener(IndexChangeEvent.CHANGE, msgBox_changeHandler);
			else if (instance == myMessage) myMessage.addEventListener(MouseEvent.CLICK, emt.myMessage_clickHandler);
			else if (instance == messageSaveBtn) messageSaveBtn.addEventListener(MouseEvent.CLICK, messageSaveBtn_clickHandler);
			else if (instance == sentMessage) sentMessage.addEventListener(MouseEvent.CLICK, emt.sentMessage_clickHandler);
			else if (instance == callbackSave) callbackSave.addEventListener(MouseEvent.CLICK, rt.callbackSave_clickHandler);
			

		}
		override protected function partRemoved(partName:String, instance:Object) : void {
			
			super.partRemoved(partName, instance);
			
			if (instance == specialChar) specialChar.removeEventListener(MouseEvent.CLICK, specialChar_clickHandler );
			else if (instance == message) message.removeEventListener(KeyboardEvent.KEY_UP, message_keyUpHandlerAutoMode);
			else if (instance == sendListInput)	sendListInput.removeEventListener(FlexEvent.ENTER, sendListInput_enterHandler);
			else if (instance == sendListInputBtn) sendListInputBtn.removeEventListener(MouseEvent.CLICK, sendListInput_enterHandler);
			else if (instance == dupleDelete) dupleDelete.removeEventListener(MouseEvent.CLICK, dupleDelete_clickHandler);
			else if (instance == callback) callback.removeEventListener(IndexChangeEvent.CHANGE, callback_changeHandler);
			else if (instance == sendBtn) sendBtn.removeEventListener(MouseEvent.CLICK, sendBtn_clickHandler);
			else if (instance == emoticon) emoticon.removeEventListener(MouseEvent.CLICK, emt.emoticon_clickHandler);
			else if (instance == category) category.removeEventListener(IndexChangeEvent.CHANGE, emt.category_changeHandler);
			else if (instance == paging) paging.removeEventListener("clickPage", emt.paging_clickPageHandler);
			else if (instance == msgBox) msgBox.removeEventListener(IndexChangeEvent.CHANGE, msgBox_changeHandler);
			else if (instance == myMessage) myMessage.removeEventListener(MouseEvent.CLICK, emt.myMessage_clickHandler);
			else if (instance == messageSaveBtn) messageSaveBtn.removeEventListener(MouseEvent.CLICK, messageSaveBtn_clickHandler);
			else if (instance == sentMessage) sentMessage.removeEventListener(MouseEvent.CLICK, emt.sentMessage_clickHandler);
			else if (instance == callbackSave) callbackSave.removeEventListener(MouseEvent.CLICK, rt.callbackSave_clickHandler);
			
			
		}
		override protected function createChildren():void
		{
			// TODO Auto Generated method stub
			super.createChildren();
			emt.category = category;
			emt.msgBox = msgBox;
			emt.paging = paging;
			
			callback.labelField = "phone";
			rt.callback = this.callback;
			rt.getReturnPhone();
			
			
		}
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void	{
			
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			isValid();
		}
		
		
		/**
		 * global function
		 * */
		public function isValid():void {
			
			var validMessage:String = "";
			
			if ( Gv.bLogin == false ) validMessage = "로그인 후 이용 가능 합니다.";
			else if ( msg == "" ) validMessage = "메시지를 입력 하세요.";
			else if (this.alPhone.length <= 0) validMessage = "전화번호를 입력하세요.";
			else if (rt.returnPhone == "") validMessage = "회신번호를 입력하세요.";
			else {
				validMessage = "보내기 버튼을 누르면 전송 됩니다.";
				sendBtn.enabled = true;
			}
			helpText.text = validMessage;
			
		}
		
		/**
		 * message function
		 * */
		protected function message_keyUpHandlerAutoMode(event:KeyboardEvent):void {
			
			msg_ByteCheck();
			if ( currentByte > Gv.SMS_BYTE ) sendMode = "LMS";
			if ( currentByte > Gv.LMS_BYTE) {
				//trace("cutByte!!"+currentByte+"/"+this.maxByte);
				this.msg = SLibrary.cutByteTo(this.msg, this.maxByte);
			}
		}
		
		
		/**
		 * phone function
		 * */
		public function addPhone(phone:String, pname:String):void {
			alPhone.addItem(getPvo(phone, pname));
			setTotalCount();
		}
		public function addPhoneList(ac:ArrayCollection):void {
			alPhone = ac;
			setTotalCount();
		}
		protected function sendListInput_enterHandler(event:Event):void {
			
			if ( alPhone ) {
				
				if (sendListInput.text != "") {
					if (SLibrary.bKoreaPhoneCheck( sendListInput.text )) {
						addPhone(sendListInput.text, "");
						sendListInput.text = "";
					}
					else SLibrary.alert("잘못된 전화번호 입니다.");
				}
				else
					SLibrary.alert("전화번호를 입력하세요.");
			}
				
		}
		private function getPvo(pno:String, pname:String):PhoneVO {
			
			var pvo:PhoneVO = new PhoneVO;
			pvo.pName = pname;
			pvo.pNo = pno;
			
			return pvo;
		}
		public function removePhone(pvo:PhoneVO):void {	this.alPhone.removeItemAt( this.alPhone.getItemIndex(pvo) ); }
		public function phoneFormat(ph:String):String {	return Kpf.format(ph);	}
		private function setTotalCount():void { 
			this.countPhone.text = new String(this.alPhone.length);
			this.isValid();
		}
		private function dupleDelete_clickHandler(event:Event):void {
			var cnt:int = alPhone.length;
			var arr:ArrayCollection = new ArrayCollection();
			var tempStr:String = "";
			var dupCnt:Number = 0;
			
			var vo:PhoneVO = null;
			for (var i:int = 0; i < cnt; i++) {
				
				vo = alPhone.getItemAt(i) as PhoneVO;
				if (tempStr.search(vo.pNo) == -1) {
					arr.addItem(vo);
					tempStr += vo.pNo + " ";
				}else {
					dupCnt++;
				}
				
			}
			alPhone = arr;
			setTotalCount();
			SLibrary.alert(dupCnt + " 건의 중복번호가 제거 되었습니다.");
		}
		
		
		/**
		 * specialChar function
		 * */
		private function specialChar_clickHandler(event:MouseEvent):void { charToggle(); }
		private function charToggle():void {
			
			var cnt:uint = Gv.spcData.length;
			var char:RichText = null;
			var i:int = 0;
			if (specialCharGroup.visible) {
				
				for ( i = 0; i < cnt; i++) {
					specialCharGroup.getElementAt(i).removeEventListener(MouseEvent.CLICK, charClickHandler);
				}
				specialCharGroup.removeAllElements();
				
				specialCharGroup.visible = false;
			}else {
				
				for ( i = 0; i < cnt; i++) {
					char = new RichText();
					char.text = Gv.spcData[i];
					char.setStyle("fontSize",20);
					
					specialCharGroup.addElement(char);
					char.addEventListener(MouseEvent.CLICK, charClickHandler);
				}
				
				specialCharGroup.visible = true;
			}
			
		}
		protected function charClickHandler(e:MouseEvent):void { this.msg += RichText(e.currentTarget).text; }
		
		/**
		 * save message
		 * */
		public function messageSaveBtn_clickHandler(event:MouseEvent):void {
			
			if (message.text != "") {
				RemoteManager.getInstance.result = messageSaveBtn_resultHandler;
				RemoteManager.getInstance.callresponderToken 
					= RemoteManager.getInstance.service.saveMymsg(message.text);
			}else {
				SLibrary.alert("메시지를 입력 후 저장하세요.");
			}
		}
		private function messageSaveBtn_resultHandler(event:ResultEvent):void {
			
			var bvo:BooleanAndDescriptionVO = event.result as BooleanAndDescriptionVO;
			if (bvo.bResult) {
				SLibrary.alert("저장되었습니다.");
				if (msgBox.visible && emt.gubun == "my")
					emt.myMessage_clickHandler(null);
			}else {
				SLibrary.alert("실패");
			}
		}
		
		/**
		 * delete message
		 * */
		public function delMymessage(idx:int):void {
			if (idx != 0) {
				RemoteManager.getInstance.result = delMymessage_resultHandler;
				RemoteManager.getInstance.callresponderToken 
					= RemoteManager.getInstance.service.delMymsg(idx);
			}else {
				SLibrary.alert("키가 없습니다.");
			}
		}
		private function delMymessage_resultHandler(event:ResultEvent):void {
			
			var bvo:BooleanAndDescriptionVO = event.result as BooleanAndDescriptionVO;
			if (bvo.bResult) {
				SLibrary.alert("삭제되었습니다.");
				if (msgBox.visible && emt.gubun == "my")
					emt.myMessage_clickHandler(null);
			}else {
				SLibrary.alert("실패");
			}
		}
		
		/**
		 * returnPhone function
		 * */
		private function callback_changeHandler(event:Event):void { isValid(); }
		
		
		
		/**
		 * send function
		 * */
		private function sendBtn_clickHandler(event:MouseEvent):void {
			
			var smvo:SendMessageVO = new SendMessageVO();
			
			smvo.bInterval = false;
			smvo.bMerge = false;
			smvo.bReservation = false;
			smvo.message = msg;
			smvo.returnPhone = rt.returnPhone;
			smvo.al = alPhone;
			
			RemoteManager.getInstance.result = sendBtn_resultHandler;
			RemoteManager.getInstance.callresponderToken 
				= RemoteManager.getInstance.service.sendSMSconf(smvo);
		}
		private function sendBtn_resultHandler(event:ResultEvent):void {
			
		}
		
		
		
		/**
		 * emoticon function
		 * */
		private function msgBox_changeHandler(event:IndexChangeEvent):void {
			var obj:Object = msgBox.selectedItem as Object;
			msg = obj.msg;
		}
		
		
	}
}