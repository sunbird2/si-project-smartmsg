package component.excel
{
	
	import component.util.ButtonSpinner;
	
	import flash.events.Event;
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
	
	import skin.excel.ExcelName_GridItemRenderer;
	import skin.excel.ExcelPhone_GridItemRenderer;
	import skin.excel.ExcelSkin;
	
	import spark.components.Button;
	import spark.components.ComboBox;
	import spark.components.DataGrid;
	import spark.components.Image;
	import spark.components.List;
	import spark.components.RichText;
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
		[SkinPart(required="false")]public var addressCombo:ComboBox;
		[SkinPart(required="false")]public var addressBtn:ButtonSpinner;
		[SkinPart(required="false")]public var sendBtn:Button;
		[SkinPart(required="false")]public var excelView:DataGrid;
		//[SkinPart(required="false")]public var resultList:List;
		[SkinPart(required="false")]public var close:Image;
		
		
		
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
		
		
		public function Excel()	{
			super();
			
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
			else if (instance == helpText) helpText.text = "엑셀열기 를 클릭하세요.";
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
			else if (instance == sendBtn) sendBtn.addEventListener(MouseEvent.CLICK, sendBtn_clickHandler);
			/*else if (instance == resultList) {
				resultList.dataProvider = acRslt;
				resultList.labelFunction = resultListLabelFunc;
			}*/
			else if (instance == excelView) excelView.dataProvider = acExcel;
			else if (instance == addressCombo){
				addressCombo.dataProvider = Gv.addressGroupList;
				if (Gv.addressGroupList.length > 0) {
					addressCombo.selectedIndex = 0;
				}
			}
			else if (instance == addressBtn) addressBtn.addEventListener(MouseEvent.CLICK, addressBtn_clickHandler);
			else if (instance == close) {
				if (bFromAddress) {
					close.visible = true;
					close.addEventListener(MouseEvent.CLICK, close_clickHandler);
				}
				else close.visible = false;
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
		
		private function convertPhoneAcFromExcel():void {
			
			if (acExcel != null) {
				var cnt:int = acExcel.length;
				var phone:String = "";
				var name:String = "";
				var memo:String = "";
				var bName:Boolean = nameCombo.selectedIndex > 0 ? true : false;
				var bMemo:Boolean = memoCombo.selectedIndex > 0 ? true : false;
				var chkInvaildChar:RegExp = /[^0-9]/g;	
				
				acRslt.removeAll();
				
				
				for (var i:int = 0; i < cnt; i++) {
					
					phone = acExcel[i][phoneCombo.dataProvider.getItemAt(phoneCombo.selectedIndex).label] as String;
					
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
					helpText.text = "엑셀열기 를 클릭하세요.";
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
			
			addressBtn.bLoading = true;
			RemoteSingleManager.getInstance.addEventListener("modifyManyAddr", addressBtn_resultHandler, false, 0, true);
			RemoteSingleManager.getInstance.callresponderToken 
				= RemoteSingleManager.getInstance.service.modifyManyAddr(31, acRslt, addressCombo.selectedItem as String);
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