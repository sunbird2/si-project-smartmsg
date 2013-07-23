package component.excel
{
	
	import component.util.ButtonSpinner;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import lib.CustomEvent;
	import lib.Gv;
	import lib.RemoteSingleManager;
	import lib.SLibrary;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.ClassFactory;
	import mx.data.ItemReference;
	import mx.rpc.events.ResultEvent;
	
	import skin.excel.ExcelAddressSkin;
	import skin.excel.ExcelMearg_GridItemRenderer;
	import skin.excel.ExcelName_GridItemRenderer;
	import skin.excel.ExcelPhone_GridItemRenderer;
	import skin.excel.ExcelSkin;
	
	import spark.components.Button;
	import spark.components.ComboBox;
	import spark.components.DataGrid;
	import spark.components.DropDownList;
	import spark.components.Image;
	import spark.components.Label;
	import spark.components.List;
	import spark.components.RichText;
	import spark.components.TextArea;
	import spark.components.gridClasses.GridColumn;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.IndexChangeEvent;
	import spark.skins.spark.DefaultGridItemRenderer;
	
	import valueObjects.AddressVO;
	import valueObjects.ExcelLoaderResultVO;
	import valueObjects.PhoneVO;
	
	[SkinState("normal")]
	[SkinState("upload")]
	[SkinState("actionSend")]
	[SkinState("actionAddress")]
	
	[Event(name="send", type="lib.CustomEvent")]
	[Event(name="saveAddress", type="lib.CustomEvent")]
	[Event(name="close", type="flash.events.Event")]
	
	public class Excel extends SkinnableComponent
	{
		[SkinPart(required="false")]public var helpText:RichText;
		[SkinPart(required="false")]public var openBtn:Button;
		[SkinPart(required="false")]public var phoneCombo:ComboBox;
		[SkinPart(required="false")]public var nameCombo:ComboBox;
		[SkinPart(required="false")]public var memoCombo:ComboBox;
		[SkinPart(required="false")]public var meargCombo1:ComboBox;
		[SkinPart(required="false")]public var meargCombo2:ComboBox;
		[SkinPart(required="false")]public var meargCombo3:ComboBox;
		[SkinPart(required="false")]public var addressCombo:ComboBox;
		[SkinPart(required="false")]public var addressBtn:ButtonSpinner;
		[SkinPart(required="false")]public var sendBtn:Button;
		[SkinPart(required="false")]public var excelView:DataGrid;
		//[SkinPart(required="false")]public var resultList:List;
		[SkinPart(required="false")]public var close:Image;
		
		
		[SkinPart(required="false")]public var pasteLabel:Label;
		[SkinPart(required="false")]public var pasteCombo:DropDownList;
		[SkinPart(required="false")]public var pasteOk:Button;
		[SkinPart(required="false")]public var excelInput:TextArea;
		[SkinPart(required="false")]public var pasteCancel:Button;
		
		
		
		
		private const NONE:int = 0;
		private const UPLOADED:int = 1;
		private const SELPHONE:int = 2;
		
		private var _currStat:String = "normal";

		private var acRslt:ArrayCollection = new ArrayCollection();
		private var acExcel:ArrayCollection = new ArrayCollection();
		
		private var pvo:PhoneVO;
		private var avo:AddressVO;
		
		private var refUploadFile:FileReference = new FileReference();
		private var uploadFiles:Array = new Array();
		
		private var _bFromAddress:Boolean = false;
		
		private var acDelimiter:ArrayCollection =  new ArrayCollection([
			{label:"탭", data:"\t"},
			{label:"쉼표", data:","},
			{label:"공백", data:" "},
			{label:"줄바꿈", data:"\n"}
		]);
		
		
		public function Excel(bAddress:Boolean=false)	{
			super();
			
			if (bAddress == true)
				setStyle("skinClass", ExcelAddressSkin);
			else
				setStyle("skinClass", ExcelSkin);
			
			addEventListener(Event.REMOVED_FROM_STAGE, destroy, false, 0, true);
		}
		
		public function get bFromAddress():Boolean { return _bFromAddress; }
		public function set bFromAddress(value:Boolean):void { _bFromAddress = value; }

		public function get currStat():String { return _currStat; }
		public function set currStat(value:String):void { 
			_currStat = value;
			invalidateSkinState();
		}

		override protected function getCurrentSkinState():String {
				
			return currStat;
		} 
		
		override protected function partAdded(partName:String, instance:Object) : void {
			super.partAdded(partName, instance);
			
			if (instance == openBtn) openBtn.addEventListener(MouseEvent.CLICK, openBtn_clickHandler );
			else if (instance == helpText) helpText.text = "엑셀열기를 클릭 하거나 붙여 넣으세요.";
			else if (instance == phoneCombo) {
				setComboBoxData(phoneCombo, "전화번호열");
				phoneCombo.addEventListener(IndexChangeEvent.CHANGE, phoneCombo_changeHandler);
			}
			else if (instance == nameCombo) {
				setComboBoxData(nameCombo, "이름열");
				nameCombo.addEventListener(IndexChangeEvent.CHANGE, nameCombo_changeHandler);
			}
			else if (instance == memoCombo) {
				setComboBoxData(memoCombo, "메모열");
				memoCombo.addEventListener(IndexChangeEvent.CHANGE, memoCombo_changeHandler);
			}
			else if (instance == meargCombo1) {
				setComboBoxData(meargCombo1, "합성1");
				meargCombo1.addEventListener(IndexChangeEvent.CHANGE, meargCombo_changeHandler);
			}
			else if (instance == meargCombo2) {
				setComboBoxData(meargCombo2, "합성2");
				meargCombo2.addEventListener(IndexChangeEvent.CHANGE, meargCombo_changeHandler);
			}
			else if (instance == meargCombo3) {
				setComboBoxData(meargCombo3, "합성3");
				meargCombo3.addEventListener(IndexChangeEvent.CHANGE, meargCombo_changeHandler);
			}
			else if (instance == sendBtn) sendBtn.addEventListener(MouseEvent.CLICK, sendBtn_clickHandler);
			/*else if (instance == resultList) {
				resultList.dataProvider = acRslt;
				resultList.labelFunction = resultListLabelFunc;
			}*/
			else if (instance == excelView) excelView.dataProvider = acExcel;
			else if (instance == addressCombo){
				addressCombo.dataProvider = Gv.addressGroupList;
				//if (Gv.addressGroupList.length > 0) {
				//	addressCombo.selectedIndex = 0;
				//}
			}
			else if (instance == addressBtn) addressBtn.addEventListener(MouseEvent.CLICK, addressBtn_clickHandler);
			else if (instance == close) {
				if (bFromAddress) {
					close.visible = true;
					close.addEventListener(MouseEvent.CLICK, close_clickHandler);
				}
				else close.visible = false;
			}
			else if (instance == excelInput){
				excelInput.addEventListener(KeyboardEvent.KEY_UP, excelInput_keyboardUpHandler);
			}
			else if (instance == pasteCombo){
				pasteCombo.dataProvider = acDelimiter;
				pasteCombo.addEventListener(IndexChangeEvent.CHANGE, pasteCombo_changeHandler);
			}
			else if (instance == pasteOk){
				pasteOk.addEventListener(MouseEvent.CLICK, pasteOk_clickHandler);
			}
			else if (instance == pasteCancel){
				pasteCancel.addEventListener(MouseEvent.CLICK, pasteCancel_clickHandler);
			}
			
			
			
			
			
			
			//else if (instance == message) message.addEventListener(KeyboardEvent.KEY_UP, message_keyUpHandlerAutoMode);
		}
		
		override protected function partRemoved(partName:String, instance:Object) : void {
			super.partRemoved(partName, instance);
			
			if (instance == openBtn) openBtn.removeEventListener(MouseEvent.CLICK, openBtn_clickHandler );
			else if (instance == phoneCombo) phoneCombo.removeEventListener(IndexChangeEvent.CHANGE, phoneCombo_changeHandler);
			else if (instance == nameCombo)	nameCombo.removeEventListener(IndexChangeEvent.CHANGE, nameCombo_changeHandler);
			else if (instance == sendBtn) sendBtn.removeEventListener(MouseEvent.CLICK, sendBtn_clickHandler);
			else if (instance == addressCombo) addressCombo.dataProvider = null;
			else if (instance == addressBtn) addressBtn.removeEventListener(MouseEvent.CLICK, addressBtn_clickHandler);
			else if (instance == close) {
				if (bFromAddress) {
					close.removeEventListener(MouseEvent.CLICK, close_clickHandler);
				}
			}
			else if (instance == excelInput){
				excelInput.removeEventListener(KeyboardEvent.KEY_UP, excelInput_keyboardUpHandler);
			}
			else if (instance == pasteCombo){
				pasteCombo.dataProvider = null;
				pasteCombo.removeEventListener(IndexChangeEvent.CHANGE, pasteCombo_changeHandler);
			}
			else if (instance == pasteOk){
				pasteOk.removeEventListener(MouseEvent.CLICK, pasteOk_clickHandler);
			}
			else if (instance == pasteCancel){
				pasteCancel.removeEventListener(MouseEvent.CLICK, pasteCancel_clickHandler);
			}
		}
		
		
		private function resultListLabelFunc(item:Object):String {

			if (bFromAddress)
				return item.phone + " " + item.name+ " " + item.memo;
			else
				return item.pNo + " " + item.pName;	
			 
		}
		
		private function sendBtn_clickHandler(event:MouseEvent):void {
			
			if (acRslt != null && acRslt.length > 0)
				dispatchEvent(new CustomEvent("send", acRslt ) );
			else
				SLibrary.alert("전송할 전화번호가 없습니다.");
		}
		private function phoneCombo_changeHandler(event:IndexChangeEvent):void {
			
			if (event.oldIndex > 0)
				GridColumn( excelView.columns.getItemAt(event.oldIndex) ).itemRenderer = new ClassFactory(DefaultGridItemRenderer);	
			
			if ( event.newIndex > 0 ) {
				
				GridColumn( excelView.columns.getItemAt(event.newIndex) ).itemRenderer = new ClassFactory(ExcelPhone_GridItemRenderer);	
		
				convertPhoneAcFromExcel();
				setStep(SELPHONE);
				
			} else {
				setStep(UPLOADED);
			}
		}
		
		private function nameCombo_changeHandler(event:IndexChangeEvent):void {
			
			if (event.oldIndex > 0)
				GridColumn( excelView.columns.getItemAt(event.oldIndex) ).itemRenderer = new ClassFactory(DefaultGridItemRenderer);	
			
			if ( event.newIndex > 0 ) {
				GridColumn( excelView.columns.getItemAt(event.newIndex) ).itemRenderer = new ClassFactory(ExcelName_GridItemRenderer);
				
				convertPhoneAcFromExcel();
			} 
		}
		
		private function memoCombo_changeHandler(event:IndexChangeEvent):void {
			
			if ( memoCombo.selectedIndex >= 0 ) {
				
				convertPhoneAcFromExcel();
			} 
		}
		
		
		private function meargCombo_changeHandler(event:IndexChangeEvent):void {
			
			if (event.oldIndex > 0)
				GridColumn( excelView.columns.getItemAt(event.oldIndex) ).itemRenderer = new ClassFactory(DefaultGridItemRenderer);	
			
			if ( event.newIndex > 0 ) {
				GridColumn( excelView.columns.getItemAt(event.newIndex) ).itemRenderer = new ClassFactory(ExcelMearg_GridItemRenderer);
				convertPhoneAcFromExcel();
			} 
		}
		
		
		private function viewPasteComponent(b:Boolean):void {
			pasteLabel.visible = b;
			pasteCombo.visible = b;
			pasteOk.visible = b;
			pasteCancel.visible = b;
			
			excelView.visible = b;
			excelInput.visible = !b;
		}
		private function pasteCombo_changeHandler(event:IndexChangeEvent):void {
			
			var rows:String = parseChar("\n");
			var cols:String = parseChar(pasteCombo.selectedItem.data);
			
			var str:String = excelInput.text;
			
			if (str == "") SLibrary.alert("입력 또는 붙여 넣으세요.");
			else if (cols == "") SLibrary.alert("구분자를 선택 하세요.");
			else {
				
				
				var arrRow:Array = str.split(rows);
				var cnt:int = arrRow.length;
				
				var ac:ArrayCollection = new ArrayCollection();
				for ( var i:int = 0; i < cnt; i++ ) {
					ac.addItem( parseCol( String(arrRow[i]).split(cols), i+1 ));
				}
				if (ac.length > 0) {
					acExcel.removeAll();
					excelView.dataProvider = null;
					acExcel.addAll(ac);
					excelView.dataProvider = acExcel;
				}else SLibrary.alert("구분자를 올바르게 선택하세요.");
			}
		}
		private function excelInput_keyboardUpHandler(event:KeyboardEvent):void {
			
			if (excelInput) {
				if (excelInput.text && excelInput.text.length > 0) {
					viewPasteComponent(true);
					if (pasteCombo) {
						pasteCombo.selectedIndex = 0;
						pasteCombo.dispatchEvent(new IndexChangeEvent(IndexChangeEvent.CHANGE));
					}
				} else {
					viewPasteComponent(false);
				}
			}
		}
		
		private function pasteOk_clickHandler(event:MouseEvent):void {
			setStep(UPLOADED);
		}
		private function pasteCancel_clickHandler(event:MouseEvent):void {
			excelInput.text = "";
			excelInput.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_UP));
		}
		
		// 역슬래시 인식위함.
		private function parseChar(s:String):String {
			
			var rslt:String = "";
			if (s == "\\n") rslt = "\n";else if (s == "\\t") rslt = "\t";else rslt = s;
			return rslt;
		}
		// 열 배열을 object로 변경
		private function parseCol(a:Array, no:int):Object {
			
			var obj:Object = new Object();
			if ( a != null) {
				var cnt:int = a.length;
				obj["/"] = String(no);
				for ( var i:int = 0; i < cnt; i++) {
					obj[azCol(i+1)] = a[i];
				}
				
			}
			return obj;
		}
		// A~Z 열 타이틀 생성
		private function azCol(no:int):String {
			
			var rslt:String = "";
			var base:int = int("A".charCodeAt(0));
			var div:int = int("Z".charCodeAt(0)) - base + 1;		
			
			if ( (no-1) >= 0 ){
				
				//twoLength String
				if ( no-1 >= div ) {
					rslt = String.fromCharCode( (base + (int)( (no-1)/div ) -1) ) ;
					rslt += String.fromCharCode( (base + (int)( (no-1)%div ) ) ) ;
				}else {
					rslt = String.fromCharCode( base+no-1 );
				}
			}
			return rslt;
		}
		
		
		
		private function convertPhoneAcFromExcel():void {
			
			if (acExcel != null) {
				var cnt:int = acExcel.length;
				var phone:String = "";
				var name:String = "";
				var memo:String = "";
				var bName:Boolean = nameCombo && nameCombo.selectedIndex > 0 ? true : false;
				var bMemo:Boolean = memoCombo && memoCombo.selectedIndex > 0 ? true : false;
				var bMearg1:Boolean = meargCombo1 && meargCombo1.selectedIndex > 0 ? true : false;
				var bMearg2:Boolean = meargCombo2 && meargCombo2.selectedIndex > 0 ? true : false;
				var bMearg3:Boolean = meargCombo3 && meargCombo3.selectedIndex > 0 ? true : false;
				var chkInvaildChar:RegExp = /[^0-9]/g;	
				
				acRslt.removeAll();
				
				
				for (var i:int = 0; i < cnt; i++) {
					
					phone = acExcel[i][phoneCombo.dataProvider.getItemAt(phoneCombo.selectedIndex).label] as String;
					
					name = "";
					if (phone != null)
						phone = phone.replace(chkInvaildChar,"");
					if (bName) {
						var obj:Object = acExcel[i][nameCombo.dataProvider.getItemAt(nameCombo.selectedIndex).label];
						name = (obj != null)? obj as String:"";
					}
					if (bMemo) {
						var obj2:Object = acExcel[i][memoCombo.dataProvider.getItemAt(memoCombo.selectedIndex).label];
						memo = (obj2 != null)? obj2 as String:"";
					}
					
					if (currStat == "actionSend") {
						var m1:String = "";
						var m2:String = "";
						var m3:String = "";
						if (bMearg1) {
							var mobj1:Object = acExcel[i][meargCombo1.dataProvider.getItemAt(meargCombo1.selectedIndex).label];
							m1 = (mobj1 != null)? mobj1 as String:"";
						}
						if (bMearg2) {
							var mobj2:Object = acExcel[i][meargCombo2.dataProvider.getItemAt(meargCombo2.selectedIndex).label];
							m2 = (mobj2 != null)? mobj2 as String:"";
						}
						if (bMearg3) {
							var mobj3:Object = acExcel[i][meargCombo3.dataProvider.getItemAt(meargCombo3.selectedIndex).label];
							m3 = (mobj3 != null)? mobj3 as String:"";
						}
						name += "|"+m1+"|"+m2+"|"+m3; 
						
					}
					
					// 0 이 빠진경우
					if (phone != null && int(phone) != 0 && phone.length > 6 && phone.substr(0,1) != "0")
						phone = "0"+phone;
					
					if (SLibrary.bKoreaPhoneCheck(phone)) {
						if (bFromAddress)
							acRslt.addItem( getAddressVO( phone, name, memo ) );
						else
							acRslt.addItem( getPhoneVO( phone, name ) );
					}
				}
				
				
				
				
				
				
				
			}
		}
		private function getPhoneVO(pno:String, pname:String):PhoneVO {
			pvo = new PhoneVO();
			pvo.pNo = pno;
			pvo.pName = pname;
			return pvo;
		}
		
		private function getAddressVO(ano:String, aname:String, amemo:String):AddressVO {
			avo = new AddressVO();
			
			avo.phone = ano;
			avo.name = aname;
			avo.memo = amemo;
			return avo;
		}
		
		
		private function openBtn_clickHandler(event:MouseEvent):void {
			
			refUploadFile.browse(); 
			refUploadFile.addEventListener(Event.SELECT,onFileSelect, false, 0, true); 
			refUploadFile.addEventListener(Event.COMPLETE,onFileComplete, false, 0, true);
		}
		/**
		 * file select
		 * */
		private function onFileSelect(event:Event):void { 
			
			uploadFiles.push({  name:refUploadFile.name, 
				size:formatFileSize(refUploadFile.size), 
				status:"initial",
				realsize:String(refUploadFile.size)
			});   
			
			refUploadFile.load(); 
			for ( var i:int = 0 ; i <  uploadFiles.length ; i++ ) { 
				if( uploadFiles[i].name == refUploadFile ) { 
					uploadFiles[i].status = "loaded";  
					break; 
				} 
			}
			
		}
		/**
		 * upload file
		 * */
		private function onFileComplete(event:Event):void {
			
			for ( var i:int = 0 ; i <  uploadFiles.length ; i++ ) { 
				if( uploadFiles[i].name == refUploadFile ) { 
					uploadFiles[i].status = "upload";  
					break; 
				} 
			}
			
			var data:ByteArray = new ByteArray(); 
			refUploadFile.data.readBytes(data,0,refUploadFile.data.length);					
			var fileName:String = refUploadFile.name;
			
			
			if ( Number(uploadFiles[0].realsize) > Number(1024*1024*10) ) {
				uploadFiles.pop();
				SLibrary.alert("10MB 이상의 파일은 사용 하실 수 없습니다.");
			}else {
				RemoteSingleManager.getInstance.addEventListener("getExcelLoaderData", excelUpload_RESULTHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.getExcelLoaderData( data, fileName );
			}
		}
		
		// Called to format number to file size 
		private function formatFileSize(numSize:Number):String { 
			
			var strReturn:String; 
			numSize = Number(numSize / 1000); 
			strReturn = String(numSize.toFixed(1) + " KB"); 
			if (numSize > 1000) { 
				numSize = numSize / 1000; 
				strReturn = String(numSize.toFixed(1) + " MB"); 
				if (numSize > 1000) { 
					numSize = numSize / 1000; 
					strReturn = String(numSize.toFixed(1) + " GB"); 
				} 
			}    
			return strReturn; 
		}
		
		
		private function excelUpload_RESULTHandler(e:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("getExcelLoaderData", excelUpload_RESULTHandler);
			var data:ExcelLoaderResultVO = e.result as ExcelLoaderResultVO;
			
			if (data.bResult) {
				acExcel.removeAll();
				acExcel.addAll(data.list);
				callLater(setStep, [UPLOADED]);
				
			}else {
				SLibrary.alert(data.strDescription);
			}
		}
		
		
		private function setComboBoxData(combo:ComboBox, label:String):void {
			
			var array:ArrayList = this.excelView.columns as ArrayList;
			
			if (array != null) {
				var count:uint = array.length;
				var temp:String = "";
				var columns:ArrayCollection = new ArrayCollection();
				
				columns.addItem({label: label, data:"" });
				for (var i:uint = 1; i < count; i++) {
					
					temp = (array.getItemAt(i) as GridColumn).dataField;
					columns.addItem({label:temp, data:temp });
				}
				
				combo.dataProvider = columns;
				
				if (columns.length > 0) combo.selectedIndex = 0;
			}
			
		}
		private function setStep(step:int):void {
			
			switch(step) {
				
				case NONE:
					helpText.text = "엑셀열기를 클릭 하거나 붙여 넣으세요.";
					currStat = "normal";
					break;
				case UPLOADED:
					helpText.text = "전화번호 열을 선택 하세요.";
					currStat = "upload";
					excelView.visible = true;
					break;
				case SELPHONE:
					
					if (bFromAddress) {
						helpText.text = "그룹을 선택 후 저장버튼을 클릭하세요.";
						currStat = "actionAddress";
					}
					else {
						helpText.text = "전송 추가 버튼을 클릭하세요.";
						currStat = "actionSend";
					}
					//resultList.visible = true;
						
					break;
			}
		}
		
		private function addressBtn_clickHandler(event:MouseEvent):void {
			
			var grp:String = addressCombo.selectedItem as String;
			if (grp == null || grp == "") {
				SLibrary.alert("주소록 그룹을 선택하거나 입력하세요.");
			} else {
				addressBtn.bLoading = true;
				RemoteSingleManager.getInstance.addEventListener("modifyManyAddr", addressBtn_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.modifyManyAddr(31, acRslt, addressCombo.selectedItem as String);
			}
			
		}
		private function addressBtn_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("modifyManyAddr", addressBtn_resultHandler);
			var i:int = event.result as int;
			if (i > 0) {
				this.dispatchEvent( new CustomEvent("saveAddress", String(addressCombo.selectedItem) ));
			}
			else SLibrary.alert("저장 되지 않았습니다.");
			
			addressBtn.bLoading = false;
		}
		private function close_clickHandler(event:MouseEvent):void {
			this.dispatchEvent(new Event("close"));
		}
		
		public function destroy(e:Event):void {
			
			if (openBtn != null) openBtn.removeEventListener(MouseEvent.CLICK, openBtn_clickHandler );
			if (phoneCombo != null) {
				phoneCombo.removeEventListener(IndexChangeEvent.CHANGE, phoneCombo_changeHandler);
				if (phoneCombo.dataProvider) Object(phoneCombo.dataProvider).removeAll();
				phoneCombo = null;
				
			}
			if (nameCombo != null) {
				nameCombo.removeEventListener(IndexChangeEvent.CHANGE, nameCombo_changeHandler);
				if (nameCombo.dataProvider) Object(nameCombo.dataProvider).removeAll();
				nameCombo = null;
			}
			if (addressCombo != null) {
				if (addressCombo.dataProvider) Object(addressCombo.dataProvider).removeAll();
				addressCombo = null;
			}
			
			
			
			if (sendBtn != null) sendBtn.removeEventListener(MouseEvent.CLICK, sendBtn_clickHandler);
			
			
			if (excelView != null) {
				if (excelView.dataProvider) Object(excelView.dataProvider).removeAll();
				excelView = null;
			}
				
			/*if (resultList != null) {
				resultList.labelFunction = null;
				resultList.itemRenderer = null;
				if (resultList.dataProvider) Object(resultList.dataProvider).removeAll();
				resultList = null;
			}*/
			
			if (acExcel != null) {
				acExcel.removeAll();
				acExcel = null;
			}
			if (acRslt != null) {
				acRslt.removeAll();
				acRslt = null;
			}
			
			if (uploadFiles != null) {
				for (var i:Number = 0; i < uploadFiles.length; i++) {
					delete uploadFiles[i];
				}
				uploadFiles = null;
			}
			
			pvo = null;
			
			helpText = null;
			openBtn = null;
			addressBtn = null;
			sendBtn = null;
			_currStat = null;
			
			refUploadFile.removeEventListener(Event.SELECT,onFileSelect); 
			refUploadFile.removeEventListener(Event.COMPLETE,onFileComplete);
			refUploadFile = null;

			RemoteSingleManager.getInstance.removeEventListener("getExcelLoaderData", excelUpload_RESULTHandler);
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy, false);
			
			
		}
		
	}
}