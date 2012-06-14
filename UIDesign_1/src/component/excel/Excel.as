package component.excel
{
	
	import flash.events.MouseEvent;
	
	import lib.FileUploadByRemoteObject;
	import lib.FileUploadByRemoteObjectEvent;
	import lib.SLibrary;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.rpc.events.ResultEvent;
	
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
		
		
		public static const NONE:int = 0;
		public static const UPLOADED:int = 1;
		public static const SELPHONE:int = 2;
		
		private var _currStat:String = "normal";
		
		private var fur:FileUploadByRemoteObject;
		private var acRslt:ArrayCollection ;
		
		
		public function Excel()	{
			super();
			fur = new FileUploadByRemoteObject("smt");
			
			fur.addEventListener(FileUploadByRemoteObjectEvent.COMPLETE, FileUploadByRemoteObjectCOMPLETEHandler);
			fur.addEventListener(FileUploadByRemoteObjectEvent.RESULT, FileUploadByRemoteObjectRESULTHandler);
			fur.addEventListener(FileUploadByRemoteObjectEvent.FAULT, FileUploadByRemoteObjectFAULTHandler);
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
				//nameCombo.addEventListener(IndexChangeEvent.CHANGE, phoneCombo_changeHandler);
			}
			
			
			//else if (instance == message) message.addEventListener(KeyboardEvent.KEY_UP, message_keyUpHandlerAutoMode);
		}
		
		override protected function partRemoved(partName:String, instance:Object) : void {
			super.partRemoved(partName, instance);
		}
		
		
		private function phoneCombo_changeHandler(event:IndexChangeEvent):void {
			
			if ( phoneCombo.selectedIndex >= 0 ) {
				
				var acRslt:ArrayCollection = convertPhoneAcFromExcel();
				if (acRslt != null) {
					resultList.dataProvider = acRslt;
				}
				setStep(SELPHONE);
				
			} else {
				setStep(UPLOADED);
			}
		}
		
		private function nameCombo_changeHandler(event:IndexChangeEvent):void {
			
			if ( nameCombo.selectedIndex >= 0 ) {
				
				var acRslt:ArrayCollection = convertPhoneAcFromExcel();
				if (acRslt != null) {
					resultList.dataProvider = acRslt;
				}
				
			} 
		}
		
		private function convertPhoneAcFromExcel():ArrayCollection {
			var ac:ArrayCollection = excelView.dataProvider as ArrayCollection;
			var acRslt:ArrayCollection = new ArrayCollection();
			
			if (ac != null) {
				var cnt:int = ac.length;
				var phone:String = "";
				var name:String = "";
				var bName:Boolean = nameCombo.selectedIndex >= 0 ? true : false;
				var chkInvaildChar:RegExp = /[^0-9]/g;	
				
				for (var i:int = 0; i < cnt; i++) {
					
					phone = ac[i][phoneCombo.dataProvider.getItemAt(phoneCombo.selectedIndex).label] as String;
					
					if (phone != null)
						phone = phone.replace(chkInvaildChar,"");
					if (bName)
						name = ac[i][nameCombo.dataProvider.getItemAt(nameCombo.selectedIndex).label] as String;
					
					// 0 이 빠진경우
					if (phone != null && int(phone) != 0 && phone.length > 6 && phone.substr(0,1) != "0")
						phone = "0"+phone;
					
					if (SLibrary.bKoreaPhoneCheck(phone)) {
						acRslt.addItem( getPhoneVO( phone, name ) );
					}
				}
			}
			
			return acRslt;
		}
		private function getPhoneVO(pno:String, pname:String):PhoneVO {
			var pvo:PhoneVO = new PhoneVO();
			pvo.pNo = pno;
			pvo.pName = pname;
			return pvo;
		}
		
		private function FileUploadByRemoteObjectCOMPLETEHandler(e:FileUploadByRemoteObjectEvent):void {
			
			SLibrary.bTrace("FileUploadByRemoteObjectCOMPLETEHandler");
			
			if ( Number(this.fur.UploadFiles[0].realsize) > Number(1024*1024*10) ) {
				this.fur.UploadFiles.pop();
				SLibrary.alert("10MB 이상의 파일은 사용 하실 수 없습니다.");
			}else {
				this.fur.remoteObject.getExcelLoaderData( e.data, e.fileName );
			}
		}
		
		private function FileUploadByRemoteObjectRESULTHandler(e:FileUploadByRemoteObjectEvent):void {
			
			SLibrary.bTrace("FileUploadByRemoteObjectRESULTHandler");
			var data:ExcelLoaderResultVO = e.result as ExcelLoaderResultVO;
			
			if (data.bResult) {
				excelView.dataProvider = data.list;
				callLater(setStep, [UPLOADED]);
				
			}else {
				SLibrary.alert(data.strDescription);
			}
			
		}
	
		private function FileUploadByRemoteObjectFAULTHandler(e:FileUploadByRemoteObjectEvent):void {
			
			SLibrary.bTrace("FileUploadByRemoteObjectFAULTHandler");
			trace( e.fault );
		}
		
		private function openBtn_clickHandler(event:MouseEvent):void {
			
			this.fur.addFiles();
		}
		private function setComboBoxData(combo:ComboBox, label:String):void {
			
			var array:ArrayList = this.excelView.columns as ArrayList;
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
		
		
		
	}
}