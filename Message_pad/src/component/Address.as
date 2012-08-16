package component
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	import component.excel.Excel;
	import component.util.CustomToolTip;
	import component.util.TextInputSearch;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import flashx.textLayout.elements.LinkElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.events.FlowElementMouseEvent;
	
	import lib.AlertManager;
	import lib.CustomEvent;
	import lib.Gv;
	import lib.IconItemRenderer;
	import lib.RemoteSingleManager;
	import lib.SLibrary;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.controls.Alert;
	import mx.core.ClassFactory;
	import mx.core.IFactory;
	import mx.events.CloseEvent;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.DragEvent;
	import mx.events.PropertyChangeEvent;
	import mx.managers.PopUpManager;
	import mx.rpc.events.ResultEvent;
	
	import skin.AddressSkin;
	
	import spark.components.Button;
	import spark.components.ComboBox;
	import spark.components.Group;
	import spark.components.IconPlacement;
	import spark.components.Image;
	import spark.components.List;
	import spark.components.RichText;
	import spark.components.TextArea;
	import spark.components.TextInput;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.IndexChangeEvent;
	import spark.layouts.VerticalLayout;
	import spark.layouts.supportClasses.DropLocation;
	
	import valueObjects.AddressVO;
	
	
	/* A component must identify the view states that its skin supports. 
	Use the [SkinState] metadata tag to define the view states in the component class. 
	[SkinState("normal")] */
	[SkinState("normal")]
	[SkinState("nameEdit")]
	
	public class Address extends SkinnableComponent
	{
		/* To declare a skin part on a component, you use the [SkinPart] metadata. 
		[SkinPart(required="true")] */
		
		
		[SkinPart(required="true")]public var contentGroup:Group;
		[SkinPart(required="false")]public var search:TextInputSearch;
		
		// group
		[SkinPart(required="false")]public var groupList:List;
		[SkinPart(required="false")]public var groupAddBtn:Image;
		
		// name
		[SkinPart(required="false")]public var nameList:List;
		[SkinPart(required="false")]public var nameAddBtn:Image;
		[SkinPart(required="false")]public var nameCount:SpanElement;
		
		
		
		// card
		[SkinPart(required="true")]public var groupName:ComboBox;
		[SkinPart(required="true")]public var nameL:TextInput;
		[SkinPart(required="true")]public var phone:TextInput;
		[SkinPart(required="false")]public var memo:TextArea;
		[SkinPart(required="false")]public var cardBtn:Image;
		
		// function
		[SkinPart(required="false")]public var addressFromExcel:Image;
		
		private var excel:Excel;
		
		private var acGroup:ArrayCollection = new ArrayCollection();
		private var acName:ArrayCollection = new ArrayCollection();
		
		private var currentGroupName:String = "";
		private var _bEdite:Boolean = false;
		
		private var confirmAlert:AlertManager;
		private var customToolTip:CustomToolTip;
		
		// activeCode and vo
		private var _activeCode:Number = 0;
		private var _activeAddressVO:AddressVO;
		
		public function Address() {
			super();
			
			setStyle("skinClass", AddressSkin);
			
			addEventListener(Event.ADDED_TO_STAGE, addedtostage_handler, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, removedfromstage_handler, false, 0, true);
		}
		public function addedtostage_handler(event:Event):void {
			
			getGroup();
		}
		
		public function removedfromstage_handler(event:Event):void {
			
			removeEventListener(Event.REMOVED_FROM_STAGE, removedfromstage_handler);
			removeEventListener(Event.ADDED_TO_STAGE, addedtostage_handler);
			
			removeExcel();
			//detachSkin();
			//destory();
		}
		
		public function get activeAddressVO():AddressVO { return _activeAddressVO; }
		public function set activeAddressVO(value:AddressVO):void { _activeAddressVO = value; }

		public function get activeCode():Number { return _activeCode; }
		public function set activeCode(value:Number):void { _activeCode = value; }

		public function get bEdite():Boolean { return _bEdite; }
		public function set bEdite(value:Boolean):void {
			if (_bEdite != value) {
				_bEdite = value;
				invalidateSkinState();
			}
		}

		/**
		 * group collection change
		 * */
		private function acGroup_changeHandler(event:CollectionEvent):void {
			
			switch (event.kind) { 
				case CollectionEventKind.ADD: break; 
				case CollectionEventKind.REMOVE: 
					for (var j:uint = 0; j < event.items.length; j++) { 
						if (event.items[i] is AddressVO
							&& AddressVO(event.items[i]) != null 
							&& AddressVO(event.items[i]).idx != 0) {  
							
							activeAddress(12, AddressVO(event.items[i])); 
						} 
					} 
					break; 
				
				case CollectionEventKind.UPDATE: 
					for (var i:uint = 0; i < event.items.length; i++) { 
						if (event.items[i] is PropertyChangeEvent
							&& PropertyChangeEvent(event.items[i]) != null
							&& PropertyChangeEvent(event.items[i]).property == "grpName") { 
							activeAddress(
								(AddressVO(PropertyChangeEvent(event.items[i]).source).idx == 0)? 10 : 11,
								AddressVO(PropertyChangeEvent(event.items[i]).source)
							); 
						} 
					} 
					break; 
				
				case CollectionEventKind.RESET: break; 
			} 
		}
		/* Implement the getCurrentSkinState() method to set the view state of the skin class. */
		override protected function getCurrentSkinState():String
		{
			return (bEdite)?"nameEdit":"normal";
		} 
		
		/* Implement the partAdded() method to attach event handlers to a skin part, 
		configure a skin part, or perform other actions when a skin part is added. */	
		override protected function partAdded(partName:String, instance:Object) : void
		{
			super.partAdded(partName, instance);
			if (instance == groupList) {
				
				acGroup.addEventListener(CollectionEvent.COLLECTION_CHANGE, acGroup_changeHandler, false, 0, true);
				groupList.dataProvider = acGroup;
				groupList.doubleClickEnabled = true;
				groupList.dropEnabled = true;
				groupList.addEventListener(IndexChangeEvent.CHANGE, groupList_changeHandler);
				groupList.addEventListener(KeyboardEvent.KEY_UP, groupList_keyUpHandler);
				groupList.addEventListener(DragEvent.DRAG_DROP, groupList_dragDropHandler);
				groupList.addEventListener(DragEvent.DRAG_OVER, groupList_dragOverHandler);
			}
			else if (instance == nameList) {
				nameList.dataProvider = acName;
				nameList.dragEnabled = true;
				nameList.dragMoveEnabled = true;
				nameList.allowMultipleSelection = true;
				
				var irFactory:ClassFactory = new ClassFactory(IconItemRenderer);
				irFactory.properties = {
					icon:"skin/ics/assets/light/icon/6-social-person.png",
					labelTitle:"name",
					labelSub:"phone"};
				nameList.itemRenderer = irFactory;
				
				//nameList.labelFunction = nameLabelFunction;
				nameList.addEventListener(IndexChangeEvent.CHANGE, nameList_changeHandler);
				nameList.addEventListener(KeyboardEvent.KEY_UP, namepList_keyUpHandler);
			}
			else if (instance == groupAddBtn) groupAddBtn.addEventListener(MouseEvent.CLICK, groupAddBtn_clickHandler);
			else if (instance == nameAddBtn) nameAddBtn.addEventListener(MouseEvent.CLICK, nameAddBtn_clickHandler);
			else if (instance == cardBtn) cardBtn.addEventListener(MouseEvent.CLICK, cardBtn_clickHandler);
			else if (instance == addressFromExcel) addressFromExcel.addEventListener(MouseEvent.CLICK, addressFromExcel_clickHandler);
			else if (instance == search) search.addEventListener("search" , search_clickHandler);
			else if (instance == groupName) {
				groupName.dataProvider = acGroup;
				groupName.labelField = "grpName";
			}
			
			
			if (instance is LinkElement) {
				instance.addEventListener(FlowElementMouseEvent.ROLL_OVER, tooltip_overHandler);
				instance.addEventListener(FlowElementMouseEvent.ROLL_OUT, tooltip_outHandler);
			}

		}
		
		/* Implement the partRemoved() method to remove the even handlers added in partAdded() */
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
			
			if (instance == groupList) {
				acGroup.removeEventListener(CollectionEvent.COLLECTION_CHANGE, acGroup_changeHandler);
				Object(groupList.dataProvider).removeAll();
				

				groupList.removeEventListener(IndexChangeEvent.CHANGE, groupList_changeHandler);
				groupList.removeEventListener(KeyboardEvent.KEY_UP, groupList_keyUpHandler);
				groupList.removeEventListener(DragEvent.DRAG_DROP, groupList_dragDropHandler);
				groupList.removeEventListener(DragEvent.DRAG_OVER, groupList_dragOverHandler);
				
				acGroup.removeAll();
				
				groupList = null;
				
			}
			else if (instance == nameList) {
				Object(nameList.dataProvider).removeAll();

				nameList.removeEventListener(IndexChangeEvent.CHANGE, nameList_changeHandler);
				nameList.removeEventListener(KeyboardEvent.KEY_UP, namepList_keyUpHandler);
				nameList = null;
			}
			else if (instance == groupAddBtn) groupAddBtn.removeEventListener(MouseEvent.CLICK, groupAddBtn_clickHandler);
			else if (instance == nameAddBtn) nameAddBtn.removeEventListener(MouseEvent.CLICK, nameAddBtn_clickHandler);
			else if (instance == cardBtn) cardBtn.removeEventListener(MouseEvent.CLICK, cardBtn_clickHandler);
			else if (instance == addressFromExcel) addressFromExcel.removeEventListener(MouseEvent.CLICK, addressFromExcel_clickHandler);
			else if (instance == search) search.removeEventListener("search" , search_clickHandler);
			
			if (instance is LinkElement) {
				instance.removeEventListener(FlowElementMouseEvent.ROLL_OVER, tooltip_overHandler);
				instance.removeEventListener(FlowElementMouseEvent.ROLL_OUT, tooltip_outHandler);
			}
			
			
		}
		
		private function search_clickHandler(event:CustomEvent):void {
			
			if (Gv.bLogin) {
				var s:String = String(event.result);
				if (s != null && s != "") {
					RemoteSingleManager.getInstance.addEventListener("getAddrList", getNameList_resultHandler, false, 0, true);
					RemoteSingleManager.getInstance.callresponderToken 
						= RemoteSingleManager.getInstance.service.getAddrList(2, String(event.result));	
				}else {
					SLibrary.alert("검색 내용을 입력하세요.");
				}
				
			}
		}
		
		
		/**
		 * group list
		 * */
		private function getGroup():void {
			
			if (Gv.bLogin) {
				RemoteSingleManager.getInstance.addEventListener("getAddrList", getGroup_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.getAddrList(0, "");
			}
			
		}
		private function getGroup_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("getAddrList", getGroup_resultHandler);
			var data:ArrayCollection = event.result as ArrayCollection;
			acGroup.removeAll();
			// allGroup add
			acGroup.addItem( allAddressGroupVO() );
			acGroup.addAll(data);
			
			setGvGroup();
		}
		private function groupList_keyUpHandler(event:KeyboardEvent):void {
			
			if (event.keyCode == 46
				&& AddressVO(groupList.selectedItem).grpName != "모두") {
				
				confirmAlert = new AlertManager("["+AddressVO(groupList.selectedItem).grpName+"] 그룹의 주소도 모두 삭제 됩니다.\n 삭제 하시겠습니까?","그룹삭제", 1|8, Sprite(parentApplication), groupList.selectedIndex);
				confirmAlert.addEventListener("yes",deleteGroup_confirmHandler, false, 0, true);
			}
				
		}
		private function allAddressGroupVO():AddressVO {
			
			var avo:AddressVO = new AddressVO();
			avo.grpName = "모두";
			avo.idx = 0;
			
			return avo;
		}
		private function setGvGroup():void {
			
			var arr:Array = [];
			if (acGroup != null && acGroup.length > 0) {
			
				var avo:AddressVO = null;
				Gv.addressGroupList.removeAll();
				for (var i:Number = 0; i < acGroup.length; i++) {
					avo = acGroup.getItemAt(i) as AddressVO;
					if (avo.idx != 0) {
						Gv.addressGroupList.addItem(avo.grpName);
					}
						
				}
				
			}
			 
		}
		private function deleteGroup_confirmHandler(event:CustomEvent):void {
			
			confirmAlert.removeEventListener("yes",deleteGroup_confirmHandler);
			confirmAlert = null;
			acGroup.removeItemAt( int(event.result) );
			acName.removeAll();
		}
		
		/**
		 * group list click
		 * */
		private function groupList_changeHandler(event:IndexChangeEvent):void {
			
			var vo:AddressVO = acGroup.getItemAt(event.newIndex) as AddressVO;
			if (vo != null) {
				var gName:String = (vo.idx == 0)? "":vo.grpName;
				currentGroupName = gName;
				getNameList();
			}
		}
		private function getNameList():void {
			RemoteSingleManager.getInstance.addEventListener("getAddrList", getNameList_resultHandler, false, 0, true);
			RemoteSingleManager.getInstance.callresponderToken 
				= RemoteSingleManager.getInstance.service.getAddrList(1, currentGroupName);
		}
		private function getNameList_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("getAddrList", getNameList_resultHandler);
			
			var data:ArrayCollection = event.result as ArrayCollection;
			
			if (data != null) {
				acName.removeAll();
				acName.addAll(data);
				nameCount.text = String(acName.length);
			}
			
			viewCard();
			bEdite = false;
			
		}
		
		private function nameLabelFunction(item:Object):String {
			
			var avo:AddressVO = item as AddressVO;
			return (avo.name != "") ? avo.name : avo.phone;
		}
		
		private function cardBtn_clickHandler(event:MouseEvent):void {
			
			if (bEdite) {
				setCard();
				activeName();
			}else {
				bEdite = true;
			}
				
		}
		private function activeName():void {
			
			var avo:AddressVO = AddressVO( acName.getItemAt( nameList.selectedIndex ) );
			if (avo.idx == 0) {// insert
				if (currentGroupName == "") SLibrary.alert("그룹 선택 후 저장하세요.");
				else {
					activeAddress(20, avo);
				}
				
			}else {// update
				activeAddress(21, avo);
			}
		}
		private function setCard():void {
			
			if (nameList.selectedIndex >= 0) {
				
				var avo:AddressVO = AddressVO( acName.getItemAt( nameList.selectedIndex ) );
				
				avo.grp = 1;
				//avo.grpName = currentGroupName;
				avo.grpName = AddressVO(groupName.selectedItem).grpName;
				avo.name = nameL.text;
				avo.phone = phone.text;
				avo.memo = memo.text;
			}
			
		}
		private function viewCard():void {
			
			if (nameList.selectedIndex >= 0) {
				var avo:AddressVO = AddressVO( acName.getItemAt( nameList.selectedIndex ) );
				if (avo != null) {
					groupName.selectedItem = avo;
					nameL.text = avo.name;
					phone.text = avo.phone;
					memo.text = avo.memo;
				}
			}
			else {
				groupName.selectedIndex = -1;
				nameL.text = "";
				phone.text = "";
				memo.text = "";
			}
				
			
		}
		
		private function nameList_changeHandler(event:IndexChangeEvent):void {
			
			if (bEdite) bEdite = false;
			
			viewCard();
		}
		
		private function namepList_keyUpHandler(event:KeyboardEvent):void {
			
			if (event.keyCode == 46) {
				
				confirmAlert = new AlertManager("삭제 하시겠습니까?","카드삭제", 1|8, Sprite(parentApplication), nameList.selectedIndex);
				confirmAlert.addEventListener("yes",deleteName_confirmHandler, false, 0, true);
			}
			
		}
		private function deleteName_confirmHandler(event:CustomEvent):void {
			
			confirmAlert.removeEventListener("yes",deleteName_confirmHandler);
			confirmAlert = null;
			activeAddress(22, AddressVO( acName.getItemAt(int(event.result)) ) ); 
			acName.removeItemAt( int(event.result) );
			viewCard();
		}
		
		
		/**
		 * add Group
		 * */
		private function groupAddBtn_clickHandler(event:MouseEvent):void {
			
			event.stopImmediatePropagation();
			event.preventDefault();
			var avo:AddressVO = new AddressVO();
			avo.grpName = "";
			acGroup.addItem( avo );
			
		}
		
		/**
		 * insert or update group
		 * */
		private function activeAddress(code:Number, avo:AddressVO):void {
			
			if (avo.grpName == "") {
				SLibrary.alert("그룹이름이 없습니다.");
			}else {
				activeCode = code;
				activeAddressVO = avo;
				
				setGvGroup();
				RemoteSingleManager.getInstance.addEventListener("modifyAddr", activeAddress_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.modifyAddr(code, avo);
			}
		}
		private function activeAddress_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("modifyAddr", activeAddress_resultHandler);
			var i:int = event.result as int;
			
			if (i <= 0) {
				SLibrary.alert("적용 되지 않았습니다.");
				return;
			}
			switch(activeCode) {
				
				case 10:
				case 20:
				{
					activeAddressVO.idx = i;
					break;
				}
				default: { break; }
			}
			
			setGvGroup();
			
			
		}
		
		/**
		 * name method
		 * */
		private function nameAddBtn_clickHandler(event:MouseEvent):void {
			
			event.stopImmediatePropagation();
			event.preventDefault();
			bEdite = true;
			acName.addItemAt(new AddressVO(), 0);
			nameCount.text = String(acName.length);
			callLater(editeSelect);
		}
		private function editeSelect():void {
			nameList.selectedIndex = 0;
			nameList.dispatchEvent( new IndexChangeEvent(IndexChangeEvent.CHANGE) );
			nameL.setFocus();
		}
		
		
		/**
		 * Drag and Drop
		 * */
		private function groupList_dragDropHandler(event:DragEvent):void {
			
			event.preventDefault();

			var cnt:int = List(event.dragInitiator).selectedIndices.length;
			if (cnt > 0) {
				var ac:ArrayCollection = new ArrayCollection();
				for(var i:Number = 0; i < cnt; i++) {
					ac.addItem( AddressVO( List(event.dragInitiator).selectedItems[i] ) );
				}
				if (event.action == "copy") {
					moveGroup( ac, acGroup.getItemAt(findItemIndexForDragEvent(event)).grpName );	
				}else {
					copyGroup( ac, acGroup.getItemAt(findItemIndexForDragEvent(event)).grpName );	
				}
			}
		}
		private function groupList_dragOverHandler(event:DragEvent):void {
			event.preventDefault();
		}
		private function findItemIndexForDragEvent(event:DragEvent):Number{
			
			var d:DropLocation = event.target.layout.calculateDropLocation(event);
			var v:VerticalLayout = VerticalLayout(event.target.layout);
			var itemIndex:Number = Math.floor( d.dropPoint.y/v.rowHeight );
			
			return itemIndex;
		}
		
		private function moveGroup(ac:ArrayCollection, groupName:String):void {
			
			if (groupName == "") {
				SLibrary.alert("이동할 그룹 이름이 없습니다.");
			}else {
				
				RemoteSingleManager.getInstance.addEventListener("modifyManyAddr", moveGroup_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.modifyManyAddr(32, ac, groupName);	
			}
		}
		private function copyGroup(ac:ArrayCollection, groupName:String):void {
			
			if (groupName == "") {
				SLibrary.alert("복사할 그룹 이름이 없습니다.");
			}else {
				
				RemoteSingleManager.getInstance.addEventListener("modifyManyAddr", moveGroup_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.modifyManyAddr(31, ac, groupName);	
			}
		}
		private function moveGroup_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("modifyManyAddr", moveGroup_resultHandler);
		}
		
		private function addressFromExcel_clickHandler(event:MouseEvent):void {
			event.stopImmediatePropagation();
			event.preventDefault();
			toggleExcel();
		}
		public function toggleExcel():void {
			
			if (excel == null) createExcel();
			else removeExcel();
		}
		private function createExcel():void {
			excel = new Excel();
			excel.horizontalCenter = 0;
			excel.verticalCenter = 0;
			excel.bFromAddress = true;
			excel.addEventListener("saveAddress", excel_saveAddressHandler);
			excel.addEventListener("close", excel_closeHandler);
			this.contentGroup.addElement(excel);
		}
		private function excel_saveAddressHandler(event:CustomEvent):void {
			SLibrary.alert(String(event.result)+" 에 저장 되었습니다.");
			getGroup();
		}
		private function excel_closeHandler(event:Event):void {
			removeExcel();
		}
		private function removeExcel():void {
			
			if (excel != null) {
				excel.removeEventListener("saveAddress", excel_saveAddressHandler);
				excel.removeEventListener("close", excel_closeHandler);
				this.contentGroup.removeElement(excel);
				excel = null;
			}
			
		}
		
		/**
		 * tooltip
		 * */
		private function tooltip_overHandler(event:FlowElementMouseEvent):void {
			
			if(!customToolTip){
				customToolTip = new CustomToolTip();
				customToolTip.x = parentApplication.mouseX - customToolTip.width/2;
				customToolTip.y = parentApplication.mouseY - 40;
				PopUpManager.addPopUp(customToolTip, this, false);
			}
			customToolTip.text =  LinkElement(event.flowElement).href;
		}
		private function tooltip_outHandler(event:FlowElementMouseEvent):void {
			
			PopUpManager.removePopUp(customToolTip);
			customToolTip = null;
		}
		
		
		public function destory():void {
			
			if (acGroup != null)
				acGroup.removeEventListener(CollectionEvent.COLLECTION_CHANGE, acGroup_changeHandler);
			
			removeEventListener(Event.ADDED_TO_STAGE, addedtostage_handler);
			removeEventListener(Event.REMOVED_FROM_STAGE, removedfromstage_handler);
			
			contentGroup = null;
			
			groupList = null;
			
			groupAddBtn = null;
			
			// name
			if (nameList != null) {
				Object(nameList.dataProvider).removeAll();
				nameList = null;
			}
			nameAddBtn = null;
			nameCount = null;
			
			
			
			// card
			nameL = null;
			phone = null;
			memo = null;
			cardBtn = null;
			
			// function
			addressFromExcel = null;
			
			excel = null;
			
			if (acGroup != null) {
				acGroup.removeAll();
				acGroup = null;
			}
			
			if (acName != null) {
				acName.removeAll();
				acName = null;
			}

			
			currentGroupName = null
			
			
			confirmAlert = null;
			customToolTip = null;

			_activeAddressVO = null;
		}
		
	}
}