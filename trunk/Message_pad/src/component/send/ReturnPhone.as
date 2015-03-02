package component.send
{
	
	import flash.events.MouseEvent;
	
	import lib.CustomEvent;
	import lib.Gv;
	import lib.Paging;
	import lib.RemoteSingleManager;
	import lib.SLibrary;
	
	import mx.collections.ArrayCollection;
	import mx.core.ClassFactory;
	import mx.core.IFactory;
	
	import skin.emoticon.CategoryRenderer;
	import skin.emoticon.MyRenderer;
	
	import spark.components.ComboBox;
	import spark.components.List;
	import spark.events.IndexChangeEvent;
	
	import valueObjects.CommonVO;

	public class ReturnPhone
	{
		private var _alReturnPhone:ArrayCollection = new ArrayCollection;
		private var _callback:ComboBox;
		
		public function ReturnPhone(){}
		

		public function get callback():ComboBox { return _callback; }
		public function set callback(value:ComboBox):void { _callback = value; callback.dataProvider = alReturnPhone;  }

		public function get alReturnPhone():ArrayCollection { return _alReturnPhone; }
		public function set alReturnPhone(value:ArrayCollection):void { _alReturnPhone = value; }
		
		// 선택 또는 입력된 회신번호 가져오기
		public function get returnPhone():String {
			
			if (callback.selectedIndex < 0) return callback.selectedItem as String;
			else return callback.selectedItem.phone as String;
		}

		public function init():void {
			_alReturnPhone = new ArrayCollection;
		}
		
		public function getReturnPhone():void {
			
			if (Gv.bLogin) {
				RemoteSingleManager.getInstance.addEventListener("getReturnPhone", getReturnPhone_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.getReturnPhone();
			}
		}
		private function getReturnPhone_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("getReturnPhone", getReturnPhone_resultHandler);
			
			alReturnPhone.removeAll();
			var data:ArrayCollection = event.result as ArrayCollection;
			if (data) {
				alReturnPhone.addAll(data);
				callback.selectedIndex = 0;
			}
				
 
			
		}
		
		public function setData():void {
			
			if (callback != null && alReturnPhone != null && alReturnPhone.length > 0) {
				callback.selectedIndex = 0;
			}
		}
		
		public function callbackSave_clickHandler(event:MouseEvent):void {
			event.stopImmediatePropagation();
			event.preventDefault();
			if (Gv.bLogin) {

				if (callback.selectedItem && callback.selectedItem as String != null && callback.selectedItem as String != "") {
					
					var s:String = callback.selectedItem as String;
					var chkInvaildChar:RegExp = /[^0-9\-]/g;			
					if (chkInvaildChar.test(s))	SLibrary.alert("숫자만 입력 가능 합니다.");
					else {
						RemoteSingleManager.getInstance.addEventListener("setReturnPhone", callbackSave_resultHandler, false, 0, true);
						RemoteSingleManager.getInstance.callresponderToken 
							= RemoteSingleManager.getInstance.service.setReturnPhone(s);	
					}
					
						
				}else {
					SLibrary.alert("번호를 입력 후 저장하세요.");
				}
				
			} else {
				SLibrary.alert("로그인 후 이용가능 합니다.");
			}
		}
		public function callbackSave_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("setReturnPhone", callbackSave_resultHandler);
			
			var bvo:CommonVO = event.result as CommonVO;
			if (bvo.rslt) {
				SLibrary.alert("저장되었습니다.");
				getReturnPhone();
			}else {
				SLibrary.alert("실패");
			}
		}
		public function callbackUp(idx:int):void {
			if (Gv.bLogin) {
				RemoteSingleManager.getInstance.addEventListener("setReturnPhoneTimeWrite", callbackUp_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.setReturnPhoneTimeWrite(idx);
			} else {
				SLibrary.alert("로그인 후 이용가능 합니다.");
			}
		}
		public function callbackUp_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("setReturnPhoneTimeWrite", callbackUp_resultHandler);
			var bvo:CommonVO = event.result as CommonVO;
			if (bvo.rslt) {
				SLibrary.alert("설정되었습니다.");
				getReturnPhone();
			}else {
				SLibrary.alert("실패");
			}
		}
		public function callbackDelete(idx:int):void {
			if (Gv.bLogin) {
				RemoteSingleManager.getInstance.addEventListener("deleteReturnPhone", callbackDelete_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.deleteReturnPhone(idx);
			} else {
				SLibrary.alert("로그인 후 이용가능 합니다.");
			}
		}
		public function callbackDelete_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("deleteReturnPhone", callbackDelete_resultHandler);
			var bvo:CommonVO = event.result as CommonVO;
			if (bvo.rslt) {
				SLibrary.alert("삭제되었습니다.");
				getReturnPhone();
			}else {
				SLibrary.alert("실패");
			}
		}
		
		public function destory():void {
			
			ArrayCollection(_callback.dataProvider).removeAll();
			_alReturnPhone.removeAll();
			_alReturnPhone = null;
			callback = null
		}
		
	}
}