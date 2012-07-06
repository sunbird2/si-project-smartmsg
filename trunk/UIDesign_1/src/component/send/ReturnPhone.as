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
	
	import valueObjects.BooleanAndDescriptionVO;

	public class ReturnPhone
	{
		private var _alReturnPhone:ArrayCollection = new ArrayCollection;
		private var _callback:ComboBox;
		
		public function ReturnPhone(){}
		

		public function get callback():ComboBox { return _callback; }
		public function set callback(value:ComboBox):void { _callback = value; }

		public function get alReturnPhone():ArrayCollection { return _alReturnPhone; }
		public function set alReturnPhone(value:ArrayCollection):void { _alReturnPhone = value; }
		
		// 선택 또는 입력된 회신번호 가져오기
		public function get returnPhone():String {
			
			if (callback.selectedIndex < 0) return callback.selectedItem as String;
			else return callback.selectedItem.phone as String;
		}

		public function clean():void {
			
		}
		
		public function getReturnPhone():void {
			
			if (Gv.bLogin) {
				RemoteSingleManager.getInstance.addEventListener("getReturnPhone", getReturnPhone_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.getReturnPhone();
			}
		}
		private function getReturnPhone_resultHandler(event:CustomEvent):void {
			
			alReturnPhone.removeAll();
			var data:ArrayCollection = event.result as ArrayCollection;
			if (data)
				alReturnPhone.addAll(data);
 
			
		}
		
		public function setData():void {
			
			if (callback != null && alReturnPhone != null && alReturnPhone.length > 0) {
				callback.dataProvider = alReturnPhone;
				callback.selectedIndex = 0;
			}
		}
		
		public function callbackSave_clickHandler(event:MouseEvent):void {
			if (Gv.bLogin) {
				RemoteSingleManager.getInstance.addEventListener("setReturnPhone", callbackSave_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.setReturnPhone(callback.selectedItem as String);
			} else {
				SLibrary.alert("로그인 후 이용가능 합니다.");
			}
		}
		public function callbackSave_resultHandler(event:CustomEvent):void {
			var bvo:BooleanAndDescriptionVO = event.result as BooleanAndDescriptionVO;
			if (bvo.bResult) {
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
			var bvo:BooleanAndDescriptionVO = event.result as BooleanAndDescriptionVO;
			if (bvo.bResult) {
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
			var bvo:BooleanAndDescriptionVO = event.result as BooleanAndDescriptionVO;
			if (bvo.bResult) {
				SLibrary.alert("삭제되었습니다.");
				getReturnPhone();
			}else {
				SLibrary.alert("실패");
			}
		}
		
	}
}