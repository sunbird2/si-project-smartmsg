package component.send
{
	import flash.events.MouseEvent;
	
	import lib.CustomEvent;
	import lib.Gv;
	import lib.Paging;
	import lib.RemoteManager;
	import lib.SLibrary;
	
	import mx.collections.ArrayCollection;
	import mx.core.ClassFactory;
	import mx.core.IFactory;
	import mx.rpc.events.ResultEvent;
	
	import skin.emoticon.CategoryRenderer;
	import skin.emoticon.MyRenderer;
	
	import spark.components.ComboBox;
	import spark.components.List;
	import spark.events.IndexChangeEvent;
	
	import valueObjects.BooleanAndDescriptionVO;

	public class ReturnPhone
	{
		private var _alReturnPhone:ArrayCollection;
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
				RemoteManager.getInstance.result = getReturnPhone_resultHandler;
				RemoteManager.getInstance.callresponderToken 
					= RemoteManager.getInstance.service.getReturnPhone();
			}
		}
		public function getReturnPhone_resultHandler(event:ResultEvent):void {
			
			alReturnPhone = event.result as ArrayCollection; 
			if (alReturnPhone != null && alReturnPhone.length > 0) {
				callback.dataProvider = alReturnPhone;
				callback.selectedIndex = 0;
			}
		}
		public function callbackSave_clickHandler(event:MouseEvent):void {
			if (Gv.bLogin) {
				RemoteManager.getInstance.result = callbackSave_resultHandler;
				RemoteManager.getInstance.callresponderToken 
					= RemoteManager.getInstance.service.setReturnPhone(callback.selectedItem as String);
			} else {
				SLibrary.alert("로그인 후 이용가능 합니다.");
			}
		}
		public function callbackSave_resultHandler(event:ResultEvent):void {
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
				RemoteManager.getInstance.result = callbackUp_resultHandler;
				RemoteManager.getInstance.callresponderToken 
					= RemoteManager.getInstance.service.setReturnPhoneTimeWrite(idx);
			} else {
				SLibrary.alert("로그인 후 이용가능 합니다.");
			}
		}
		public function callbackUp_resultHandler(event:ResultEvent):void {
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
				RemoteManager.getInstance.result = callbackDelete_resultHandler;
				RemoteManager.getInstance.callresponderToken 
					= RemoteManager.getInstance.service.deleteReturnPhone(idx);
			} else {
				SLibrary.alert("로그인 후 이용가능 합니다.");
			}
		}
		public function callbackDelete_resultHandler(event:ResultEvent):void {
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