package component.excel
{
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import lib.CustomEvent;
	import lib.FileUploadByRemoteObject;
	import lib.FileUploadByRemoteObjectEvent;
	import lib.RemoteSingleManager;
	import lib.SLibrary;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.rpc.events.ResultEvent;
	
	import skin.excel.ExcelSkin;
	
	import spark.components.Button;
	import spark.components.ComboBox;
	import spark.components.DataGrid;
	import spark.components.List;
	import spark.components.RichText;
	import spark.components.gridClasses.GridColumn;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.IndexChangeEvent;
	
	import valueObjects.ExcelLoaderResultVO;
	import valueObjects.PhoneVO;
	
	[SkinState("normal")]
	[SkinState("upload")]
	[SkinState("action")]
	
	[Event(name="send", type="lib.CustomEvent")]
	
	public class Excel extends SkinnableComponent
	{
		[SkinPart(required="false")]public var helpText:RichText;
		[SkinPart(required="false")]public var openBtn:Button;
		[SkinPart(required="false")]public var phoneCombo:ComboBox;
		[SkinPart(required="false")]public var nameCombo:ComboBox;
		[SkinPart(required="false")]public var addressCombo:ComboBox;
		[SkinPart(required="false")]public var addressBtn:Button;
		[SkinPart(required="false")]public var sendBtn:Button;
		[SkinPart(required="false")]public var excelView:DataGrid;
		[SkinPart(required="false")]public var resultList:List;
		
		
		private const NONE:int = 0;
		private const UPLOADED:int = 1;
		private const SELPHONE:int = 2;
		
		private var _currStat:String = "normal";

		private var acRslt:ArrayCollection = new ArrayCollection();
		private var acExcel:ArrayCollection = new ArrayCollection();
		
		private var pvo:PhoneVO;
		
		private var refUploadFile:FileReference = new FileReference();
		private var uploadFiles:Array = new Array();
		
		
		public function Excel()	{
			super();
			
			setStyle("skinClass", ExcelSkin);
			
			addEventListener(Event.REMOVED_FROM_STAGE, destroy, false, 0, true);
		}
		
		public function get currStat():String { return _currStat; }
		public function set currStat(value:String):void { _currStat = value; }

		override protected function getCurrentSkinState():String {
				
			return currStat;
		} 
		
		override protected function partAdded(partName:String, instance:Object) : void {
			super.partAdded(partName, instance);
			
			if (instance == openBtn) openBtn.addEventListener(MouseEvent.CLICK, openBtn_clickHandler );
			else if (instance == helpText) helpText.text = "엑셀열기 를 클릭하세요.";
			else if (instance == phoneCombo) {
				setComboBoxData(phoneCombo, "전화번호열");
				phoneCombo.addEventListener(IndexChangeEvent.CHANGE, phoneCombo_changeHandler);
			}
			else if (instance == nameCombo) {
				setComboBoxData(nameCombo, "이름열");
				nameCombo.addEventListener(IndexChangeEvent.CHANGE, nameCombo_changeHandler);
			}
			else if (instance == sendBtn) sendBtn.addEventListener(MouseEvent.CLICK, sendBtn_clickHandler);
			else if (instance == resultList) {
				resultList.dataProvider = acRslt;
				resultList.labelFunction = resultListLabelFunc;
			}
			/*else if (instance == excelView) excelView.dataProvider = acExcel;*/
			
			
			
			//else if (instance == message) message.addEventListener(KeyboardEvent.KEY_UP, message_keyUpHandlerAutoMode);
		}
		
		override protected function partRemoved(partName:String, instance:Object) : void {
			super.partRemoved(partName, instance);
			
			if (instance == openBtn) openBtn.removeEventListener(MouseEvent.CLICK, openBtn_clickHandler );
			else if (instance == phoneCombo) phoneCombo.removeEventListener(IndexChangeEvent.CHANGE, phoneCombo_changeHandler);
			else if (instance == nameCombo)	nameCombo.removeEventListener(IndexChangeEvent.CHANGE, nameCombo_changeHandler);
			else if (instance == sendBtn) sendBtn.removeEventListener(MouseEvent.CLICK, sendBtn_clickHandler);
		}
		
		
		private function resultListLabelFunc(item:Object):String {
			return item.pNo + " " + item.pName; 
		}
		
		private function sendBtn_clickHandler(event:MouseEvent):void {
			
			if (acRslt != null && acRslt.length > 0)
				dispatchEvent(new CustomEvent("send", resultList.dataProvider ) );
			else
				SLibrary.alert("전송할 전화번호가 없습니다.");
		}
		private function phoneCombo_changeHandler(event:IndexChangeEvent):void {
			
			if ( phoneCombo.selectedIndex >= 0 ) {
				
				convertPhoneAcFromExcel();
				setStep(SELPHONE);
				
			} else {
				setStep(UPLOADED);
			}
		}
		
		private function nameCombo_changeHandler(event:IndexChangeEvent):void {
			
			if ( nameCombo.selectedIndex >= 0 ) {
				
				convertPhoneAcFromExcel();
			} 
		}
		
		private function convertPhoneAcFromExcel():void {
			
			if (acExcel != null) {
				var cnt:int = acExcel.length;
				var phone:String = "";
				var name:String = "";
				var bName:Boolean = nameCombo.selectedIndex >= 0 ? true : false;
				var chkInvaildChar:RegExp = /[^0-9]/g;	
				
				acRslt.removeAll();
				
				for (var i:int = 0; i < cnt; i++) {
					
					phone = acExcel[i][phoneCombo.dataProvider.getItemAt(phoneCombo.selectedIndex).label] as String;
					
					if (phone != null)
						phone = phone.replace(chkInvaildChar,"");
					if (bName)
						name = acExcel[i][nameCombo.dataProvider.getItemAt(nameCombo.selectedIndex).label] as String;
					
					// 0 이 빠진경우
					if (phone != null && int(phone) != 0 && phone.length > 6 && phone.substr(0,1) != "0")
						phone = "0"+phone;
					
					if (SLibrary.bKoreaPhoneCheck(phone)) {
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
		
		
		private function excelUpload_RESULTHandler(e:ResultEvent):void {
			
			var data:ExcelLoaderResultVO = e.result as ExcelLoaderResultVO;
			
			if (data.bResult) {
				acExcel.removeAll();
				acExcel = data.list;
				excelView.dataProvider = acExcel;
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
					helpText.text = "엑셀열기 를 클릭하세요.";
					currStat = "normal";
					break;
				case UPLOADED:
					helpText.text = "전화번호 열을 선택 하세요.";
					currStat = "upload";
					break;
				case SELPHONE:
					helpText.text = "주소록 저장 또는 전송을 크릭하세요.";
					currStat = "action";
					break;
			}
			invalidateSkinState();
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
				
			if (resultList != null) {
				resultList.labelFunction = null;
				resultList.itemRenderer = null;
				if (resultList.dataProvider) Object(resultList.dataProvider).removeAll();
				resultList = null;
			}
			
			if (acExcel != null) {
				acExcel.removeAll();
				acExcel = null;
			}
			if (acRslt != null) {
				acRslt.removeAll();
				acRslt = null;
			}
			
			pvo = null;
			
			helpText = null;
			openBtn = null;
			addressBtn = null;
			sendBtn = null;
			_currStat = null;
			refUploadFile = null;

			
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy, false);
			
			
		}
		
	}
}