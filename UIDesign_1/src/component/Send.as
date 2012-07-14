package component
{
	
	import component.address.SendModeAddress;
	import component.emoticon.Emoticon;
	import component.excel.Excel;
	import component.log.SendModeLog;
	import component.paste.Paste;
	import component.send.Interval;
	import component.send.ReservationCalendar;
	import component.send.ReturnPhone;
	import component.util.CustomToolTip;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import flashx.textLayout.elements.LinkElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.events.FlowElementMouseEvent;
	
	import lib.CustomEvent;
	import lib.Gv;
	import lib.KoreaPhoneNumberFormatter;
	import lib.Paging;
	import lib.RemoteSingleManager;
	import lib.SLibrary;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;
	
	import spark.components.Button;
	import spark.components.CheckBox;
	import spark.components.ComboBox;
	import spark.components.Group;
	import spark.components.Label;
	import spark.components.List;
	import spark.components.RichEditableText;
	import spark.components.RichText;
	import spark.components.TextArea;
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
		
		[SkinPart(reqired='true')]public var contentGroup:Group;
		
		// message
		[SkinPart(required="false")]public var message:TextArea;
		[SkinPart(required="false")]public var byte:SpanElement;
		[SkinPart(required="false")]public var messageSaveBtn:LinkElement;
		[SkinPart(required="false")]public var specialChar:LinkElement;
		[SkinPart(required="false")]public var myMessage:LinkElement;
		[SkinPart(required="false")]public var sentMessage:LinkElement;
		[SkinPart(required="false")]public var emoticon:LinkElement;
		[SkinPart(required="false")]public var addImage:LinkElement;
		
		
		
		// phones
		[SkinPart(required="false")]public var sendListInput:TextInput;
		[SkinPart(required="false")]public var sendListInputBtn:Button;
		[SkinPart(required="false")]public var sendList:List;
		[SkinPart(required="false")]public var countPhone:SpanElement;
		[SkinPart(required="false")]public var sendListFromAddress:LinkElement;
		[SkinPart(required="false")]public var sendListFromExcel:LinkElement;
		[SkinPart(required="false")]public var sendListFromSent:LinkElement;
		[SkinPart(required="false")]public var sendListFromCopy:LinkElement;
		[SkinPart(required="false")]public var dupleDelete:LinkElement;
		[SkinPart(required="false")]public var phoneRemoveAll:LinkElement;
		
		
		
		// callback
		[SkinPart(required="false")]public var callback:ComboBox;
		[SkinPart(required="false")]public var callbackSave:LinkElement;
		
		
		
		// sendBtn
		[SkinPart(required="false")]public var sendReservation:CheckBox;
		[SkinPart(required="false")]public var sendInterval:CheckBox;
		[SkinPart(required="false")]public var sendBtn:Button;
		[SkinPart(required="false")]public var resetBtn:Button;
		[SkinPart(required="false")]public var confirm_mode:SpanElement;
		[SkinPart(required="false")]public var confirm_count:SpanElement;
		[SkinPart(required="false")]public var confirm_reservation:SpanElement;
		[SkinPart(required="false")]public var confirm_delay:SpanElement;
		
		
		
		
		[SkinPart(required="false")]public var helpText:RichText;
		[SkinPart(required="false")]public var subHelpText:RichText;
		
		public var reservation:ReservationCalendar;
		public var interval:Interval;
		
		private var customToolTip:CustomToolTip;
		
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
		public function set sendMode(value:String):void	{ _sendMode = value; confirm_mode.text = sendMode; }
		
		public function get currentByte():int {	return _currentByte; }
		public function set currentByte(value:int):void	{ _currentByte = value; this.byte.text = String( value ); }
		
		
		/**
		 * phones properties
		 * */
		[Bindable]
		public var alPhone:ArrayCollection = new ArrayCollection();
		private var Kpf:KoreaPhoneNumberFormatter = new KoreaPhoneNumberFormatter();
		private var excel:Excel;
		private var sma:SendModeAddress;
		private var sml:SendModeLog;
		private var paste:Paste;
		
		
		/**
		 * emoticon properties
		 * */
		private var emoticonBox:Emoticon;
		
		
		/**
		 * returnPhone properties
		 * */
		public var rt:ReturnPhone;

		public function Send() { 
			super();
			
			rt = new ReturnPhone();
			addEventListener(Event.ADDED_TO_STAGE, addedtostage_handler, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, removedfromstage_handler, false, 0, true);
			
		}
		
		public function addedtostage_handler(event:Event):void {
			
			
		}
		
		public function removedfromstage_handler(event:Event):void {
			
			
			Object(sendList.dataProvider).removeAll();
			alPhone.removeAll();
			removeReaervation();
			removeInterval();
			
			removeExcel();
			removeSendModeAddress()
			removeSendModeLog();
			removePaste();
			removeEmoticon();
		
		}
		
		
		
		
		
		override protected function getCurrentSkinState():String { return super.getCurrentSkinState(); } 
		override protected function partAdded(partName:String, instance:Object) : void {
			
			super.partAdded(partName, instance);
			
			if (instance == specialChar) specialChar.addEventListener(FlowElementMouseEvent.CLICK, emoticonView_clickHandler );
			else if (instance == message) message.addEventListener(KeyboardEvent.KEY_UP, message_keyUpHandlerAutoMode);
			else if (instance == sendListInput)	sendListInput.addEventListener(FlexEvent.ENTER, sendListInput_enterHandler);
			else if (instance == sendListInputBtn) sendListInputBtn.addEventListener(MouseEvent.CLICK, sendListInput_enterHandler);
			else if (instance == dupleDelete) dupleDelete.addEventListener(FlowElementMouseEvent.CLICK, dupleDelete_clickHandler);
			else if (instance == sendList) sendList.dataProvider = alPhone;
			else if (instance == callback) {
				
				callback.labelField = "phone";
				rt.callback = this.callback;
				rt.getReturnPhone();
				callback.addEventListener(IndexChangeEvent.CHANGE, callback_changeHandler);
			}
			else if (instance == sendBtn) sendBtn.addEventListener(MouseEvent.CLICK, sendBtn_clickHandler);
			else if (instance == emoticon) emoticon.addEventListener(FlowElementMouseEvent.CLICK, emoticonView_clickHandler);
			else if (instance == myMessage) myMessage.addEventListener(FlowElementMouseEvent.CLICK, emoticonView_clickHandler);
			else if (instance == messageSaveBtn) messageSaveBtn.addEventListener(FlowElementMouseEvent.CLICK, messageSaveBtn_clickHandler);
			else if (instance == sentMessage) sentMessage.addEventListener(FlowElementMouseEvent.CLICK, emoticonView_clickHandler);
			else if (instance == callbackSave) callbackSave.addEventListener(FlowElementMouseEvent.CLICK, rt.callbackSave_clickHandler);
			else if (instance == sendListFromExcel) sendListFromExcel.addEventListener(FlowElementMouseEvent.CLICK, sendListFromExcel_clickHandler);
			else if (instance == sendListFromAddress) sendListFromAddress.addEventListener(FlowElementMouseEvent.CLICK, sendListFromAddress_clickHandler);
			else if (instance == sendListFromSent) sendListFromSent.addEventListener(FlowElementMouseEvent.CLICK, sendListFromSent_clickHandler);
			else if (instance == sendListFromCopy) sendListFromCopy.addEventListener(FlowElementMouseEvent.CLICK, sendListFromCopy_clickHandler);
			else if (instance == phoneRemoveAll) phoneRemoveAll.addEventListener(FlowElementMouseEvent.CLICK, phoneRemoveAll_clickHandler);
			
			else if (instance == sendReservation) sendReservation.addEventListener(Event.CHANGE, sendReservation_changeHandler);
			else if (instance == sendInterval) sendInterval.addEventListener(Event.CHANGE, sendInterval_changeHandler);
			
			
			if (instance is LinkElement) {
				instance.addEventListener(FlowElementMouseEvent.ROLL_OVER, tooltip_overHandler);
				instance.addEventListener(FlowElementMouseEvent.ROLL_OUT, tooltip_outHandler);
			}
			

		}
		override protected function partRemoved(partName:String, instance:Object) : void {
			
			super.partRemoved(partName, instance);
			
			if (instance == specialChar) specialChar.removeEventListener(FlowElementMouseEvent.CLICK, emoticonView_clickHandler );
			else if (instance == message) message.removeEventListener(KeyboardEvent.KEY_UP, message_keyUpHandlerAutoMode);
			else if (instance == sendListInput)	sendListInput.removeEventListener(FlexEvent.ENTER, sendListInput_enterHandler);
			else if (instance == sendListInputBtn) sendListInputBtn.removeEventListener(MouseEvent.CLICK, sendListInput_enterHandler);
			else if (instance == dupleDelete) dupleDelete.removeEventListener(FlowElementMouseEvent.CLICK, dupleDelete_clickHandler);
			else if (instance == callback) callback.removeEventListener(IndexChangeEvent.CHANGE, callback_changeHandler);
			else if (instance == sendBtn) sendBtn.removeEventListener(MouseEvent.CLICK, sendBtn_clickHandler);
			else if (instance == emoticon) emoticon.removeEventListener(FlowElementMouseEvent.CLICK, emoticonView_clickHandler);
			else if (instance == myMessage) myMessage.removeEventListener(FlowElementMouseEvent.CLICK, emoticonView_clickHandler);
			else if (instance == messageSaveBtn) messageSaveBtn.removeEventListener(FlowElementMouseEvent.CLICK, messageSaveBtn_clickHandler);
			else if (instance == sentMessage) sentMessage.removeEventListener(FlowElementMouseEvent.CLICK, emoticonView_clickHandler);
			else if (instance == callbackSave) callbackSave.removeEventListener(FlowElementMouseEvent.CLICK, rt.callbackSave_clickHandler);
			
			if (instance is LinkElement) {
				instance.removeEventListener(FlowElementMouseEvent.ROLL_OVER, tooltip_overHandler);
				instance.removeEventListener(FlowElementMouseEvent.ROLL_OUT, tooltip_outHandler);
			}
			
			
		}
		override protected function createChildren():void
		{
			// TODO Auto Generated method stub
			super.createChildren();
			
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
			var subMessage:String = "";
			if ( Gv.bLogin == false ) {
				validMessage = "로그인 후 이용 가능 합니다.";
				subMessage = "회원 가입은 상단의 회원가입 버튼을 클릭하세요.";
			}
			else if ( msg == "" ) {
				validMessage = "메시지를 입력 하세요.";
				subMessage = "90Byte 이상 입력시 LMS로 자동 전환됩니다.";
			}
			else if (this.alPhone.length <= 0) {
				validMessage = "전화번호를 추가하세요.";
				subMessage = "아래 대량입력, 주소록, 엑셀등 글씨를 클릭 하여 추가 하실 수 있습니다.";
			}
			else if (rt.returnPhone == "") {
				validMessage = "회신번호를 입력하세요.";
				subMessage = "여러 번호를 저장 하거나 선택 할 수 있습니다.";
			}
			else {
				validMessage = "보내기 버튼을 누르면 전송 됩니다.";
				subMessage = "예약 설정 또는 간격설정을 하실 수 있습니다.";
				sendBtn.enabled = true;
			}
			helpText.text = validMessage;
			subHelpText.text = subMessage;
			
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
			alPhone.addAll(ac);
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
			
			var pvo:PhoneVO = new PhoneVO();
			pvo.pName = pname;
			pvo.pNo = pno;
			
			return pvo;
		}
		public function removePhone(pvo:PhoneVO):void {	this.alPhone.removeItemAt( this.alPhone.getItemIndex(pvo) ); }
		public function phoneFormat(ph:String):String {	return Kpf.format(ph);	}
		private function setTotalCount():void { 
			this.countPhone.text = new String(this.alPhone.length);
			confirm_count.text = this.countPhone.text;
			this.isValid();
		}
		private function dupleDelete_clickHandler(event:Event):void {
			
			event.stopImmediatePropagation();
			event.preventDefault();
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
		
		private function sendListFromExcel_clickHandler(event:FlowElementMouseEvent):void {
			event.stopImmediatePropagation();
			event.preventDefault();
			toggleExcel();
		}
		public function toggleExcel():void {
			
			if (excel == null) createExcel();
			else removeExcel();
		}
		private function createExcel():void {
			excel = new Excel();
			excel.horizontalCenter = 0;
			excel.verticalCenter = 0;
			excel.bFromAddress = false;
			excel.addEventListener("send", excel_sendHandler);
			excel.addEventListener("close", excel_closeHandler);
			this.contentGroup.addElement(excel);
		}
		private function excel_sendHandler(event:CustomEvent):void {
			addPhoneList( event.result as ArrayCollection );
		}
		private function excel_closeHandler(event:Event):void {
			removeExcel();
		}
		
		private function removeExcel():void {
			
			if (excel != null) {
				excel.removeEventListener("send", excel_sendHandler);
				excel.removeEventListener("close", excel_closeHandler);
				this.contentGroup.removeElement(excel);
				excel = null;
			}
			
		}
		
		/**
		 * save message
		 * */
		public function messageSaveBtn_clickHandler(event:FlowElementMouseEvent):void {
			event.stopImmediatePropagation();
			event.preventDefault();
			if (message.text != "") {
				RemoteSingleManager.getInstance.addEventListener("saveMymsg", messageSaveBtn_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.saveMymsg(message.text);
			}else {
				SLibrary.alert("메시지를 입력 후 저장하세요.");
			}
		}
		private function messageSaveBtn_resultHandler(event:CustomEvent):void {
			
			var bvo:BooleanAndDescriptionVO = event.result as BooleanAndDescriptionVO;
			if (bvo.bResult) {
				SLibrary.alert("저장되었습니다.");
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
			
			if (sendReservation.selected) {
				smvo.bReservation = true;
				smvo.reservationDate = sendReservation.label + ":00";
			}else smvo.bReservation = false;
			
			if (sendInterval.selected) {
				smvo.bInterval = true;
				var arr:Array = sendInterval.label.split("/");
				smvo.itCount = int(arr[0]);
				smvo.itMinute = int(arr[1]);
			}else smvo.bInterval = false;
			
			smvo.message = msg;
			smvo.returnPhone = rt.returnPhone;
			smvo.al = alPhone;
			 
			RemoteSingleManager.getInstance.addEventListener("sendSMSconf", sendBtn_resultHandler, false, 0, true);
			RemoteSingleManager.getInstance.callresponderToken 
				= RemoteSingleManager.getInstance.service.sendSMSconf(smvo);
		}
		private function sendBtn_resultHandler(event:CustomEvent):void {
			
			var bVO:BooleanAndDescriptionVO = event.result as BooleanAndDescriptionVO;
			if (bVO.bResult) {
				
				isValid();
				SLibrary.alert( bVO.strDescription+" 건 전송 요청이 완료 되었습니다." );
				
			} else {
				
				isValid();
				SLibrary.alert(bVO.strDescription);
			}
		}
		
		
		private function sendListFromAddress_clickHandler(event:FlowElementMouseEvent):void {
			event.stopImmediatePropagation();
			event.preventDefault();
			toggleSendModeAddress();
		}
		private function toggleSendModeAddress():void {
			
			if (sma == null) createSendModeAddress();
			else removeSendModeAddress();
		}
		private function createSendModeAddress():void {
			sma = new SendModeAddress();
			sma.horizontalCenter = 0;
			sma.verticalCenter = 0;
			sma.addEventListener("sendAddress", sma_sendHandler);
			sma.addEventListener("close", sma_closeHandler);
			this.contentGroup.addElement(sma);
		}
		private function sma_sendHandler(event:CustomEvent):void {
			addPhoneList( event.result as ArrayCollection );
		}
		private function sma_closeHandler(event:Event):void {
			removeSendModeAddress();
		}
		private function removeSendModeAddress():void {
			
			if (sma != null) {
				sma.removeEventListener("sendAddress", sma_sendHandler);
				sma.removeEventListener("close", sma_closeHandler);
				this.contentGroup.removeElement(sma);
				sma = null;
			}
			
		}
		
		
		private function sendListFromSent_clickHandler(event:FlowElementMouseEvent):void {
			event.stopImmediatePropagation();
			event.preventDefault();
			toggleSendModeLog();
		}
		private function toggleSendModeLog():void {
			
			if (sml == null) createSendModeLog();
			else removeSendModeLog();
		}
		private function createSendModeLog():void {
			sml = new SendModeLog();
			sml.horizontalCenter = 0;
			sml.verticalCenter = 0;
			sml.addEventListener("getPhone", sml_sendHandler);
			sml.addEventListener("close", sml_closeHandler);
			this.contentGroup.addElement(sml);
		}
		private function sml_sendHandler(event:CustomEvent):void {
			addPhoneList( event.result as ArrayCollection );
		}
		private function sml_closeHandler(event:Event):void {
			removeSendModeLog();
		}
		private function removeSendModeLog():void {
			
			if (sml != null) {
				sml.removeEventListener("getPhone", sml_sendHandler);
				sml.removeEventListener("close", sml_closeHandler);
				this.contentGroup.removeElement(sml);
				sml = null;
			}
		
		}
		
		
		private function phoneRemoveAll_clickHandler(event:FlowElementMouseEvent):void {
			event.stopImmediatePropagation();
			event.preventDefault();
			Object(sendList.dataProvider).removeAll();
			alPhone.removeAll();
		}
		
		
		private function sendListFromCopy_clickHandler(event:FlowElementMouseEvent):void {
			event.stopImmediatePropagation();
			event.preventDefault();
			togglePaste();
		}
		private function togglePaste():void {
			
			if (paste == null) createPaste();
			else removePaste();
		}
		private function createPaste():void {
			paste = new Paste();
			paste.horizontalCenter = 0;
			paste.verticalCenter = 0;
			paste.addEventListener("getPhone", paste_sendHandler);
			paste.addEventListener("close", paste_closeHandler);
			this.contentGroup.addElement(paste);
		}
		private function paste_sendHandler(event:CustomEvent):void {
			addPhoneList( event.result as ArrayCollection );
		}
		private function paste_closeHandler(event:Event):void {
			removePaste();
		}
		
		private function removePaste():void {
			
			if (paste != null) {
				paste.removeEventListener("getPhone", paste_sendHandler);
				paste.removeEventListener("close", paste_closeHandler);
				this.contentGroup.removeElement(paste);
				paste = null;
			}
			
		}
		
		
		private function emoticonView_clickHandler(event:FlowElementMouseEvent):void {
			event.stopImmediatePropagation();
			event.preventDefault();
			var state:String = "emoticon";
			if (event.flowElement == emoticon) state="emoticon";
			else if (event.flowElement == specialChar) state="specialChar";
			else if (event.flowElement == myMessage) state="myMessage";
			else if (event.flowElement == sentMessage) state="sentMessage";
			
			if (emoticonBox == null) {
				createEmoticon(state);
			}else {
				if (emoticonBox.state == state )
					removeEmoticon();
				else
					emoticonBox.state = state;
			}
		}
		private function createEmoticon(state:String):void {
			emoticonBox = new Emoticon(state);
			emoticonBox.horizontalCenter = 0;
			emoticonBox.verticalCenter = 0;
			emoticonBox.addEventListener("message", emoticonBox_messageHandler);
			emoticonBox.addEventListener("specialChar", emoticonBox_specialCharHandler);
			emoticonBox.addEventListener("close", emoticonBox_closeHandler);
			this.contentGroup.addElement(emoticonBox);
		}
		private function emoticonBox_messageHandler(event:CustomEvent):void {
			msg = event.result as String;
		}
		private function emoticonBox_specialCharHandler(event:CustomEvent):void {
			msg += event.result as String;
		}
		private function emoticonBox_closeHandler(event:Event):void {
			removeEmoticon();
		}
		public function removeEmoticon():void {
			
			if (emoticonBox != null) {
				emoticonBox.removeEventListener("message", emoticonBox_messageHandler);
				emoticonBox.removeEventListener("specialChar", emoticonBox_specialCharHandler);
				emoticonBox.removeEventListener("close", emoticonBox_closeHandler);
				this.contentGroup.removeElement(emoticonBox);
				emoticonBox = null;
			}
			
		}
		
		
		private function sendReservation_changeHandler(event:Event):void {
			
			if (sendReservation.selected) {
				sendReservation.label = "";
				createReaervation();
			}else {
				
				sendReservation.label = "예약설정";
				confirm_reservation.text = "";
				removeReaervation();
				
			}
		}
		private function createReaervation():void {
			
			if (reservation == null) {
				reservation = new ReservationCalendar();
				reservation.horizontalCenter = 0;
				reservation.verticalCenter = 0;
				reservation.addEventListener("setReservation", reservation_setReservationHandler);
				reservation.addEventListener("cancelReservation", reservation_cancelReservationHandler);
				this.contentGroup.addElement(reservation);
			}
			
		}
		private function reservation_setReservationHandler(event:CustomEvent):void {
			
			sendReservation.label = event.result as String;
			confirm_reservation.text = " "+sendReservation.label+" 시간에 ";
		}
		private function reservation_cancelReservationHandler(event:Event):void {
			
			sendReservation.selected = false;
			sendReservation.dispatchEvent(new Event("change"));
			
		}
		
		private function removeReaervation():void {
			
			if (reservation != null) {
				reservation.removeEventListener("setReservation", reservation_setReservationHandler);
				reservation.removeEventListener("cancelReservation", reservation_cancelReservationHandler);
				this.contentGroup.removeElement(reservation);
				reservation = null;
			}
			
		}
		
		private function sendInterval_changeHandler(event:Event):void {
			
			if (sendInterval.selected) {
				sendInterval.label = "";
				createInterval();
			}else {
				
				sendInterval.label = "간격설정";
				confirm_delay.text = "";
				removeInterval();
			}
		}
		private function createInterval():void {
			
			if (interval == null) {
				interval = new Interval();
				interval.horizontalCenter = 0;
				interval.verticalCenter = 0;
				interval.addEventListener("setInterval", interval_setintervalHandler);
				interval.addEventListener("cancelInterval", interval_cancelintervalHandler);
				this.contentGroup.addElement(interval);
			}
			
		}
		private function interval_setintervalHandler(event:CustomEvent):void {
			
			var obj:Object = event.result;
			sendInterval.label = obj.cnt + "/" + obj.minute;
			confirm_delay.text = sendInterval.label+" 간격으로";
		}
		private function interval_cancelintervalHandler(event:Event):void {
			
			sendInterval.selected = false;
			sendInterval.dispatchEvent(new Event("change"));
			
		}
		
		private function removeInterval():void {
			
			if (interval != null) {
				interval.removeEventListener("setInterval", interval_setintervalHandler);
				interval.removeEventListener("cancelInterval", interval_cancelintervalHandler);
				this.contentGroup.removeElement(interval);
				interval = null;
			}
			
		}
		
		/**
		 * tooltip
		 * */
		private function tooltip_overHandler(event:FlowElementMouseEvent):void {
			
			if(!customToolTip){
				customToolTip = new CustomToolTip();
				customToolTip.x = parentApplication.mouseX - customToolTip.width/2;
				customToolTip.y = parentApplication.mouseY - 40;
				PopUpManager.addPopUp(customToolTip, this, false);
			}
			customToolTip.text =  LinkElement(event.flowElement).href;
		}
		private function tooltip_outHandler(event:FlowElementMouseEvent):void {
			
			PopUpManager.removePopUp(customToolTip);
			customToolTip = null;
		}
		
		public function destroy(event:Event):void {
			
			
			
			
		}
		
		
		
	}
}