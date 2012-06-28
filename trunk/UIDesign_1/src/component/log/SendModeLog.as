package component.log
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import lib.CustomEvent;
	import lib.Gv;
	import lib.RemoteSingleManager;
	import lib.SLibrary;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	import mx.formatters.DateFormatter;
	
	import skin.log.SendModeLogSkin;
	
	import spark.components.HSlider;
	import spark.components.Label;
	import spark.components.List;
	import spark.components.RichText;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.IndexChangeEvent;
	
	import valueObjects.LogVO;
	import valueObjects.MessageVO;
	import valueObjects.PhoneVO;
	
	
	[Event(name="getPhone", type="lib.CustomEvent")]
	[Event(name="close", type="flash.events.Event")]
	/* A component must identify the view states that its skin supports. 
	Use the [SkinState] metadata tag to define the view states in the component class. 
	[SkinState("normal")] */
	
	public class SendModeLog extends SkinnableComponent
	{
		/* To declare a skin part on a component, you use the [SkinPart] metadata. 
		[SkinPart(required="true")] */
		[SkinPart(required="false")]public var preMonth:Label;
		[SkinPart(required="false")]public var month:Label;
		[SkinPart(required="false")]public var nextMonth:Label;
		[SkinPart(required="false")]public var monthSlider:HSlider;
		
		[SkinPart(required="false")]public var groupList:List;
		[SkinPart(required="true")] public var close:RichText;
		
		private var _yyyymm:String;
		private var acGroup:ArrayCollection = new ArrayCollection();
		
		
		public function SendModeLog()
		{
			//TODO: implement function
			super();
			setStyle("skinClass", SendModeLogSkin);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy, false, 0, true);
			monthSlider_valueCommitHandler();
		}
		
		public function get yyyymm():String	{ return _yyyymm; }
		public function set yyyymm(value:String):void {
			_yyyymm = value;
			if (month != null && _yyyymm.length >= 6)
				month.text = _yyyymm.substring(0,4)+"년 "+_yyyymm.substring(4,6)+"월";
		}
		
		/* Implement the getCurrentSkinState() method to set the view state of the skin class. */
		override protected function getCurrentSkinState():String
		{
			return super.getCurrentSkinState();
		} 
		
		/* Implement the partAdded() method to attach event handlers to a skin part, 
		configure a skin part, or perform other actions when a skin part is added. */	
		override protected function partAdded(partName:String, instance:Object) : void
		{
			super.partAdded(partName, instance);
			if (instance == preMonth) preMonth.addEventListener(MouseEvent.CLICK, preMonth_clickHandler);
			else if (instance == month) yyyymm = yyyymm;
			else if (instance == nextMonth) nextMonth.addEventListener(MouseEvent.CLICK, nextMonth_clickHandler);
			else if (instance == monthSlider) {
				monthSlider.minimum = -6;
				monthSlider.maximum = 6;
				monthSlider.value = 0;
				monthSlider.snapInterval = 1;
				monthSlider.dataTipFormatFunction = monthSliderTip;
				monthSlider.addEventListener(FlexEvent.VALUE_COMMIT, monthSlider_valueCommitHandler);
			}
			else if (instance == groupList) {
				groupList.dataProvider = acGroup;
				groupList.addEventListener(IndexChangeEvent.CHANGE, groupList_changeHandler);
			}
			else if (instance == close)	close.addEventListener(MouseEvent.CLICK, close_clickHandler);
		}
		
		/* Implement the partRemoved() method to remove the even handlers added in partAdded() */
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
			
			if (instance == preMonth) preMonth.removeEventListener(MouseEvent.CLICK, preMonth_clickHandler);
			else if (instance == month) yyyymm = yyyymm;
			else if (instance == nextMonth) nextMonth.removeEventListener(MouseEvent.CLICK, nextMonth_clickHandler);
			else if (instance == monthSlider) {
				monthSlider.dataTipFormatFunction = null;
				monthSlider.removeEventListener(FlexEvent.VALUE_COMMIT, monthSlider_valueCommitHandler);
			}
			else if (instance == groupList) {
				ArrayCollection(groupList.dataProvider).removeAll();
				groupList.removeEventListener(IndexChangeEvent.CHANGE, groupList_changeHandler);
			}
			else if (instance == close)	close.removeEventListener(MouseEvent.CLICK, close_clickHandler);
		}
		
		private function preMonth_clickHandler(event:MouseEvent):void { --monthSlider.value; }
		private function nextMonth_clickHandler(event:MouseEvent):void { ++monthSlider.value; }
		
		
		private function monthSliderTip(value:Number):String
		{
			var date:Date = new Date();
			var df:DateFormatter = new DateFormatter();
			df.formatString = "YYYY년 MM월";
			date.setMonth(date.month+1 + value);
			
			return df.format(date);
		}
		private function monthSlider_valueCommitHandler(event:FlexEvent = null):void {
			
			var date:Date = new Date();
			
			if(event != null)
				date.setMonth(date.month + event.currentTarget.value,1);
			
			yyyymm = String(date.fullYear)+String( SLibrary.addTwoSizeNumer(date.month+1) );
			
			getSentList();
			
		}
		private function getSentList():void {
			
			if (Gv.bLogin) {
				RemoteSingleManager.getInstance.addEventListener("getSentList", getSentList_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.getSentList(yyyymm);
			}
		}
		private function getSentList_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("getSentList", getSentList_resultHandler);
			var data:ArrayCollection = event.result as ArrayCollection;
			acGroup.removeAll();
			acGroup.addAll(data);
		}
		
		private function groupList_changeHandler(event:IndexChangeEvent):void {
			
			var vo:LogVO = acGroup.getItemAt(event.newIndex) as LogVO;
			if (vo != null) {
				RemoteSingleManager.getInstance.addEventListener("getSentListDetail", groupList_changeResultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.getSentListDetail(vo);
			}
		}
		private function groupList_changeResultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("getSentListDetail", groupList_changeResultHandler);
			var data:ArrayCollection = event.result as ArrayCollection;
			
			dispatchEvent(new CustomEvent("getPhone", parsePhoneVO(data) ) );
			
		}
		private function parsePhoneVO(ac:ArrayCollection):ArrayCollection {
			
			var acVO:ArrayCollection = new ArrayCollection();
			if (ac != null && ac.length > 0) {
				var cnt:int = ac.length;
				var pvo:PhoneVO = null;
				var vo:MessageVO = null;
				for(var i:int = 0; i < cnt; i++) {
					
					vo = ac.getItemAt(i) as MessageVO;
					pvo = new PhoneVO();
					pvo.pName = vo.name;
					pvo.pNo = vo.phone;
					
					acVO.addItem(pvo);
				}
			}
			
			return acVO;
		}
		
		private function close_clickHandler(event:MouseEvent):void {
			this.dispatchEvent(new Event("close"));
		}
		
		
		public function destroy(e:Event):void {
			
			preMonth = null;
			month = null;
			nextMonth = null;
			monthSlider = null;
			
			groupList = null;
			
			_yyyymm = null;
			acGroup.removeAll();
			acGroup = null;
		}
	}
}