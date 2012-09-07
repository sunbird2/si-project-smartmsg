package component.send
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import flashx.textLayout.elements.SpanElement;
	
	import lib.CustomEvent;
	import lib.Gv;
	import lib.RemoteSingleManager;
	import lib.SLibrary;
	
	import mx.collections.AsyncListView;
	import mx.rpc.CallResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import services.Smt;
	
	import skin.send.SendingSkin;
	
	import spark.components.Button;
	import spark.components.Image;
	import spark.components.Label;
	import spark.components.List;
	import spark.components.supportClasses.SkinnableComponent;
	
	import valueObjects.LogVO;
	import valueObjects.SentStatusVO;
	
	
	/* A component must identify the view states that its skin supports. 
	Use the [SkinState] metadata tag to define the view states in the component class. 
	[SkinState("normal")] */
	[SkinState("sending")]
	[SkinState("result")]
	[SkinState("result_list")]
	[SkinState("result_mini")]
	
	public class Sending extends SkinnableComponent
	{
		/* To declare a skin part on a component, you use the [SkinPart] metadata. 
		[SkinPart(required="true")] */
		[SkinPart(required="true")]public var sendingCnt:Label;
		[SkinPart(required="true")]public var title:Label;
		[SkinPart(required="true")]public var resultLocalCnt:Label;
		[SkinPart(required="true")]public var resultTelecomCnt:Label;
		[SkinPart(required="true")]public var resultPhoneCnt:Label;
		[SkinPart(required="true")]public var succ:SpanElement;
		[SkinPart(required="true")]public var fail:SpanElement;
		
		[SkinPart(required="true")]public var resultViewBtn:Image;
		[SkinPart(required="true")]public var resultList:List;
		
		
		[SkinPart(required="false")]public var testBtn:Button;
		
		/**
		 * state
		 * */
		private var _cstat:String = "sending";
		public function get cstat():String { return _cstat; }
		public function set cstat(value:String):void {
			
			if (cstat != value) {
				_cstat = value;
				invalidateSkinState();
			}
			
		}
		
		/**
		 * sending
		 * */
		private var rsm:RemoteSingleManager;
		private var interval:uint;
		private var duration:Number = 500;
		private var bSending:Boolean = false;
		
		
		/**
		 * result
		 * */
		private var lvo:LogVO = null;
		private var durationRslt:Number = 2000;
		private var bResult:Boolean = false;
		
		// paging
		[Bindable] public var asyncListView:AsyncListView = new AsyncListView();
		[Bindable] public var callResponder:CallResponder =  new CallResponder();
		public var smt:Smt;
		
		public function Sending()
		{
			//TODO: implement function
			super();
			setStyle("skinClass", SendingSkin);
			addEventListener(Event.REMOVED_FROM_STAGE, removedfromstage_handler, false, 0, true);
		}
		public function removedfromstage_handler(event:Event):void {
			
			
			if (rsm != null) {
				rsm.removeEventListener("getState", sendingCnt_resultHandler);
				rsm.removeEventListener("getSentResultStatus", resultCnt_resultHandler);
				rsm.destroy();
				rsm = null;
			}
			
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
			if (instance == sendingCnt)	sendingCntRun();
			else if (instance == resultLocalCnt) resultRun();
			else if (instance == resultViewBtn) resultViewBtn.addEventListener(MouseEvent.CLICK, resultViewBtn_clickHandler);
			else if (instance == resultList) {
				resultList.dataProvider = asyncListView;
				getResultList();
			}
			
			else if (instance == testBtn) testBtn.addEventListener(MouseEvent.CLICK, testBtn_clickHandler);
		}
		
		/* Implement the partRemoved() method to remove the even handlers added in partAdded() */
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			if (instance == sendingCnt)	{
				if (interval) clearInterval(interval);
				
			}
			else if (instance == resultLocalCnt) {
				if (interval) clearInterval(interval);
			}
			else if (instance == resultViewBtn) resultViewBtn.removeEventListener(MouseEvent.CLICK, resultViewBtn_clickHandler);
			else if (instance == resultList) {
				asyncListView.removeAll();
				resultListDestroy();
			}
				
			else if (instance == testBtn) testBtn.removeEventListener(MouseEvent.CLICK, testBtn_clickHandler);
			super.partRemoved(partName, instance);
		}
		
		/**
		 * sending run
		 * */
		private function sendingCntRun():void {
			
			trace("run!! : sendingCntRun");
			//sending count
			if (interval)
				clearInterval(interval);
			
			if (rsm == null) rsm = new RemoteSingleManager();
			
			title.text = "처리중..";
			bSending = true;
			rsm.addEventListener("getState", sendingCnt_resultHandler, false, 0, true);
			interval = setInterval(getSendingCnt,duration);
		}
		private function getSendingCnt():void {
			if (rsm)
				rsm.callresponderToken = rsm.service.getState();
		}
		private function sendingCnt_resultHandler(event:CustomEvent):void {
			sendingCnt.text = String(event.result);
		}
		
		
		/**
		 * result run
		 * */
		private function resultRun():void {
			
			trace("run!! : resultRun");
			//sending count
			if (interval)
				clearInterval(interval);
			
			if (rsm == null) rsm = new RemoteSingleManager();
			
			title.text = "메시지 현재 위치별 건수";
			bResult = true;
			rsm.addEventListener("getSentResultStatus", resultCnt_resultHandler, false, 0, true);
			
			if (lvo.idx != 0) {
				getResult();
				interval = setInterval(getResult, durationRslt);
			}
				
		}
		private function getResult():void {
			rsm.callresponderToken = rsm.service.getSentResultStatus( lvo );
		}
		private function resultCnt_resultHandler(event:CustomEvent):void {
			
			var ssvo:SentStatusVO = event.result as SentStatusVO;
			if (ssvo) {
				resultLocalCnt.text = String(ssvo.local);
				resultTelecomCnt.text = String(ssvo.telecom);
				resultPhoneCnt.text = String(ssvo.success + ssvo.fail);
				succ.text = String(ssvo.success);
				fail.text = String(ssvo.fail);
				
				if (ssvo.local == 0 && ssvo.telecom == 0) {
					resultCompleted();
				}
				resultCompleted();
			}
			
		}
		
		
		/**
		 * sending completed
		 * */
		public function sendingCompleted(lvo:LogVO):void {
			
			title.text = "처리 완료!!";
			if (interval) clearInterval(interval);
			rsm.removeEventListener("getState", sendingCnt_resultHandler);
			
			bSending = false;
			if (cstat == "sending") {
				this.lvo = lvo;
				cstat = "result";
			}
				
			
			//resultRun();
		}
		
		/**
		 * result completed
		 * */
		public function resultCompleted():void {
			
			if (interval) clearInterval(interval);
			rsm.removeEventListener("getSentResultStatus", sendingCnt_resultHandler);
			
			title.text = "전송완료!";
			//resultRun();
		}
		
		/**
		 * resultView
		 * */
		public function resultViewBtn_clickHandler(event:MouseEvent):void {
			
			if (cstat == "result")
				cstat = "result_list";
			else {
				PagedFilterSmtInit();
			}
		}

		/**
		 * paging
		 * */
		public function getResultList():void {
			
			PagedFilterSmtInit();
			if (lvo != null) {
				
				callResponder.addEventListener(ResultEvent.RESULT, callResponder_resultHandler);
				callResponder.token = smt.getSentListDetail_pagedFiltered(lvo);
			}
		}
		private function callResponder_resultHandler(event:ResultEvent):void {
			
			callResponder.removeEventListener(ResultEvent.RESULT, callResponder_resultHandler);
			asyncListView.list = callResponder.lastResult;
		}
		

		private function PagedFilterSmtInit():void {
			if (smt == null) {
				smt = new services.Smt();
				smt.showBusyCursor = true;
				smt.addEventListener("fault", smt_fault);
				smt.initialized(this, "smt")
			}
			
		}
		public function smt_fault(event:FaultEvent):void { SLibrary.alert(event.fault.faultString + '\n' + event.fault.faultDetail); }
		
		public function resultListDestroy():void {
			
			if (smt != null) smt.removeEventListener("fault", smt_fault);
			if (callResponder != null) callResponder.removeEventListener(ResultEvent.RESULT, callResponder_resultHandler);
		}
		
		
		/**
		 * test
		 * */
		private function testBtn_clickHandler(event:MouseEvent):void {
			
			RemoteSingleManager.getInstance.addEventListener("run", run_resultHandler, false, 0, true);
			RemoteSingleManager.getInstance.callresponderToken 
				= RemoteSingleManager.getInstance.service.run();
		
		}
		private function run_resultHandler(event:CustomEvent):void {
			//sendingCompleted(int(event.result));
			var lvo:LogVO = new LogVO();
			lvo.idx = 15;
			lvo.line = "lg";
			lvo.method = "N";
			lvo.mode = "SMS";
			
			sendingCompleted(lvo);
		}
		
		public function destroy():void {
			
			
			resultList = null;
			
			rsm = null;
			
			// paging
			asyncListView = null;
			callResponder = null;
			smt = null;
			
		}
		
	}
}