package lib
{
	import mx.rpc.AsyncToken;
	import mx.rpc.CallResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import services.Smt;

	/**
	 * useage :RemoteManager.getInstance.result = bAdminSessionResult_resultHandler;
			   RemoteManager.getInstance.callresponderToken = RemoteManager.getInstance.service.bAdminSession();
	 * */
	public class RemoteManager
	{
		private static var _instance:RemoteManager = new RemoteManager();
		
		private var _callResponder:CallResponder = new CallResponder();
		private var _smt:Smt = new Smt();
		private var rsltFunction:Function = null;
		
		public function RemoteManager(){
			
			if (_instance)
				throw new Error("no create");

			service.addEventListener(FaultEvent.FAULT, 
				function(event:FaultEvent):void { 
					SLibrary.alert(event.fault.faultString + '\n' + event.fault.faultDetail);
				} );

		}
		public static function get getInstance():RemoteManager {
			return _instance; 
		}
		
		
		
		public function get service():Smt { return _smt; }
		public function get callresponder():CallResponder {	return _callResponder; }
		public function set callresponderToken(t:AsyncToken):void { _callResponder.token = t; }
		
		public function set result( rsltListener:Function ):void {
			
			if (rsltFunction != null) 
				this.callresponder.removeEventListener(ResultEvent.RESULT, rsltFunction);
			
			this.callresponder.addEventListener(ResultEvent.RESULT, rsltListener);
			rsltFunction = rsltListener;
		}

		
		
		
	}
}