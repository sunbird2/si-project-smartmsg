package component
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import lib.AlertManager;
	import lib.CustomEvent;
	import lib.Gv;
	import lib.RemoteSingleManager;
	import lib.SLibrary;
	
	import mx.charts.PieChart;
	import mx.charts.chartClasses.Series;
	import mx.charts.series.PieSeries;
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.controls.DateField;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.formatters.DateFormatter;
	import mx.graphics.SolidColor;
	import mx.graphics.SolidColorStroke;
	
	import skin.LogSkin;
	
	import spark.components.Button;
	import spark.components.DataGrid;
	import spark.components.HSlider;
	import spark.components.Label;
	import spark.components.List;
	import spark.components.RichText;
	import spark.components.gridClasses.GridColumn;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.IndexChangeEvent;
	import spark.filters.DropShadowFilter;
	
	import valueObjects.BooleanAndDescriptionVO;
	import valueObjects.LogVO;
	import valueObjects.MessageVO;
	
	
	/* A component must identify the view states that its skin supports. 
	Use the [SkinState] metadata tag to define the view states in the component class. 
	[SkinState("normal")] */
	
	public class Log extends SkinnableComponent
	{
		/* To declare a skin part on a component, you use the [SkinPart] metadata. 
		[SkinPart(required="true")] */
		
		[SkinPart(required="false")]public var preMonth:Label;
		[SkinPart(required="false")]public var month:Label;
		[SkinPart(required="false")]public var nextMonth:Label;
		[SkinPart(required="false")]public var monthSlider:HSlider;
		
		[SkinPart(required="false")]public var message:RichText;
		[SkinPart(required="false")]public var chart:PieChart;
		
		[SkinPart(required="false")]public var groupList:List;
		[SkinPart(required="false")]public var detailList:List;
		
		
		private var _yyyymm:String;
		private var acGroup:ArrayCollection = new ArrayCollection();
		private var acDetail:ArrayCollection = new ArrayCollection();
		private var alDetailColumn:ArrayList = new ArrayList();
		private var acChart:ArrayCollection = new ArrayCollection();
		
		private var confirmAlert:AlertManager;
		
		public function Log()
		{
			//TODO: implement function
			super();
			
			monthSlider_valueCommitHandler();
			//addEventListener(Event.REMOVED_FROM_STAGE, removedfromstage_handler);
		}
		
		/*public function removedfromstage_handler(event:Event):void {
			
			removeEventListener(Event.REMOVED_FROM_STAGE, removedfromstage_handler);
			
			Object(groupList.dataProvider).removeAll();
			acGroup.removeAll();
			
			Object(detailList.dataProvider).removeAll();
			acDetail.removeAll();
			
			Object(chart.dataProvider).removeAll();
			acChart.removeAll();
			//setStyle("skinClass", null);
			//detachSkin();
			//destroy();
		}*/
		
		/* Implement the getCurrentSkinState() method to set the view state of the skin class. */

		public function get yyyymm():String	{ return _yyyymm; }
		public function set yyyymm(value:String):void {
			_yyyymm = value;
			if (month != null && _yyyymm.length >= 6)
				month.text = _yyyymm.substring(0,4)+"년 "+_yyyymm.substring(4,6)+"월";
		}

		override protected function getCurrentSkinState():String
		{
			return super.getCurrentSkinState();
		} 
		
		/* Implement the partAdded() method to attach event handlers to a skin part, 
		configure a skin part, or perform other actions when a skin part is added. */	
		override protected function partAdded(partName:String, instance:Object) : void
		{
			
			super.partAdded(partName, instance);
			
			//trace("partAdded " + partName);
			
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
				groupList.addEventListener(IndexChangeEvent.CHANGE, groupList_changeHandler, false, 0, true);
				groupList.addEventListener(KeyboardEvent.KEY_UP, groupList_keyUpHandler, false, 0, true);
			}
			else if (instance == detailList) {
				detailList.dataProvider = acDetail;
				//setColumn();
				//detailList.columns = alDetailColumn;
				//var gc:GridColumn = ArrayList(detailList.columns).getItemAt(0) as GridColumn;
				//gc.labelFunction = detailListLabelFunction;
			}
			else if (instance == chart) {
				
				chart.series = [getPieSeries()];
				//chart.filters = [ new DropShadowFilter(0,0,0x000000,0.8) ];
				chart.showDataTips = true;
				chart.dataProvider = acChart;
			}
			
		}
		
		private function setColumn():void {
			
			var gc0:GridColumn = new GridColumn();
			gc0.headerText = "번호";
			var gc1:GridColumn = new GridColumn("phone");
			gc0.headerText = "전화번호";
			var gc2:GridColumn = new GridColumn("name");
			gc0.headerText = "이름";
			var gc3:GridColumn = new GridColumn("rslt");
			gc0.headerText = "결과";
			var gc4:GridColumn = new GridColumn("rsltDate");
			gc0.headerText = "결과시간";
			var gc5:GridColumn = new GridColumn("callback");
			gc0.headerText = "회신번호";
			alDetailColumn.addItem(gc0);
			alDetailColumn.addItem(gc1);
			alDetailColumn.addItem(gc2);
			alDetailColumn.addItem(gc3);
			alDetailColumn.addItem(gc4);
			alDetailColumn.addItem(gc5);
		}
		
		/* Implement the partRemoved() method to remove the even handlers added in partAdded() */
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			//trace("partRemoved " + partName);
			
			if (instance == preMonth) preMonth.removeEventListener(MouseEvent.CLICK, preMonth_clickHandler);
			else if (instance == nextMonth) nextMonth.removeEventListener(MouseEvent.CLICK, nextMonth_clickHandler);
			else if (instance == monthSlider) {
				//monthSlider.dataTipFormatFunction = null;
				monthSlider.removeEventListener(FlexEvent.VALUE_COMMIT, monthSlider_valueCommitHandler);
			}
			else if (instance == groupList) {
				
				groupList.removeEventListener(IndexChangeEvent.CHANGE, groupList_changeHandler);
				groupList.removeEventListener(KeyboardEvent.KEY_UP, groupList_keyUpHandler);
				Object(groupList.dataProvider).removeAll();
				acGroup.removeAll();
				acGroup = null;
				//groupList.dataProvider = null;
			}
			else if (instance == detailList) {
				
				Object(detailList.dataProvider).removeAll();
				//detailList.columns = null
				//detailList.columns.removeAll();
				//alDetailColumn.removeAll(); 
				acDetail.removeAll();
				acDetail = null;
			}
			else if (instance == chart) {
				Object(chart.dataProvider).removeAll();
			}
			
			super.partRemoved(partName, instance);
		}
		
		override public function stylesInitialized():void {
			setStyle("skinClass", LogSkin);
		}
		override protected function createChildren():void {
			mx_internal::skinDestructionPolicy = "auto";
			super.createChildren();
		}
		
		private function getPieSeries():PieSeries {
			
			var seri:PieSeries = new PieSeries();
			seri.field = "cnt";
			seri.nameField = "result";
			seri.setStyle("labelPosition","callout");
			
			seri.setStyle("fills",[
				new SolidColor(0x808080, .6),
				new SolidColor(0x000000, .6),
				new SolidColor(0x0000FF, .6),
				new SolidColor(0xFF0000, .6),
				new SolidColor(0xFFFF00, .6)
			]);
			
			seri.setStyle("stroke", new SolidColorStroke(0x000000, 2, .5) );
			seri.setStyle("radialStroke", new SolidColorStroke(0xFFFFCC, 1, .3) );
			
			
			seri.labelFunction = charLabelFunction;
			
			return seri;
		}
		
		private function charLabelFunction(data:Object, field:String, index:Number, percentValue:Number):String {
			var temp:String= String(percentValue).substr(0,6);
			return data.result + ": " + data.cnt + '\n' + temp + "%";
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
				message.text = vo.message;
				RemoteSingleManager.getInstance.addEventListener("getSentListDetail", groupList_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.getSentListDetail(vo);
			}
		}
		
		private function groupList_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("getSentListDetail", groupList_resultHandler);
			var data:ArrayCollection = event.result as ArrayCollection;
			acDetail.removeAll();
			acDetail.addAll(data);
			
			setChartData();
		}
		private function setChartData():void {
			
			
			var cnt:int = acDetail.length;
			
			var def:int = 0;
			var ing:int = 0;
			var suc:int = 0;
			var fail:int = 0;
			var noNum:int = 0;
			
			var vo:MessageVO = null;
			for (var i:int = 0; i < cnt; i++) {
				vo = acDetail.getItemAt(i) as MessageVO;
				if (vo.rslt == "전송중") ing++;
				else if (vo.rslt == "성공") suc++;
				else if (vo.rslt == "실패" || vo.rslt == "수신거부" || vo.rslt == "중복번호") fail++;
				else if (vo.rslt == "없는번호") noNum++;
				else def++;
			}
			
			acChart.removeAll();
			acChart.addItem({result:"대기중",cnt:def});
			acChart.addItem({result:"전송중",cnt:ing});
			acChart.addItem({result:"성공",cnt:suc});
			acChart.addItem({result:"실패",cnt:fail});
			acChart.addItem({result:"없는번호",cnt:noNum});
			
		}
		
		
		private function groupList_keyUpHandler(event:KeyboardEvent):void {
			
			if (event.keyCode == 46) {
				
				confirmAlert = new AlertManager("삭제 하시겠습니까?","내역삭제", 1|8, Sprite(parentApplication), groupList.selectedIndex);
				confirmAlert.addEventListener("yes",deleteGroupList_confirmHandler, false, 0, true);
			}
		}
		
		private function deleteGroupList_confirmHandler(event:CustomEvent):void {
			
			confirmAlert.removeEventListener("yes",deleteGroupList_confirmHandler);
			
			RemoteSingleManager.getInstance.addEventListener("deleteSent", deleteSent_resultHandler, false, 0, true);
			RemoteSingleManager.getInstance.callresponderToken 
				= RemoteSingleManager.getInstance.service.deleteSent( LogVO(acGroup.getItemAt(event.result as int)) );
		}
		private function deleteSent_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("deleteSent", deleteSent_resultHandler);
			var bvo:BooleanAndDescriptionVO = BooleanAndDescriptionVO(event.result);
			if (bvo.bResult == true)
				acGroup.removeItemAt(groupList.selectedIndex);
			
			SLibrary.alert( BooleanAndDescriptionVO(event.result).strDescription );
			
			Main(parentApplication).login_check();
		}
		
		private function detailListLabelFunction(item:Object, column:GridColumn):String {
			
			return (acDetail.length - acDetail.getItemIndex(item)).toString();
		}
		
		
		public function destroy():void {
			
			preMonth = null;
			month = null;
			nextMonth = null;
			monthSlider = null;
			
			message = null;
			
			_yyyymm = null;
			if (acChart != null) {
				acChart.removeAll();
				acChart = null;
			}
			if (acGroup != null) {
				acGroup.removeAll();
				acGroup = null;
			}
			
			if (acDetail != null) {
				acDetail.removeAll();
				acDetail = null;
			}
			
			if (alDetailColumn != null) {
				alDetailColumn.removeAll();
				alDetailColumn = null;
			}
			
			
			confirmAlert = null;
			
		}
		
	}
}