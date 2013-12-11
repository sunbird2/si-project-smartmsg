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
	import component.util.ButtonSpinner;
	import component.util.CustomToolTip;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import flashx.textLayout.elements.LinkElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.events.FlowElementMouseEvent;
	
	//import lib.CookieUtil;
	import lib.CustomEvent;
	import lib.FileUploadByRemoteObject;
	import lib.FileUploadByRemoteObjectEvent;
	import lib.Gv;
	import lib.KoreaPhoneNumberFormatter;
	import lib.Paging;
	import lib.RemoteSingleManager;
	import lib.SLibrary;
	
	import module.ie.ImageEditorAble;
	import module.url.IMobileWebEditor;
	import module.url.MobileWebEditorAble;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	import mx.events.ModuleEvent;
	import mx.managers.PopUpManager;
	
	import skin.SendSkin;
	
	import spark.components.Button;
	import spark.components.CheckBox;
	import spark.components.ComboBox;
	import spark.components.Group;
	import spark.components.HGroup;
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
	import spark.modules.ModuleLoader;
	import spark.primitives.BitmapImage;
	
	import valueObjects.AddressVO;
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
	
	public class Send extends SkinnableComponent implements ImageEditorAble, MobileWebEditorAble
	{
		public static const SEND_COMPLET:String = "sendComplet";
		public static const CHANGE_MODE:String = "changeMode";
		
		public static const PHONE_DIV:String = "|";
		
		public static const MWEB_URL:String = "{http://mjnote.co.kr/m/?k=xxxxxx}";
		/* To declare a skin part on a component, you use the [SkinPart] metadata. 
		[SkinPart(required="true")] */
		
		[SkinPart(reqired='true')]public var contentGroup:Group;
		[SkinPart(reqired='true')]public var functionGroup:Group;
		
		// function
		[SkinPart(required="false")]public var functionList:List;
		
		
		// message
		[SkinPart(required="false")]public var message:TextArea;
		[SkinPart(required="false")]public var byte:SpanElement;
		[SkinPart(required="false")]public var sMode:SpanElement;
		
		[SkinPart(required="false")]public var addUrl:Image;
		[SkinPart(required="false")]public var addImage:Image;
		[SkinPart(required="false")]public var addTxt:Image;
		[SkinPart(required="false")]public var addTxtLayer:List;
		[SkinPart(required="false")]public var addMMSLayer:List;
		
		
		[SkinPart(required="false")]public var messageSaveBtn:Image;
		[SkinPart(required="false")]public var removeMsg:Image;
		[SkinPart(required="false")]public var mBox:VGroup;
		// ImageEditor Module
		[SkinPart(required="false")]public var moduleLoaderIme:ModuleLoader;
		// MobileWebEditor Module
		[SkinPart(required="false")]public var moduleLoaderUrl:ModuleLoader;
		
		
		
		
		// phones
		[SkinPart(required="false")]public var sendListInput:TextInput;
		[SkinPart(required="false")]public var sendListInputBtn:Image;
		[SkinPart(required="false")]public var sendList:List;
		[SkinPart(required="false")]public var countPhone:SpanElement;
		[SkinPart(required="false")]public var dupleDelete:Image;
		[SkinPart(required="false")]public var phoneRemoveAll:Image;
		[SkinPart(required="false")]public var addressView:Image;
		[SkinPart(required="false")]public var sendBox:HGroup;
		[SkinPart(required="false")]public var addressBox:HGroup;
		[SkinPart(required="false")]public var addressSave:ButtonSpinner;
		[SkinPart(required="false")]public var addressCombo:ComboBox;
		[SkinPart(required="false")]public var addressBoxClose:Button;
		
		
		[SkinPart(required="false")]public var ePhone:TextInput;
		[SkinPart(required="false")]public var eName:TextInput;
		[SkinPart(required="false")]public var eMearge1:TextInput;
		[SkinPart(required="false")]public var eMearge2:TextInput;
		[SkinPart(required="false")]public var eMearge3:TextInput;
		
		[SkinPart(required="false")]public var eLayer:VGroup;
		[SkinPart(required="false")]public var ePre:Button;
		[SkinPart(required="false")]public var eUpdate:Button;
		[SkinPart(required="false")]public var eCancel:Button;
		[SkinPart(required="false")]public var eNext:Button;
		
		
		// callback
		[SkinPart(required="false")]public var callback:ComboBox;
		[SkinPart(required="false")]public var callbackSave:Image;
		
		
		
		// sendBtn
		[SkinPart(required="false")]public var sendReservation:CheckBox;
		[SkinPart(required="false")]public var sendInterval:CheckBox;
		[SkinPart(required="false")]public var sendBtn:Button;
		[SkinPart(required="false")]public var resetBtn:Button;
		[SkinPart(required="false")]public var sendSetting:Image;
		[SkinPart(required="false")]public var sendSetBox:Group;
		[SkinPart(required="false")]public var sendDelmsg:CheckBox;
		[SkinPart(required="false")]public var sendDelList:CheckBox;
		[SkinPart(required="false")]public var confirm_mode:SpanElement;
		[SkinPart(required="false")]public var confirm_count:SpanElement;
		[SkinPart(required="false")]public var confirm_reservation:SpanElement;
		[SkinPart(required="false")]public var confirm_delay:SpanElement;
		[SkinPart(required="false")]public var confirm_mearge:SpanElement;
		
		
		[SkinPart(required="false")]public var confirm_text:RichText;
		
		// loading
		[SkinPart(reqired='false')]public var loading:Group;
		
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
			
			{icon:"skin/ics/assets/light/icon/5-content-cut.png", label:"복사붙여넣기,대량입력", label_sub:"복사한 전화번호 발송 및 입력", name:"sendListFromCopy"},
			{icon:"skin/ics/assets/light/icon/6-social-group.png", label:"주소록 발송", label_sub:"주소록 선택 발송", name:"sendListFromAddress"},
			{icon:"skin/ics/assets/light/icon/5-content-import-export.png", label:"엑셀을 업로드 발송", label_sub:"엑셀을 업로드 발송", name:"sendListFromExcel"},
			{icon:"skin/ics/assets/light/icon/9-av-repeat.png", label:"최근발송 목록 재발송", label_sub:"최근발송 전화번호 발송", name:"sendListFromSent"}
		]);
		
		private var acMearge:ArrayCollection =  new ArrayCollection([
			{label:"이름", data:"{이름}"},
			{label:"합성1", data:"{합성1}"},
			{label:"합성2", data:"{합성2}"},
			{label:"합성3", data:"{합성3}"}
		]);
		
		private var acMMS:ArrayCollection =  new ArrayCollection([
			{label:"직접업로드", data:"upload"},
			{label:"편집툴", data:"ime"}
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
				sMode.text = sendMode;
				this.dispatchEvent( new Event(Send.CHANGE_MODE));
			}
			confirm_mode.text = isUrlMode() == true ? sendMode+"(URL)": sendMode;
		}
		public function isUrlMode():Boolean {
			var chkMearg:RegExp = /\{http:\/\/mjnote\.co\.kr\/m\/\?k=xxxxxx\}/g;
			
			if (chkMearg.test(msg)) return true;
			else return false;
		}
		
		public function get currentByte():int {	return _currentByte; }
		public function set currentByte(value:int):void	{ _currentByte = value; this.byte.text = String( value ); }
		
		private var fur:FileUploadByRemoteObject; // upload
		public var arrImage:Array = new Array;
		public function get mmsImage():String { return (arrImage)?arrImage.join(";"):""; }
		
		
		private var _urlKey:int = 0;
		public function get urlKey():int {	return _urlKey; }
		public function set urlKey(value:int):void	{ _urlKey = value; }
		
		
		/**
		 * phones properties
		 * */
		public var alPhone:ArrayCollection = new ArrayCollection();
		public var addressGroupList:ArrayCollection = new ArrayCollection();
		private var Kpf:KoreaPhoneNumberFormatter;
		private var excel:Excel;
		private var sma:SendModeAddress;
		private var sa:Address;
		private var sml:SendModeLog;
		private var paste:Paste;
		private var sending:Sending;
		
		public static const  SAVE_MSGDEL:String = "MunjaNote_save_msgdel";
		public static const  SAVE_LISTDEL:String = "MunjaNote_save_listdel";
		private var cookie_msgDel:String = "";
		private var cookie_listDel:String = "";
		
		
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
			
			// cookie get
			//cookie_msgDel = CookieUtil.getCookie(SAVE_MSGDEL) as String;
			//cookie_listDel = CookieUtil.getCookie(SAVE_LISTDEL) as String;
			
		}
		
		public function addedtostage_handler(event:Event):void {
			
			Kpf = new KoreaPhoneNumberFormatter();
			
		}
		
		public function removedfromstage_handler(event:Event):void {
			
			removeEventListener(Event.ADDED_TO_STAGE, addedtostage_handler);
			alPhone.removeAll();
			removeReaervation();
			removeInterval();
			
			removeExcel();
			removeSendModeAddress();
			removeSendAddress();
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
			else if (instance == sendListInput) {
				sendListInput.addEventListener(FlexEvent.ENTER, sendListInput_enterHandler);
				sendListInput.addEventListener(FocusEvent.FOCUS_OUT, sendListInput_focusOutHandler);
			}
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
			else if (instance == addUrl) addUrl.addEventListener(MouseEvent.CLICK, addUrl_clickHandler);
			else if (instance == addImage) addImage.addEventListener(MouseEvent.CLICK, addImage_clickHandler);
			else if (instance == addTxt) addTxt.addEventListener(MouseEvent.CLICK, addTxt_clickHandler);
			else if (instance == addTxtLayer) {
				addTxtLayer.dataProvider = acMearge;
				addTxtLayer.labelField = "label";
				addTxtLayer.addEventListener(IndexChangeEvent.CHANGE, addTxtLayer_changeHandler);
			}
			else if (instance == addMMSLayer) {
				addMMSLayer.dataProvider = acMMS;
				addMMSLayer.labelField = "label";
				addMMSLayer.addEventListener(IndexChangeEvent.CHANGE, addMMSLayer_changeHandler);
			}
				
			else if (instance == removeMsg) removeMsg.addEventListener(MouseEvent.CLICK, removeMsg_clickHandler);
				
			else if (instance == ePre) ePre.addEventListener(MouseEvent.CLICK, ePre_clickHandler);
			else if (instance == eUpdate) eUpdate.addEventListener(MouseEvent.CLICK, eUpdate_clickHandler);
			else if (instance == eCancel) eCancel.addEventListener(MouseEvent.CLICK, eCancel_clickHandler);
			else if (instance == eNext) eNext.addEventListener(MouseEvent.CLICK, eNext_clickHandler);
			else if (instance == addressView) addressView.addEventListener(MouseEvent.CLICK, addressView_clickHandler);
			else if (instance == addressCombo)	addressCombo.dataProvider = addressGroupList;
			else if (instance == addressSave) addressSave.addEventListener(MouseEvent.CLICK, addressSave_clickHandler);
			else if (instance == addressBoxClose) addressBoxClose.addEventListener(MouseEvent.CLICK, addressView_clickHandler);
			else if (instance == sendSetting) sendSetting.addEventListener(MouseEvent.CLICK, sendSetting_clickHandler);
			else if (instance == sendDelmsg) {
				//if (cookie_msgDel && cookie_msgDel.length > 0) { sendDelmsg.selected = true; }
				sendDelmsg.addEventListener(Event.CHANGE, sendDelmsg_changeHandler);
			}
			else if (instance == sendDelList) {
				//if (cookie_listDel && cookie_listDel.length > 0) { instance.selected = true; }
				sendDelList.addEventListener(Event.CHANGE, sendDelList_changeHandler);
			}
			
			
			
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
			else if (instance == sendListInput) {
				sendListInput.removeEventListener(FlexEvent.ENTER, sendListInput_enterHandler);
				sendListInput.removeEventListener(FocusEvent.FOCUS_OUT, sendListInput_focusOutHandler);
			}
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
			else if (instance == addImage) addImage.removeEventListener(MouseEvent.CLICK, addImage_clickHandler);
			else if (instance == addTxt) addTxt.removeEventListener(MouseEvent.CLICK, addTxt_clickHandler);
			else if (instance == removeMsg) removeMsg.removeEventListener(MouseEvent.CLICK, removeMsg_clickHandler);
			else if (instance == addTxtLayer) {
				addTxtLayer.removeEventListener(IndexChangeEvent.CHANGE, addTxtLayer_changeHandler);
				addTxtLayer.dataProvider.removeAll();
				acMearge.removeAll();
				acMearge = null;
			}
			else if (instance == sendSetting) sendSetting.removeEventListener(MouseEvent.CLICK, sendSetting_clickHandler);
			else if (instance == sendDelmsg) {sendDelmsg.removeEventListener(Event.CHANGE, sendDelmsg_changeHandler);}
			else if (instance == sendDelList) {sendDelList.removeEventListener(Event.CHANGE, sendDelList_changeHandler);}
			
			
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
		
		private function tracker(msg:String):void {
			MunjaNote(parentApplication).googleTracker("Send/"+msg);
		}
		private function trackerEvent(category:String,action:String,label:String,value:Number):void {
			//MunjaNote(parentApplication).googleTrackerEvent(category,action,label,value);
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
				//else if (viewFunction == "sendListFromAddress") toggleSendModeAddress();
			else if (viewFunction == "sendListFromAddress") toggleSendAddress();
			else if (viewFunction == "sendListFromSent") toggleSendModeLog();
			else if (viewFunction == "sendListFromCopy") togglePaste();
			
			
			// create
			if (item.name == "myMessage") emoticonView("myMessage");
			else if (item.name == "specialChar") emoticonView("specialChar");
			else if (item.name == "emoticon") emoticonView("emoticon");
			else if (item.name == "sentMessage") emoticonView("sentMessage");
				
			else if (item.name == "sendListFromExcel")toggleExcel(); 
				//else if (item.name == "sendListFromAddress") toggleSendModeAddress();
			else if (item.name == "sendListFromAddress") toggleSendAddress();
			else if (item.name == "sendListFromSent") toggleSendModeLog();
			else if (item.name == "sendListFromCopy") togglePaste();
			
			viewFunction = item.name;
			
			tracker("sendListInput/"+item.name);// tracker
		}
		
		
		/**
		 * global function
		 * */
		public function isValid():void {
			
			var validMessage:String = "";
			var subMessage:String = "";
			
			sendBtn.enabled = false;
			
			if ( msg == "" ) {
				validMessage = "메시지를 입력 하세요.";
				subMessage = "90Byte 이상 입력시 LMS로 자동 전환됩니다.";
			}
			else if (this.alPhone.length <= 0) {
				validMessage = "전화번호를 추가하세요.";
				subMessage = "아래 대량입력, 주소록, 엑셀등 글씨를 클릭 하여 추가 하실 수 있습니다.";
			}
			else if (rt.returnPhone == "" || rt.returnPhone == "null" || rt.returnPhone == null) {
				validMessage = "회신번호를 입력하세요.";
				subMessage = "여러 번호를 저장 하거나 선택 할 수 있습니다.";
			}
			else {
				validMessage = "보내기 버튼을 누르면 전송 됩니다.";
				subMessage = "예약 설정 또는 간격설정을 하실 수 있습니다.";
				
				if (isMearge() == true) { confirm_mearge.text = " 합성 "; }
				else { confirm_mearge.text = "";}
				
				sendBtn.enabled = true;
				
			}
			
			
			
			confirm_text.visible = sendBtn.enabled;
			
			title_text.text = validMessage;
			titleSub_text.text = subMessage;
			
		}
		public function initReturnPhone():void {
			rt.getReturnPhone();
		}
		
		private function isMearge():Boolean {
			var chkMearg:RegExp = /(\{이름\}|\{합성1\}|\{합성2\}|\{합성3\})+/g;
			
			if (chkMearg.test(msg)) return true;
			else return false;
		}
		
		/**
		 * message function
		 * */
		protected function message_keyUpHandlerAutoMode(event:KeyboardEvent):void {
			msg_ByteCheck();
			messageCheck();
		}
		
		private function messageCheck():void {
			
			if (arrImage && arrImage.length > 0) sendMode = "MMS";
			else if ( currentByte > Gv.SMS_BYTE ) sendMode = "LMS";
			else sendMode = "SMS";
			
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
						if (eLayer.visible) eLayer.visible = false;
					}
					else SLibrary.alert("잘못된 전화번호 입니다.");
				}
				else
					SLibrary.alert("전화번호를 입력하세요.");
			}
			
		}
		protected function sendListInput_focusOutHandler(event:Event):void {
			
			if ( alPhone ) {
				
				if (sendListInput.text != "") {
					if (SLibrary.bKoreaPhoneCheck( sendListInput.text )) {
						addPhone(sendListInput.text, "");
						sendListInput.text = "";
						if (eLayer.visible) eLayer.visible = false;
					}
					else SLibrary.alert("잘못된 전화번호 입니다.");
				}
			}
			
		}
		private function getPvo(pno:String, pname:String):PhoneVO {
			
			var pvo:PhoneVO = new PhoneVO();
			pvo.pName = pname;
			pvo.pNo = pno;
			
			return pvo;
		}
		
		// edite Phone
		private var editePhoneIndex:int = -1;
		/**
		 * Edite phone
		 * */
		public function editePhone(pvo:PhoneVO):void {
			
			this.editePhoneIndex = this.alPhone.getItemIndex(pvo);
			var arr:Array = getEditePhone(pvo);
			ePhone.text = arr[0];
			eName.text = arr[1];
			eMearge1.text = arr[2];
			eMearge2.text = arr[3];
			eMearge3.text = arr[4];
			eLayer.visible = true;
			sendList.visible = false;
			autoEditeBtnView();
		}
		
		private function getEditePhone(pvo:PhoneVO):Array {
			
			var arr:Array = [pvo.pNo,"","","",""];
			
			var arrTemp:Array = pvo.pName.split(Send.PHONE_DIV);
			if (arrTemp != null && arrTemp.length > 0) {arr[1] = arrTemp[0];}
			if (arrTemp != null && arrTemp.length > 1) {arr[2] = arrTemp[1];}
			if (arrTemp != null && arrTemp.length > 2) {arr[3] = arrTemp[2];}
			if (arrTemp != null && arrTemp.length > 3) {arr[4] = arrTemp[3];}
			
			return arr;
		}
		private function getEditePhoneVO():PhoneVO {
			
			var pvo:PhoneVO = new PhoneVO();
			pvo.pNo = ePhone.text;
			pvo.pName = eName.text + Send.PHONE_DIV + eMearge1.text + Send.PHONE_DIV + eMearge2.text + Send.PHONE_DIV + eMearge3.text;
			
			return pvo;
		}
		private function ePre_clickHandler(event:MouseEvent):void {
			var idx:int = this.editePhoneIndex -1;
			if (this.editePhoneIndex >= 0) {
				eUpdateRun();
				editePhone(this.alPhone.getItemAt(idx) as PhoneVO);
			}
		}
		private function eUpdate_clickHandler(event:MouseEvent):void {
			
			eUpdateRun();
			eCancel_clickHandler(null);
		}
		private function eUpdateRun():void {
			var idx:int = this.editePhoneIndex;
			if (this.editePhoneIndex >= 0) {
				var vo:PhoneVO = this.alPhone.getItemAt(idx) as PhoneVO;
				var evo:PhoneVO = getEditePhoneVO();
				vo.pNo = evo.pNo;
				vo.pName = evo.pName;
			}
		}
		private function eCancel_clickHandler(event:MouseEvent):void {
			eLayer.visible = false;
			sendList.visible = true;
		}
		private function eNext_clickHandler(event:MouseEvent):void {
			var idx:int = this.editePhoneIndex +1;
			if (this.editePhoneIndex < this.alPhone.length) {
				eUpdateRun();
				editePhone(this.alPhone.getItemAt(idx) as PhoneVO);
			}
		}
		
		private function autoEditeBtnView():void {
			
			ePre.enabled = (this.editePhoneIndex > 0);
			eNext.enabled = (this.editePhoneIndex < (this.alPhone.length-1));
		}
		
		//-----------------------------------
		// Save Address methods Start
		//-----------------------------------
		private function addressView_clickHandler(event:MouseEvent):void {
			var bBox:Boolean = addressBox.visible;
			addressBox.visible = !bBox;
			sendBox.visible = bBox;
			if (bBox == false) {
				getGroup();
			}
		}
		private function getGroup():void {
			
			if (Gv.bLogin) {
				RemoteSingleManager.getInstance.addEventListener("getAddrList", getGroup_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.getAddrList(0, "");
			}
		}
		private function getGroup_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("getAddrList", getGroup_resultHandler);
			var acGroup:ArrayCollection = event.result as ArrayCollection;
			addressGroupList.removeAll();
			var arr:Array = [];
			if (acGroup != null && acGroup.length > 0) {
				
				var avo:AddressVO = null;
				addressGroupList.removeAll();
				for (var i:Number = 0; i < acGroup.length; i++) {
					avo = acGroup.getItemAt(i) as AddressVO;
					if (avo.grpName != "전체") {
						addressGroupList.addItem(avo.grpName);
					}
					
				}
				
			}
		}
		private function addressSave_clickHandler(event:MouseEvent):void {
			
			if (alPhone == null || alPhone.length <= 0) {
				SLibrary.alert("전화번호를 추가 후 저장 하세요.");
			} else {
				var grp:String = addressCombo.selectedItem as String;
				if (grp == null || grp == "") {
					SLibrary.alert("주소록 그룹을 선택하거나 입력하세요.");
				}else if (grp == "전체") {
					SLibrary.alert("전체 그룹으로 저장 할 수 없습니다.");
				} else {
					addressSave.bLoading = true;
					addressBoxClose.enabled = false;
					var acRslt:ArrayCollection = parseAddress(alPhone);
					RemoteSingleManager.getInstance.addEventListener("modifyManyAddr", addressSave_resultHandler, false, 0, true);
					RemoteSingleManager.getInstance.callresponderToken 
						= RemoteSingleManager.getInstance.service.modifyManyAddr(31, acRslt, grp);
				}
				
			}
		}
		private function addressSave_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("modifyManyAddr", addressSave_resultHandler);
			var i:int = event.result as int;
			if (i > 0) {
				SLibrary.alert(String(addressCombo.selectedItem)+" 그룹에 저장 되었습니다.");
				addressView_clickHandler(null);
				//this.dispatchEvent( new CustomEvent("saveAddress", String(addressCombo.selectedItem) ));
			}
			else SLibrary.alert("저장 되지 않았습니다.");
			
			addressSave.bLoading = false;
			addressBoxClose.enabled = true;
		}
		private function parseAddress(al:ArrayCollection):ArrayCollection {
			
			var rslt:ArrayCollection = new ArrayCollection();
			if (al != null && al.length > 0) {
				var cnt:int = al.length;
				var avo:AddressVO = new AddressVO();
				var pvo:PhoneVO = new PhoneVO();
				for (var i:int = 0; i < cnt; i++) {
					pvo = al.getItemAt(i) as PhoneVO;
					avo = getAddressVO(pvo);
					rslt.addItem(avo);
				}
			}
			return rslt;
		}
		private function getAddressVO(pvo:PhoneVO):AddressVO {
			var avo:AddressVO = null;
			if (pvo != null) {
				avo = new AddressVO();
				avo.phone = pvo.pNo;
				var arr:Array = getNameMemo(pvo.pName);
				avo.name = arr[0];
				avo.memo = arr[1];	
			}
			
			return avo;
		}
		private function getNameMemo(str:String):Array {
			var arr:Array = new Array(2);
			if (str != null) {
				var val:Array = str.split(Send.PHONE_DIV);
				if (val != null) {
					for (var i:int = 0; i < val.length; i++) {
						if (i == 0) arr[0] = val[0];
						else {
							arr[1]+=val[i]+"\n";
						}
					}
				}
			}
			return arr;
		}
		//-----------------------------------
		// Save Address methods End
		//-----------------------------------
		
		
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
			tracker("dupleDelete_clickHandler");// tracker
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
			tracker("messageSaveBtn_clickHandler");// tracker
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
		private function callback_changeHandler(event:Event):void { 
			isValid();
			tracker("callback_changeHandler");// tracker 
		}
		
		
		
		/**
		 * send function
		 * */
		private function sendBtn_clickHandler(event:MouseEvent):void {
			
			removeSending();
			
			var smvo:SendMessageVO = new SendMessageVO();
			
			smvo.bInterval = false;
			smvo.bMerge = isMearge();
			
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
			
			smvo.urlKey = urlKey;
			
			smvo.imagePath = this.mmsImage; 
			smvo.message = msg;
			smvo.returnPhone = rt.returnPhone;
			smvo.al = alPhone;
			
			
			RemoteSingleManager.getInstance.addEventListener("sendSMSconf", sendBtn_resultHandler, false, 0, true);
			RemoteSingleManager.getInstance.callresponderToken 
				= RemoteSingleManager.getInstance.service.sendSMSconf(smvo);
			
			createSending();
			tracker("sendBtn_clickHandler");// tracker
		}
		private function sendBtn_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("sendSMSconf", sendBtn_resultHandler);
			
			var lvo:LogVO = event.result as LogVO;
			if (lvo != null && lvo.idx != 0) {
				sendClickAfter();
				sending.sendingCompleted(lvo);
				this.dispatchEvent(new Event(Send.SEND_COMPLET));
				trackerEvent(lvo.line, lvo.mode, lvo.user_id, lvo.cnt);
			} else {
				removeSending();
				if (lvo != null) {
					if (lvo.message == "no login") { 
						MunjaNote(parentApplication).loginCheck();
					}
					else 
						SLibrary.alert(lvo.message);
				}
				else
					SLibrary.alert("발송 실패");
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
			
			tracker("createSending");// tracker
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
		 * SendAddress
		 * */
		private function toggleSendAddress():void {
			
			if (sa == null) createSendAddress();
			else removeSendAddress();
		}
		private function createSendAddress():void {
			sa = new Address(true);
			sa.addEventListener("sendAddress", sa_sendHandler);
			sa.addEventListener("close", sa_closeHandler);
			this.functionGroup.addElement(sa);
		}
		private function sa_sendHandler(event:CustomEvent):void {
			addPhoneList( event.result as ArrayCollection );
		}
		private function sa_closeHandler(event:Event):void {
			removeSendAddress();
		}
		private function removeSendAddress():void {
			
			if (sa != null) {
				sa.removeEventListener("sendAddress", sa_sendHandler);
				sa.removeEventListener("close", sa_closeHandler);
				this.functionGroup.removeElement(sa);
				sa = null;
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
			setTotalCount();
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
			tracker("sendReservation_changeHandler");// tracker
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
			confirm_reservation.text = sendReservation.label;
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
			tracker("sendInterval_changeHandler");// tracker
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
			var img:BitmapImage = new BitmapImage();
			img.source = source;
			img.smooth = true;
			img.width = 260;
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
		public function uploadInit():void {
			// 업로드 초기화
			this.fur = new FileUploadByRemoteObject("smt");
			this.fur.addEventListener(FileUploadByRemoteObjectEvent.COMPLETE, FileUploadByRemoteObjectCOMPLETEHandler);
			this.fur.addEventListener(FileUploadByRemoteObjectEvent.RESULT, FileUploadByRemoteObjectRESULTHandler);
			this.fur.addEventListener(FileUploadByRemoteObjectEvent.FAULT, FileUploadByRemoteObjectFAULTHandler);
		}
		private function addImage_clickHandler(event:MouseEvent):void {
			
			addMMSLayer.visible = !addMMSLayer.visible;
		}
		private function uploadImage():void {
			uploadInit();
			this.fur.addFiles();
		}
		
		private function FileUploadByRemoteObjectCOMPLETEHandler(e:FileUploadByRemoteObjectEvent):void {
			
			if ( Number(this.fur.UploadFiles[this.fur.UploadFiles.length -1].realsize) > Number(1024*1024*1) ) {
				this.fur.UploadFiles.pop();
				destoryUpload();
				SLibrary.alert("1MB 이상의 파일은 사용 하실 수 없습니다.");
			}else {
				upload( e.data, e.fileName );
			}
		}
		public function upload(data:ByteArray, fName:String):void {
			uploadInit();
			this.fur.remoteObject.setMMSUpload( data, fName );
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
			if (moduleLoaderIme != null)
				moduleLoaderIme.unloadModule();
		}
		
		
		/**
		 * addTxt
		 * */
		private function addTxt_clickHandler(event:MouseEvent):void {
			
			addTxtLayer.visible = !addTxtLayer.visible;
			tracker("addTxt_clickHandler");// tracker
		}
		private function addTxtLayer_changeHandler(event:IndexChangeEvent):void {
			
			var item:Object = addTxtLayer.selectedItem;
			
			if (item != null) {
				var lable:String = item.data;
				addMsgCusor(lable);
				addTxtLayer.selectedIndex = -1;
				addTxtLayer.visible = false;
				
				// byte check
				message_keyUpHandlerAutoMode(null);
				SLibrary.alert("SMS로 합성 할 경우 90byte 이상 문자는 잘릴 수 있습니다.");
			}
			tracker("addTxtLayer_changeHandler");// tracker
		}
		private function addMsgCusor(msg:String):void {
			
			var pos:int = message.selectionActivePosition;
			
			if (pos != -1) {
				message.text = message.text.substr(0, pos) + msg + message.text.substr(pos, message.text.length - pos);
			} else {
				message.text += msg;
			}
			message.selectRange(pos + msg.length, pos + msg.length);
		}
		
		/**
		 * webEditor Moduel
		 * */
		private function addUrl_clickHandler(event:MouseEvent):void {
			createModuleUrl("module/url/MobileWebEditor.swf");
		}
		public function createModuleUrl(s:String):void {
			
			if (moduleLoaderUrl == null) { moduleLoaderUrl = new ModuleLoader(); }
			loading.visible = true;
			moduleLoaderUrl.addEventListener(ModuleEvent.READY, url_moduleReadyHandler);
			if (!moduleLoaderUrl.url) { moduleLoaderUrl.url = s; }
			moduleLoaderUrl.loadModule();
		}
		private function url_moduleReadyHandler(event:ModuleEvent):void {
			var ichild:IMobileWebEditor = moduleLoaderUrl.child as IMobileWebEditor;
			if (moduleLoaderUrl.child != null) { ichild.setKey(urlKey);} 
			loading.visible = false;
		}
		public function setUrl(key:int):void {
			trace("key is "+key);
			urlKey = key;
			addMsgCusor(Send.MWEB_URL);
			SLibrary.alert(Send.MWEB_URL+" 를 지우면 URL 발송이 되지 않습니다.");
		}
		
		public function removeModuleUrl():void {
			
			if (moduleLoaderUrl != null) {
				moduleLoaderUrl.removeEventListener(ModuleEvent.READY, url_moduleReadyHandler);
				moduleLoaderUrl.unloadModule();
			}
			loading.visible = false;
		}
		/**
		 * ImageEditor Moduel
		 * */
		private function addMMSLayer_changeHandler(event:IndexChangeEvent):void {
			
			var item:Object = addMMSLayer.selectedItem;
			
			if (item != null) {
				var data:String = item.data;
				addMMSLayer.selectedIndex = -1;
				addMMSLayer.visible = false;
				if (data == "upload") uploadImage();
				else createModuleIme("/module/ie/ImageEditor.swf");
			}
			
		}
		public function createModuleIme(s:String):void {
			
			if (moduleLoaderIme == null) { moduleLoaderIme = new ModuleLoader(); }
			loading.visible = true;
			moduleLoaderIme.addEventListener(ModuleEvent.READY, ime_moduleReadyHandler);
			if (!moduleLoaderIme.url) { moduleLoaderIme.url = s; }
			moduleLoaderIme.loadModule();
		}
		private function ime_moduleReadyHandler(event:ModuleEvent):void {
			loading.visible = false;
		}
		
		public function removeModuleIme():void {
			
			if (moduleLoaderIme != null) {
				moduleLoaderIme.removeEventListener(ModuleEvent.READY, ime_moduleReadyHandler);
				moduleLoaderIme.unloadModule();
			}
			loading.visible = false;
		}
		
		
		/**
		 * sendSetting
		 * */
		public function sendSetting_clickHandler(event:MouseEvent):void {
			sendSetBox.visible = !sendSetBox.visible;
		}
		private function sendDelmsg_changeHandler(event:Event):void {
			if (sendDelmsg.selected) {
				//CookieUtil.setCookie(SAVE_MSGDEL,"Y",365);
			}else {
				//CookieUtil.deleteCookie(SAVE_MSGDEL);
			}
		}
		private function sendDelList_changeHandler(event:Event):void {
			if (sendDelList.selected) {
				//CookieUtil.setCookie(SAVE_LISTDEL,"Y",365);
			}else {
				//CookieUtil.deleteCookie(SAVE_LISTDEL);
			}
		}
		private function sendClickAfter():void {
			if (sendDelmsg.selected) {
				this.msg = "";
				allDelImage();
			}
			if (sendDelList.selected) {
				alPhone.removeAll();
				setTotalCount();
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