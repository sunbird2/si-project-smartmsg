package component.send
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import lib.Gv;
	import lib.RemoteSingleManager;
	
	import mx.rpc.events.ResultEvent;
	
	import spark.components.Label;
	import spark.components.List;
	import spark.components.supportClasses.SkinnableComponent;
	
	
	/* A component must identify the view states that its skin supports. 
	Use the [SkinState] metadata tag to define the view states in the component class. 
	[SkinState("normal")] */
	[SkinState("sending")]
	[SkinState("result")]
	[SkinState("result_mini")]
	
	public class Sending extends SkinnableComponent
	{
		/* To declare a skin part on a component, you use the [SkinPart] metadata. 
		[SkinPart(required="true")] */
		[SkinPart(required="true")]public var sendingCnt:Label;
		[SkinPart(required="true")]public var resultLabel:Label;
		[SkinPart(required="true")]public var resultLocalCnt:Label;
		[SkinPart(required="true")]public var resultTelecomCnt:Label;
		[SkinPart(required="true")]public var resultPhoneCnt:Label;
		[SkinPart(required="true")]public var resultPhoneCntStatus:Label;
		[SkinPart(required="true")]public var resultList:List;
		
		private var _cstat:String = "sending";
		public function get cstat():String { return _cstat; }
		public function set cstat(value:String):void { _cstat = value; }
		
		private var rsm:RemoteSingleManager;
		private var interval:uint;
		private var duration:Number = 500;
		
		public function Sending()
		{
			//TODO: implement function
			super();
		}
		
		/* Implement the getCurrentSkinState() method to set the view state of the skin class. */
		override protected function getCurrentSkinState():String
		{
			return cstat;
		} 
		
		/* Implement the partAdded() method to attach event handlers to a skin part, 
		configure a skin part, or perform other actions when a skin part is added. */	
		override protected function partAdded(partName:String, instance:Object) : void
		{
			super.partAdded(partName, instance);
		}
		
		/* Implement the partRemoved() method to remove the even handlers added in partAdded() */
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
		}
		
		private function sendingCntRun():void {
			
			//sending count
			if (interval)
				clearInterval(interval);
			
			if (rsm == null) rsm = new RemoteSingleManager();
				
			rsm.addEventListener("getState", sendingCnt_resultHandler, false, 0, true);
			interval = setInterval(getSendingCnt,duration);
		}
		private function getSendingCnt():void {
			
			rsm.callresponderToken = rsm.service.getState( Gv.user_id );
		}
		private function sendingCnt_resultHandler(event:ResultEvent):void {
			
		}
		
	}
}