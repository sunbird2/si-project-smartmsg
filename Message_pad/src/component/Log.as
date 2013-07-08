package component
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	
	import component.util.ListCheckAble;
	import component.util.TextInputSearch;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
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
	import mx.collections.AsyncListView;
	import mx.controls.DateField;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.formatters.DateFormatter;
	import mx.graphics.SolidColor;
	import mx.graphics.SolidColorStroke;
	import mx.rpc.CallResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import services.Smt;
	
	import skin.LogSkin;
	
	import spark.components.Button;
	import spark.components.DataGrid;
	import spark.components.DropDownList;
	import spark.components.HSlider;
	import spark.components.Image;
	import spark.components.Label;
	import spark.components.List;
	import spark.components.RichText;
	import spark.components.TextArea;
	import spark.components.gridClasses.GridColumn;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.IndexChangeEvent;
	import spark.filters.DropShadowFilter;
	
	import valueObjects.BooleanAndDescriptionVO;
	import valueObjects.LogVO;
	import valueObjects.MessageVO;
	import valueObjects.SentStatusVO;
	
	[Event(name="failAdd", type="flash.events.Event")]
	/* A component must identify the view states that its skin supports. 
	Use the [SkinState] metadata tag to define the view states in the component class. 
	[SkinState("normal")] */
	[SkinState("normal")]
	[SkinState("detail")]
	
	public class Log extends SkinnableComponent
	{
		public static const FAIL_ADD:String = "failAdd";
		/* To declare a skin part on a component, you use the [SkinPart] metadata. 
		[SkinPart(required="true")] */
		
		[SkinPart(required="false")]public var preMonth:Label;
		[SkinPart(required="false")]public var month:Label;
		[SkinPart(required="false")]public var nextMonth:Label;
		[SkinPart(required="false")]public var monthSlider:HSlider;
		
		[SkinPart(required="false")]public var message:TextArea;
		[SkinPart(required="false")]public var chart:PieChart;
		
		[SkinPart(required="false")]public var groupList:ListCheckAble;
		[SkinPart(required="false")]public var listMultSelectBtn:Image;
		[SkinPart(required="false")]public var listDelBtn:Image;
		
		
		[SkinPart(required="false")]public var detailList:List;
		[SkinPart(required="false")]public var excelDownBtn:Image;
		[SkinPart(required="false")]public var searchType:DropDownList;
		[SkinPart(required="false")]public var search:TextInputSearch;
		[SkinPart(required="false")]public var failAdd:Image;
		
		
		private var _yyyymm:String;
		private var acGroup:ArrayCollection = new ArrayCollection();
		private var acDetail:ArrayCollection = new ArrayCollection();
		private var acChart:ArrayCollection = new ArrayCollection();
		private var arrSearch:ArrayCollection = new ArrayCollection([{label:"전체"},{label:"성공"},{label:"실패"},{label:"전송중"},{label:"대기"},{label:"없는번호"}]);
		private var failCount:int = 0; 
		
		private var confirmAlert:AlertManager;
		
		// state
		private var _cstat:String = "normal";
		public function get cstat():String { return _cstat; }
		public function set cstat(value:String):void { 
			_cstat = value;
			invalidateSkinState();
		}
		
		// paging
		[Bindable] public var asyncListView:AsyncListView = new AsyncListView();
		[Bindable] public var callResponder:CallResponder =  new CallResponder();
		public var smt:Smt;
		private var detailVO:LogVO;
		
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
		
		override protected function getCurrentSkinState():String { return cstat; }

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
				detailList.dataProvider = asyncListView;
				detailList.addEventListener(IndexChangeEvent.CHANGE, detailList_changeHandler, false, 0, true);
			}
			else if (instance == chart) {
				
				chart.series = [getPieSeries()];
				//chart.filters = [ new DropShadowFilter(0,0,0x000000,0.8) ];
				chart.showDataTips = true;
				chart.dataProvider = acChart;
			}
			else if (instance == listMultSelectBtn) listMultSelectBtn.addEventListener(MouseEvent.CLICK, listMultSelectBtn_clickHandler);
			else if (instance == listDelBtn) listDelBtn.addEventListener(MouseEvent.CLICK, listDelBtn_clickHandler);
			else if (instance == excelDownBtn) excelDownBtn.addEventListener(MouseEvent.CLICK, excelDownBtn_clickHandler);
			else if (instance == message) {
				
				if (groupList && groupList.selectedIndex > 0 ) {
					var vo:LogVO = acGroup.getItemAt(groupList.selectedIndex) as LogVO;
					message.text = vo.message;
				}
				
			}
			else if (instance == searchType)  {
				searchType.dataProvider = arrSearch;
				searchType.selectedIndex = 0;
			}
			else if (instance == search) search.addEventListener("search" , search_clickHandler);
			else if (instance == failAdd) failAdd.addEventListener(MouseEvent.CLICK, failAdd_clickHandler);
			
			
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
				//asyncListView.list.removeAll();
				//asyncListView.removeAll();
				//detailList.columns = null
				//detailList.columns.removeAll();
				//alDetailColumn.removeAll(); 
				//acDetail.removeAll();
				//acDetail = null;
				detailList.removeEventListener(IndexChangeEvent.CHANGE, detailList_changeHandler);
			}
			else if (instance == chart) {
				Object(chart.dataProvider).removeAll();
			}
			else if (instance == listMultSelectBtn) listMultSelectBtn.removeEventListener(MouseEvent.CLICK, listMultSelectBtn_clickHandler);
			else if (instance == listDelBtn) listDelBtn.removeEventListener(MouseEvent.CLICK, listDelBtn_clickHandler);
			else if (instance == excelDownBtn) excelDownBtn.removeEventListener(MouseEvent.CLICK, excelDownBtn_clickHandler);
			else if (instance == searchType) searchType.dataProvider = null;
			else if (instance == search) search.removeEventListener("search" , search_clickHandler);
			else if (instance == failAdd) failAdd.addEventListener(MouseEvent.CLICK, failAdd_clickHandler);
			
			super.partRemoved(partName, instance);
		}
		
		override public function stylesInitialized():void {
			setStyle("skinClass", LogSkin);
		}
		override protected function createChildren():void {
			mx_internal::skinDestructionPolicy = "auto";
			super.createChildren();
		}
		
		private function tracker(msg:String):void {
			MunjaNote(parentApplication).googleTracker("Address/"+msg);
		}
		
		private function failAdd_clickHandler(event:MouseEvent):void {
			
			if (!detailVO) SLibrary.alert("그룹내역에서 항목을 선택 후 진행 하실 수 있습니다." );
			else if (failCount < 1) SLibrary.alert("실패된 내역이 없습니다." );
			else {
				RemoteSingleManager.getInstance.addEventListener("failAdd", failAdd_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.failAdd(detailVO);
			}
			tracker("failAdd_clickHandler");// tracker
		}
		private function failAdd_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("failAdd", getSentList_resultHandler);
			var rslt:BooleanAndDescriptionVO = event.result as BooleanAndDescriptionVO;
			this.dispatchEvent(new Event(Log.FAIL_ADD));
			SLibrary.alert(rslt.strDescription);
			getDetailList();
			
		}
		
		
		private function getPieSeries():PieSeries {
			
			var seri:PieSeries = new PieSeries();
			seri.field = "cnt";
			seri.nameField = "result";
			seri.setStyle("labelPosition","callout");
			
			seri.setStyle("fills",[
				new SolidColor(0x000000, .9),
				new SolidColor(0x808080, .9),
				new SolidColor(0x99CC00, .9),
				new SolidColor(0xFF4444, .9),
				new SolidColor(0xFFBB33, .9)
			]);
			
			seri.setStyle("stroke", new SolidColorStroke(0x000000, 1, .5) );
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
		public function getSentList():void {
			
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
		
		private function getDetailStatus():void {
			
			if (detailVO) {
				RemoteSingleManager.getInstance.addEventListener("getSentResultStatus", getDetailStatus_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.getSentResultStatus(detailVO);
			}
			
		}
		private function getDetailStatus_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("getSentResultStatus", getDetailStatus_resultHandler);
			var ssvo:SentStatusVO = event.result as SentStatusVO;
			if (ssvo) {
				
				acChart.removeAll();
				
				acChart.addItem({result:"대기중",cnt:ssvo.local});
				acChart.addItem({result:"전송중",cnt:ssvo.telecom});
				acChart.addItem({result:"성공",cnt:ssvo.success});
				acChart.addItem({result:"실패",cnt:ssvo.fail});
				
				/*
				acChart.addItem({result:"대기중",cnt:1});
				acChart.addItem({result:"전송중",cnt:1});
				acChart.addItem({result:"성공",cnt:1});
				acChart.addItem({result:"실패",cnt:1});
				*/
				failCount = ssvo.fail;
				failAdd.enabled = failCount > 0 ? true : false;
				
				//SLibrary.alert(failCount+ " 건의 실패 내역이 있습니다.\r\n오른쪽 상단의 실패보상을 클릭 하세요.");
			}
			if (message)
				message.text = detailVO.message;
			getDetailList();
			
		}
		
		
		private function groupList_changeHandler(event:IndexChangeEvent):void {
			
			var vo:LogVO = acGroup.getItemAt(event.newIndex) as LogVO;
			
			if (vo != null) {
				cstat = "detail";
				detailVO = vo;
				getDetailStatus(); // later getDetailList()
				//message.visible = true;
				
				
				/*RemoteSingleManager.getInstance.addEventListener("getSentListDetail", groupList_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.getSentListDetail(vo);*/
			}else {
				cstat = "normal";
			}
			tracker("groupList_changeHandler");// tracker
		}
		
		private function detailList_changeHandler(event:IndexChangeEvent):void {
			
			var vo:MessageVO = detailList.dataProvider.getItemAt(event.newIndex) as MessageVO;
			
			if (vo != null) {
				message.text = vo.msg;
			}
		}
		
		
		
		private function getDetailList():void {
			
			if (detailVO) {
				//groupList.visible = true;
				PagedFilterSmtInit();
				callResponder.removeEventListener(ResultEvent.RESULT, callResponder_resultHandler);
				callResponder.addEventListener(ResultEvent.RESULT, callResponder_resultHandler);
				callResponder.token = smt.getSentListDetail_pagedFiltered(detailVO );
			}
			
		}
		private function callResponder_resultHandler(event:ResultEvent):void {
			
			callResponder.removeEventListener(ResultEvent.RESULT, callResponder_resultHandler);
			asyncListView.list = callResponder.lastResult;
		}
		
		
		/*private function groupList_resultHandler(event:CustomEvent):void {
			
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
			
		}*/
		
		
		private function groupList_keyUpHandler(event:KeyboardEvent):void {
			
			if (event.keyCode == 46) deleteGroupList();
		}
		private function deleteGroupList():void {
			confirmAlert = new AlertManager("선택한 그룹 내역을 삭제 하시겠습니까?","내역삭제", 1|8, Sprite(parentApplication), groupList.selectedIndex);
			confirmAlert.addEventListener("yes",deleteGroupList_confirmHandler, false, 0, true);
		}
		
		private function deleteGroupList_confirmHandler(event:CustomEvent):void {
			
			confirmAlert.removeEventListener("yes",deleteGroupList_confirmHandler);
			confirmAlert = null;
			
			if (groupList.allowMultipleSelection) {
				
				
				var act:Vector.<Object> = groupList.selectedItems;
				var cnt:int = act.length;
				var ac:ArrayCollection = new ArrayCollection();
				var i:int = 0;
				for(i = 0; i < cnt; i++) {
					ac.addItem( LogVO( groupList.selectedItems[i] ) );
				}
				
				if (ac.length == 0) {
					SLibrary.alert("선택된 그룹내역이 없습니다.");
				}else {
					
					RemoteSingleManager.getInstance.addEventListener("deleteManySent", deleteManySent_resultHandler, false, 0, true);
					RemoteSingleManager.getInstance.callresponderToken 
						= RemoteSingleManager.getInstance.service.deleteManySent( ac );
				}
				
				
			}else {
				RemoteSingleManager.getInstance.addEventListener("deleteSent", deleteSent_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.deleteSent( acGroup.getItemAt(event.result as int) as LogVO  );
			}
			
		}
		private function deleteManySent_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("deleteManySent", deleteManySent_resultHandler);
			var data:ArrayCollection = event.result as ArrayCollection;
			if (data && data.length > 0) {
				var suc:String = "";
				var fail:String = "";
				var bvo:BooleanAndDescriptionVO = null;
				var cnt:int = data.length;
				var line:String = "\\r\\n";;
				for (var i:int = 0; i < cnt; i++) {
					
					bvo = data.getItemAt(i) as BooleanAndDescriptionVO;
					if (bvo.bResult == true) {
						suc +=bvo.strDescription+line;
					}else {
						fail +=bvo.strDescription+line;
					}
					
				}
			}
			
			getSentList();
			if (fail == "")
				SLibrary.alert( "처리 내역"+line+line+" - 삭제(취소)완료"+line+suc );
			else 
				SLibrary.alert( "처리 내역"+line+line+" - 삭제(취소)완료"+line+suc+line+line+" - 삭제실패"+line+fail );
			
			
			cstat = "normal";
			acChart.removeAll();
			
		}
		private function deleteSent_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("deleteSent", deleteSent_resultHandler);
			var bvo:BooleanAndDescriptionVO = BooleanAndDescriptionVO(event.result);
			if (bvo.bResult == true)
				acGroup.removeItemAt(groupList.selectedIndex);
			
			SLibrary.alert( BooleanAndDescriptionVO(event.result).strDescription );
			
			cstat = "normal";
			acChart.removeAll();
			
		}
		
		
		
		// option
		private function listMultSelectBtn_clickHandler(event:MouseEvent):void {
			
			if (groupList.allowMultipleSelection) {
				groupList.allowMultipleSelection = false;
				listMultSelectBtn.alpha = 0.4;
			}else {
				groupList.allowMultipleSelection = true;
				listMultSelectBtn.alpha = 1;
				SLibrary.alert("여러개의 그룹내역을 선택 하실 수 있습니다.");
			}
		}
		private function listDelBtn_clickHandler(event:MouseEvent):void {
			deleteGroupList();
		}
		private function excelDownBtn_clickHandler(event:MouseEvent):void {
			ExternalInterface.call("excelDownload", "/custom/sentExcel.jsp?idx="+detailVO.idx+"&mode="+detailVO.mode+"&line="+detailVO.line);
		}
		
		/**
		 * paging
		 * */
		private function PagedFilterSmtInit():void {
			if (smt == null) {
				smt = new services.Smt();
				smt.showBusyCursor = true;
				smt.addEventListener("fault", smt_fault);
				smt.initialized(this, "smt")
			}
			
		}
		public function smt_fault(event:FaultEvent):void { SLibrary.alert(event.fault.faultString + '\n' + event.fault.faultDetail); }
		
		
		private function search_clickHandler(event:CustomEvent):void {
			
			if (detailVO) {
				
				detailVO.search = searchType.selectedIndex + "/"+search.text;
				//groupList.visible = true;
				//callResponder.token = smt.getSentListDetail_pagedFiltered(detailVO);
				getDetailList();
			} else {
				SLibrary.alert("그룹내역을 선택 하세요");
			}
			/*if (Gv.bLogin) {
				var s:String = String(event.result);
				if (s != null && s != "") {
					RemoteSingleManager.getInstance.addEventListener("getAddrList", getNameList_resultHandler, false, 0, true);
					RemoteSingleManager.getInstance.callresponderToken 
						= RemoteSingleManager.getInstance.service.getAddrList(2, String(event.result));	
				}else {
					SLibrary.alert("검색 내용을 입력하세요.");
				}
				
			}*/
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
			
			
			if (asyncListView != null) {
				//asyncListView.removeAll();
				//asyncListView.list.removeAll();
				asyncListView = null;
			}
			
			if (callResponder != null) {
				callResponder.removeEventListener(ResultEvent.RESULT, callResponder_resultHandler);
				callResponder = null
			}
			if (smt != null) {
				smt.removeEventListener("fault", smt_fault);
			}
			if (detailVO != null) detailVO = null;
			
			confirmAlert = null;
			
		}
		
	}
}