package lib
{
	import flash.events.EventDispatcher;
	
	import mx.messaging.messages.RemotingMessage;
	import mx.rpc.AsyncToken;
	import mx.rpc.CallResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import services.Smt;

	/**
	 * useage :RemoteManager.getInstance.result = bAdminSessionResult_resultHandler;
			   RemoteManager.getInstance.callresponderToken = RemoteManager.getInstance.service.bAdminSession();
	 * */
	public class RemoteSingleManager extends EventDispatcher
	{
		private static var _instance:RemoteSingleManager = new RemoteSingleManager();
		
		private var _callResponder:CallResponder = new CallResponder();
		private var _smt:Smt = new Smt();
		
		public function RemoteSingleManager(){
			
			if (_instance)
				throw new Error("no create");

			service.addEventListener(FaultEvent.FAULT, failResult);
			_callResponder.addEventListener(ResultEvent.RESULT, callResponder_ResultHandler);
		}
		
		
		public static function get getInstance():RemoteSingleManager {
			return _instance; 
		}
		public function get service():Smt { 
			return _smt;
		}
		public function set callresponderToken(t:AsyncToken):void { 
			_callResponder.token = t; 
		}
		
		private function callResponder_ResultHandler(event:ResultEvent):void {
			
			var s:String = RemotingMessage(event.token.message).operation;
			trace("########"+s);
			this.dispatchEvent(new CustomEvent(s, event.result));
		}
		
		
		private function failResult(event:FaultEvent):void {
			SLibrary.alert(event.fault.faultString + '\n' + event.fault.faultDetail);
		}
		
		
		
	}
}