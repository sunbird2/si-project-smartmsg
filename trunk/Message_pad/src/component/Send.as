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
	import component.send.Sending;
	import component.util.CustomToolTip;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import flashx.textLayout.elements.LinkElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.events.FlowElementMouseEvent;
	
	import lib.CustomEvent;
	import lib.FileUploadByRemoteObject;
	import lib.FileUploadByRemoteObjectEvent;
	import lib.Gv;
	import lib.KoreaPhoneNumberFormatter;
	import lib.Paging;
	import lib.RemoteSingleManager;
	import lib.SLibrary;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;
	
	import skin.SendSkin;
	
	import spark.components.Button;
	import spark.components.CheckBox;
	import spark.components.ComboBox;
	import spark.components.Group;
	import spark.components.Image;
	import spark.components.Label;
	import spark.components.List;
	import spark.components.RichEditableText;
	import spark.components.RichText;
	import spark.components.TextArea;
	import spark.components.TextInput;
	import spark.components.TileGroup;
	import spark.components.VGroup;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.IndexChangeEvent;
	
	import valueObjects.BooleanAndDescriptionVO;
	import valueObjects.LogVO;
	import valueObjects.PhoneVO;
	import valueObjects.SendMessageVO;
	
	[Event(name="sendComplet", type="flash.events.Event")]
	[Event(name="changeMode", type="flash.events.Event")]
	/* A component must identify the view states that its skin supports. 
	Use the [SkinState] metadata tag to define the view states in the component class. 
	[SkinState("normal")] 
	[SkinState("send")]
	[SkinState("sending")]*/
	
	[SkinState("SMS")]
	[SkinState("LMS")]
	[SkinState("MMS")]
	
	public class Send extends SkinnableComponent
	{
		public static const SEND_COMPLET:String = "sendComplet";
		public static const CHANGE_MODE:String = "changeMode";
		/* To declare a skin part on a component, you use the [SkinPart] metadata. 
		[SkinPart(required="true")] */
		
		[SkinPart(reqired='true')]public var contentGroup:Group;
		[SkinPart(reqired='true')]public var functionGroup:Group;
		
		// function
		[SkinPart(required="false")]public var functionList:List;
		
		
		// message
		[SkinPart(required="false")]public var message:TextArea;
		[SkinPart(required="false")]public var byte:SpanElement;

		[SkinPart(required="false")]public var addImage:Image;
		[SkinPart(required="false")]public var messageSaveBtn:Image;
		[SkinPart(required="false")]public var removeMsg:Image;
		[SkinPart(required="false")]public var mBox:VGroup;
		
		

		// phones
		[SkinPart(required="false")]public var sendListInput:TextInput;
		[SkinPart(required="false")]public var sendListInputBtn:Image;
		[SkinPart(required="false")]public var sendList:List;
		[SkinPart(required="false")]public var countPhone:SpanElement;
		[SkinPart(required="false")]public var dupleDelete:Image;
		[SkinPart(required="false")]public var phoneRemoveAll:Image;
		
		
		
		// callback
		[SkinPart(required="false")]public var callback:ComboBox;
		[SkinPart(required="false")]public var callbackSave:Image;
		
		
		
		// sendBtn
		[SkinPart(required="false")]public var sendReservation:CheckBox;
		[SkinPart(required="false")]public var sendInterval:CheckBox;
		[SkinPart(required="false")]public var sendBtn:Button;
		[SkinPart(required="false")]public var resetBtn:Button;
		[SkinPart(required="false")]public var confirm_mode:SpanElement;
		[SkinPart(required="false")]public var confirm_count:SpanElement;
		[SkinPart(required="false")]public var confirm_reservation:SpanElement;
		[SkinPart(required="false")]public var confirm_delay:SpanElement;
		
		
		[SkinPart(required="false")]public var title_text:RichText;
		[SkinPart(required="false")]public var titleSub_text:RichText;
		
		private var _cstat:String = "SMS";
		public function get cstat():String { return _cstat; }
		public function set cstat(value:String):void { _cstat = value; invalidateSkinState(); }
		
		private var acFunction:ArrayCollection =  new ArrayCollection([
			{icon:"skin/ics/assets/light/icon/3-rating-important.png", label:"내메시지", label_sub:"저장된 메시지 발송", name:"myMessage"},
			{icon:"skin/ics/assets/light/icon/5-content-email.png", label:"최근발송메시지", label_sub:"죄근발송한 메시지 발송", name:"sentMessage"},
			{icon:"skin/ics/assets/light/icon/4-collections-view-as-grid.png", label:"이모티콘", label_sub:"다양한 무료 이모티콘 발송", name:"emoticon"},
			{icon:"skin/ics/assets/light/icon/12-hardware-keyboard.png", label:"특수문자", label_sub:"특수문자 입력", name:"specialChar"},
			
			{icon:"skin/ics/assets/light/icon/5-content-cut.png", label:"복사붙여넣거,대량입력", label_sub:"복사한 전화번호 발송 및 입력", name:"sendListFromCopy"},
			{icon:"skin/ics/assets/light/icon/6-social-group.png", label:"주소록 발송", label_sub:"주소록 선택 발송", name:"sendListFromAddress"},
			{icon:"skin/ics/assets/light/icon/5-content-import-export.png", label:"엑셀을 업로드 발송", label_sub:"엑셀을 업로드 발송", name:"sendListFromExcel"},
			{icon:"skin/ics/assets/light/icon/9-av-repeat.png", label:"최근발송 목록 재발송", label_sub:"최근발송 전화번호 발송", name:"sendListFromSent"}
		]);

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
			messageCheck();
		}
		
		public function msg_ByteCheck():void {			
			this.currentByte = SLibrary.getByte(this.msg);
			isValid();
		}
		
		public function get sendMode():String {	return _sendMode; }
		public function set sendMode(value:String):void	{
			
			if (_sendMode != value) {
				_sendMode = value;
				confirm_mode.text = sendMode;
				this.dispatchEvent( new Event(Send.CHANGE_MODE));
			}
			
		}
		
		public function get currentByte():int {	return _currentByte; }
		public function set currentByte(value:int):void	{ _currentByte = value; this.byte.text = String( value ); }
		
		private var fur:FileUploadByRemoteObject; // upload
		public var arrImage:Array = new Array;
		public function get mmsImage():String { return (arrImage)?arrImage.join(";"):""; }
		
		
		/**
		 * phones properties
		 * */
		public var alPhone:ArrayCollection = new ArrayCollection();
		private var Kpf:KoreaPhoneNumberFormatter;
		private var excel:Excel;
		private var sma:SendModeAddress;
		private var sml:SendModeLog;
		private var paste:Paste;
		private var sending:Sending;
		
		
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
			setStyle("skinClass", SendSkin);
			addEventListener(Event.ADDED_TO_STAGE, addedtostage_handler, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, removedfromstage_handler, false, 0, true);
		}
		
		public function addedtostage_handler(event:Event):void {
			
			Kpf = new KoreaPhoneNumberFormatter();
		}
		
		public function removedfromstage_handler(event:Event):void {
			
			alPhone.removeAll();
			removeReaervation();
			removeInterval();
			
			removeExcel();
			removeSendModeAddress()
			removeSendModeLog();
			removePaste();
			removeEmoticon();
			removeSending();
			
			destroy(null);
		
		}
		
		override protected function getCurrentSkinState():String { return cstat; } 
		override protected function partAdded(partName:String, instance:Object) : void {
			
			super.partAdded(partName, instance);
			//trace("partAdded " + partName);
			if (instance == functionList) {
				functionList.dataProvider = acFunction;
				functionList.addEventListener(IndexChangeEvent.CHANGE, functionList_changeHandler );
			}
			else if (instance == message) message.addEventListener(KeyboardEvent.KEY_UP, message_keyUpHandlerAutoMode);
			else if (instance == sendListInput)	sendListInput.addEventListener(FlexEvent.ENTER, sendListInput_enterHandler);
			else if (instance == sendListInputBtn) sendListInputBtn.addEventListener(MouseEvent.CLICK, sendListInput_enterHandler);
			else if (instance == dupleDelete) dupleDelete.addEventListener(MouseEvent.CLICK, dupleDelete_clickHandler);
			else if (instance == sendList) sendList.dataProvider = alPhone;
			else if (instance == callback) {
				
				if (rt == null)	rt = new ReturnPhone();
				callback.labelField = "phone";
				rt.callback = this.callback;
				rt.getReturnPhone();
				callback.addEventListener(IndexChangeEvent.CHANGE, callback_changeHandler);
			}
			else if (instance == sendBtn) sendBtn.addEventListener(MouseEvent.CLICK, sendBtn_clickHandler);
			else if (instance == messageSaveBtn) messageSaveBtn.addEventListener(MouseEvent.CLICK, messageSaveBtn_clickHandler);
			else if (instance == callbackSave) {
				if (rt == null)	rt = new ReturnPhone();
				callbackSave.addEventListener(MouseEvent.CLICK, rt.callbackSave_clickHandler);
			}
			else if (instance == phoneRemoveAll) phoneRemoveAll.addEventListener(MouseEvent.CLICK, phoneRemoveAll_clickHandler);
			
			else if (instance == sendReservation) sendReservation.addEventListener(Event.CHANGE, sendReservation_changeHandler);
			else if (instance == sendInterval) sendInterval.addEventListener(Event.CHANGE, sendInterval_changeHandler);
			else if (instance == addImage) addImage.addEventListener(MouseEvent.CLICK, addImage_clickHandler);
			else if (instance == removeMsg) removeMsg.addEventListener(MouseEvent.CLICK, removeMsg_clickHandler);
			
			
			if (instance is LinkElement) {
				instance.addEventListener(FlowElementMouseEvent.ROLL_OVER, tooltip_overHandler);
				instance.addEventListener(FlowElementMouseEvent.ROLL_OUT, tooltip_outHandler);
			}
			

		}
		override protected function partRemoved(partName:String, instance:Object) : void {
			
			if (instance == functionList) {
				functionList.removeEventListener(IndexChangeEvent.CHANGE, functionList_changeHandler );
				functionList.dataProvider.removeAll();
				acFunction.removeAll();
				acFunction = null;
			}
			else if (instance == message) message.removeEventListener(KeyboardEvent.KEY_UP, message_keyUpHandlerAutoMode);
			else if (instance == sendListInput)	sendListInput.removeEventListener(FlexEvent.ENTER, sendListInput_enterHandler);
			else if (instance == sendListInputBtn) sendListInputBtn.removeEventListener(MouseEvent.CLICK, sendListInput_enterHandler);
			else if (instance == dupleDelete) dupleDelete.removeEventListener(MouseEvent.CLICK, dupleDelete_clickHandler);
			else if (instance == callback) {
				rt.destory();
				callback.removeEventListener(IndexChangeEvent.CHANGE, callback_changeHandler);
			}
			else if (instance == sendBtn) sendBtn.removeEventListener(MouseEvent.CLICK, sendBtn_clickHandler);
			else if (instance == messageSaveBtn) messageSaveBtn.removeEventListener(MouseEvent.CLICK, messageSaveBtn_clickHandler);
			else if (instance == callbackSave) {
				if (rt == null)	rt = new ReturnPhone();
				callbackSave.removeEventListener(MouseEvent.CLICK, rt.callbackSave_clickHandler);
			}
			else if (instance == phoneRemoveAll) phoneRemoveAll.removeEventListener(MouseEvent.CLICK, phoneRemoveAll_clickHandler);
				
			else if (instance == sendReservation) sendReservation.removeEventListener(Event.CHANGE, sendReservation_changeHandler);
			else if (instance == sendInterval) sendInterval.removeEventListener(Event.CHANGE, sendInterval_changeHandler);
			
			
			if (instance is LinkElement) {
				instance.removeEventListener(FlowElementMouseEvent.ROLL_OVER, tooltip_overHandler);
				instance.removeEventListener(FlowElementMouseEvent.ROLL_OUT, tooltip_outHandler);
			}
			
			super.partRemoved(partName, instance);
			
			
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void	{
			
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			isValid();
		}
		
		private var viewFunction:String = "";
		private function functionList_changeHandler(event:IndexChangeEvent):void {
			
			var item:Object = functionList.selectedItem;

			// remove
			if (viewFunction == "myMessage") emoticonView("myMessage");
			else if (viewFunction == "specialChar") emoticonView("specialChar");
			else if (viewFunction == "emoticon") emoticonView("emoticon");
			else if (viewFunction == "sentMessage") emoticonView("sentMessage");
				
			else if (viewFunction == "sendListFromExcel")toggleExcel(); 
			else if (viewFunction == "sendListFromAddress") toggleSendModeAddress();
			else if (viewFunction == "sendListFromSent") toggleSendModeLog();
			else if (viewFunction == "sendListFromCopy") togglePaste();
			
			
			// create
			if (item.name == "myMessage") emoticonView("myMessage");
			else if (item.name == "specialChar") emoticonView("specialChar");
			else if (item.name == "emoticon") emoticonView("emoticon");
			else if (item.name == "sentMessage") emoticonView("sentMessage");
			
			else if (item.name == "sendListFromExcel")toggleExcel(); 
			else if (item.name == "sendListFromAddress") toggleSendModeAddress();
			else if (item.name == "sendListFromSent") toggleSendModeLog();
			else if (item.name == "sendListFromCopy") togglePaste();
			
			viewFunction = item.name;
		}
		
		
		/**
		 * global function
		 * */
		public function isValid():void {
			
			var validMessage:String = "";
			var subMessage:String = "";
			if ( msg == "" ) {
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
			title_text.text = validMessage;
			titleSub_text.text = subMessage;
			
		}
		public function initReturnPhone():void {
			rt.getReturnPhone();
		}
		
		/**
		 * message function
		 * */
		protected function message_keyUpHandlerAutoMode(event:KeyboardEvent):void {
			msg_ByteCheck();
			messageCheck();
		}
		
		private function messageCheck():void {
			
			if ( currentByte > Gv.SMS_BYTE ) {
				if (arrImage && arrImage.length > 0) sendMode = "MMS";
				else sendMode = "LMS";
			}else sendMode = "SMS";
			
			cstat = sendMode;
			
			if ( currentByte > Gv.LMS_BYTE) {
				//trace("cutByte!!"+currentByte+"/"+this.maxByte);
				this.msg = SLibrary.cutByteTo(this.msg, this.maxByte);
			}
		}
		
		private function removeMsg_clickHandler(event:MouseEvent):void {
			this.msg = "";
			allDelImage();
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
		public function removePhone(pvo:PhoneVO):void {	this.alPhone.removeItemAt( this.alPhone.getItemIndex(pvo) );setTotalCount(); }
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
			alPhone.removeAll();
			alPhone.addAll(arr);
			setTotalCount();
			SLibrary.alert(dupCnt + " 건의 중복번호가 제거 되었습니다.");
		}
		
		
		public function toggleExcel():void {
			
			if (excel == null) createExcel();
			else removeExcel();
		}
		private function createExcel():void {
			excel = new Excel();
			excel.bFromAddress = false;
			excel.addEventListener("send", excel_sendHandler);
			excel.addEventListener("close", excel_closeHandler);
			this.functionGroup.addElement(excel);
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
				this.functionGroup.removeElement(excel);
				excel = null;
			}
			
		}
		
		/**
		 * save message
		 * */
		public function messageSaveBtn_clickHandler(event:MouseEvent):void {
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
			
			removeSending();
			
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
			
			smvo.imagePath = this.mmsImage; 
			smvo.message = msg;
			smvo.returnPhone = rt.returnPhone;
			smvo.al = alPhone;
			
			
			RemoteSingleManager.getInstance.addEventListener("sendSMSconf", sendBtn_resultHandler, false, 0, true);
			RemoteSingleManager.getInstance.callresponderToken 
				= RemoteSingleManager.getInstance.service.sendSMSconf(smvo);
			
			createSending();			
		}
		private function sendBtn_resultHandler(event:CustomEvent):void {
			
			var lvo:LogVO = event.result as LogVO;
			if (lvo.idx != 0) {
				sending.sendingCompleted(lvo);
				this.dispatchEvent(new Event(Send.SEND_COMPLET));
			} else {
				removeSending();
				SLibrary.alert(lvo.message);
			}
			isValid();
		}
		
		/**
		 * Sending
		 * */
		/*private function toggleSending():void {
			
			if (sending == null) createSending();
			else removeSending();
		}*/
		private function createSending():void {
			if (sending == null) 
				sending = new Sending();
			
			sending.horizontalCenter = 0;
			sending.verticalCenter = 0;
			sending.addEventListener("close", sending_closeHandler);
			this.contentGroup.addElement(sending);
		}
		private function sending_closeHandler(event:Event):void {
			removeSending();
		}
		
		private function removeSending():void {
			
			if (sending != null) {
				sending.removeEventListener("close", sending_closeHandler);
				this.contentGroup.removeElement(sending);
				sending.destroy();
				sending = null;
			}
			
		}
		
		
		/**
		 * SendModeAddress
		 * */
		private function toggleSendModeAddress():void {
			
			if (sma == null) createSendModeAddress();
			else removeSendModeAddress();
		}
		private function createSendModeAddress():void {
			sma = new SendModeAddress();
			sma.addEventListener("sendAddress", sma_sendHandler);
			sma.addEventListener("close", sma_closeHandler);
			this.functionGroup.addElement(sma);
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
				this.functionGroup.removeElement(sma);
				sma = null;
			}
			
		}
		
		
		/**
		 * SendModeLog
		 * */
		private function toggleSendModeLog():void {
			
			if (sml == null) createSendModeLog();
			else removeSendModeLog();
		}
		private function createSendModeLog():void {
			sml = new SendModeLog();
			sml.addEventListener("getPhone", sml_sendHandler);
			sml.addEventListener("close", sml_closeHandler);
			this.functionGroup.addElement(sml);
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
				this.functionGroup.removeElement(sml);
				sml = null;
			}
		
		}
		
		/**
		 * remove phones
		 * */
		private function phoneRemoveAll_clickHandler(event:MouseEvent):void {
			event.stopImmediatePropagation();
			event.preventDefault();
			//Object(sendList.dataProvider).removeAll();
			alPhone.removeAll();
		}
		
		
		/**
		 * Copy & Paste
		 * */
		private function togglePaste():void {
			
			if (paste == null) createPaste();
			else removePaste();
		}
		private function createPaste():void {
			paste = new Paste();
			paste.addEventListener("getPhone", paste_sendHandler);
			paste.addEventListener("close", paste_closeHandler);
			this.functionGroup.addElement(paste);
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
				this.functionGroup.removeElement(paste);
				paste = null;
			}
			
		}
		
		/**
		 * Emoticon
		 * */
		private function emoticonView(mode:String):void {
			
			if (emoticonBox == null) {
				createEmoticon(mode);
			}else {
				if (emoticonBox.state == mode )
					removeEmoticon();
				else
					emoticonBox.state = mode;
			}
		}
		private function createEmoticon(state:String):void {
			emoticonBox = new Emoticon(state);
			emoticonBox.addEventListener("message", emoticonBox_messageHandler);
			emoticonBox.addEventListener("specialChar", emoticonBox_specialCharHandler);
			this.functionGroup.addElement(emoticonBox);
		}
		private function emoticonBox_messageHandler(event:CustomEvent):void {
			msg = event.result as String;
		}
		private function emoticonBox_specialCharHandler(event:CustomEvent):void {
			msg += event.result as String;
		}
		public function removeEmoticon():void {
			
			if (emoticonBox != null) {
				emoticonBox.removeEventListener("message", emoticonBox_messageHandler);
				emoticonBox.removeEventListener("specialChar", emoticonBox_specialCharHandler);
				this.functionGroup.removeElement(emoticonBox);
				emoticonBox = null;
			}
			
		}
		
		/**
		 * Reservation
		 * */
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
				reservation.right = 0;
				reservation.bottom = 0;
				reservation.addEventListener("setReservation", reservation_setReservationHandler);
				reservation.addEventListener("cancelReservation", reservation_cancelReservationHandler);
				this.functionGroup.addElement(reservation);
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
				this.functionGroup.removeElement(reservation);
				reservation = null;
			}
			
		}
		
		
		/**
		 * Interval
		 * */
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
				interval.right = 0;
				interval.bottom = 0;
				interval.addEventListener("setInterval", interval_setintervalHandler);
				interval.addEventListener("cancelInterval", interval_cancelintervalHandler);
				this.functionGroup.addElement(interval);
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
				this.functionGroup.removeElement(interval);
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
		
		/**
		 * MMS image
		 * */
		public function allDelImage():void {
			arrImage = new Array;
			if (mBox.numElements > 1) {
				var cnt:int = mBox.numElements;
				for (var i:int = 0; i < cnt-1; i++ )
					mBox.removeElementAt(0);
			}
		}
		public function setPhoto(source:String):void {
			
			removeImage();
			var img:Image = new Image();
			img.source = source;
			img.smooth = true;
			img.buttonMode = true;
			mBox.addElementAt(img, mBox.numElements-1);
			mBox.gap = 0;
			arrImage.push(source);
			
			
			sendMode = "MMS";
		}
		
		private function removeImage():void {
			
			/*if (arrImage.length > 2) {
				arrImage.pop();
				SLibrary.alert("3개까지만 추가 가능 합니다. 마지막 이미지가 지워졌습니다.");
				trace(arrImage.join(";"));
			}
			
			if (mBox.numElements == 4) {
				mBox.removeElementAt(0);
			}*/
			
			if (arrImage.length > 0) {
				arrImage.pop();
				mBox.removeElementAt(0);
			}
		}
		
		/**
		 * upload
		 * */
		private function addImage_clickHandler(event:MouseEvent):void {
			
			// 업로드 초기화
			this.fur = new FileUploadByRemoteObject("smt");
			this.fur.addEventListener(FileUploadByRemoteObjectEvent.COMPLETE, FileUploadByRemoteObjectCOMPLETEHandler);
			this.fur.addEventListener(FileUploadByRemoteObjectEvent.RESULT, FileUploadByRemoteObjectRESULTHandler);
			this.fur.addEventListener(FileUploadByRemoteObjectEvent.FAULT, FileUploadByRemoteObjectFAULTHandler);
			
			this.fur.addFiles();
		}
		
		private function FileUploadByRemoteObjectCOMPLETEHandler(e:FileUploadByRemoteObjectEvent):void {
			
			if ( Number(this.fur.UploadFiles[this.fur.UploadFiles.length -1].realsize) > Number(1024*1024*1) ) {
				this.fur.UploadFiles.pop();
				destoryUpload();
				SLibrary.alert("1MB 이상의 파일은 사용 하실 수 없습니다.");
			}else {
				this.fur.remoteObject.setMMSUpload( e.data, e.fileName );
			}
		}
		private function FileUploadByRemoteObjectRESULTHandler(e:FileUploadByRemoteObjectEvent):void {
			
			var bvo:BooleanAndDescriptionVO = e.result as BooleanAndDescriptionVO;
			
			if (bvo.bResult) this.setPhoto(bvo.strDescription as String);
			else SLibrary.alert(bvo.strDescription);
			
			destoryUpload();
			
		}
		private function FileUploadByRemoteObjectFAULTHandler(e:FileUploadByRemoteObjectEvent):void { SLibrary.alert(e.fault.toString());destoryUpload(); }
		
		private function destoryUpload():void {
			
			if (this.fur) {
				this.fur.removeEventListener(FileUploadByRemoteObjectEvent.COMPLETE, FileUploadByRemoteObjectCOMPLETEHandler);
				this.fur.removeEventListener(FileUploadByRemoteObjectEvent.RESULT, FileUploadByRemoteObjectRESULTHandler);
				this.fur.removeEventListener(FileUploadByRemoteObjectEvent.FAULT, FileUploadByRemoteObjectFAULTHandler);
				this.fur.destroy();
				this.fur = null;
			}
		}
		
		
		
		
		/**
		 * destroy
		 * */
		public function destroy(event:Event):void {
			
			destoryUpload();
			
			functionGroup = null;
			
			// message
			message = null;
			byte = null;
			messageSaveBtn = null;
			addImage = null;
			
			
			
			// phones
			sendListInput = null;
			sendListInputBtn = null;
			sendList = null;
			countPhone = null;
			dupleDelete = null;
			phoneRemoveAll = null;
			
			
			
			// callback
			callback = null;
			callbackSave = null;
			
			
			
			// sendBtn
			sendReservation = null;
			sendInterval = null;
			sendBtn = null;
			resetBtn = null;
			confirm_mode = null;
			confirm_count = null;
			confirm_reservation = null;
			confirm_delay = null;
			
			
			title_text = null;
			titleSub_text = null;
			
			if (alPhone != null) {
				alPhone.removeAll();
				alPhone = null;	
			}
			
			Kpf = null;
		}
		
		
		
	}
}