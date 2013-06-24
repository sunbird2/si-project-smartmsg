package component
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	import component.excel.Excel;
	import component.util.CustomToolTip;
	import component.util.ListCheckAble;
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
	import lib.IconItemRenderer_sendAddress;
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
	import skin.AddressSkin_mini;
	import skin.address.GroupRenderer;
	
	import spark.components.Button;
	import spark.components.ComboBox;
	import spark.components.Group;
	import spark.components.IconPlacement;
	import spark.components.Image;
	import spark.components.List;
	import spark.components.RichText;
	import spark.components.TextArea;
	import spark.components.TextInput;
	import spark.components.VGroup;
	import spark.components.supportClasses.Skin;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.IndexChangeEvent;
	import spark.layouts.VerticalLayout;
	import spark.layouts.supportClasses.DropLocation;
	
	import valueObjects.AddressVO;
	import valueObjects.PhoneVO;
	
	
	/* A component must identify the view states that its skin supports. 
	Use the [SkinState] metadata tag to define the view states in the component class. 
	[SkinState("normal")] */
	[Event(name="sendAddress", type="lib.CustomEvent")]
	[Event(name="close", type="flash.events.Event")]
	
	
	public class Address extends SkinnableComponent
	{
		/* To declare a skin part on a component, you use the [SkinPart] metadata. 
		[SkinPart(required="true")] */
		
		
		[SkinPart(required="true")]public var contentGroup:Group;
		[SkinPart(required="false")]public var search:TextInputSearch;
		
		// group
		[SkinPart(required="false")]public var groupList:List;
		[SkinPart(required="false")]public var groupAddBtn:Image;
		[SkinPart(required="false")]public var groupModifyBtn:Image;
		[SkinPart(required="false")]public var groupDelBtn:Image;
		
		// name
		[SkinPart(required="false")]public var nameList:ListCheckAble;
		[SkinPart(required="false")]public var nameMultSelectBtn:Image;
		[SkinPart(required="false")]public var nameAddBtn:Image;
		[SkinPart(required="false")]public var nameDelBtn:Image;
		[SkinPart(required="false")]public var nameCount:SpanElement;
		[SkinPart(required="false")]public var selectSend:Image;
		
		
		
		
		
		// card
		[SkinPart(required="false")]public var cardGroup:VGroup;
		[SkinPart(required="false")]public var groupName:ComboBox;
		[SkinPart(required="false")]public var nameL:TextInput;
		[SkinPart(required="false")]public var phone:TextInput;
		[SkinPart(required="false")]public var memo:TextArea;
		[SkinPart(required="false")]public var cardAddBtn:Image;
		[SkinPart(required="false")]public var cardBtn:Image;
		[SkinPart(required="false")]public var commitBtn:Button;
		
		
		
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
		
		private var bMini:Boolean = false;
		
		public function Address(parbMine:Boolean=false) {
			super();
			
			if (parbMine == true) {
				bMini = true;
				setStyle("skinClass", AddressSkin_mini);
			}
			else setStyle("skinClass", AddressSkin);
			
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
							&& AddressVO(event.items[i]).idx != 0 && bGetGroup == false) {  
							
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
				//nameList.allowMultipleSelection = true;
				
				var irFactory:ClassFactory = null;
				if (bMini == true) {
					irFactory = new ClassFactory(IconItemRenderer_sendAddress);
				}else
					irFactory = new ClassFactory(IconItemRenderer);
				
				irFactory.properties = {
					icon:"/skin/ics/assets/light/icon/6-social-person.png",
					labelTitle:"name",
					labelSub:"phone"};
				nameList.itemRenderer = irFactory;
				
				//nameList.labelFunction = nameLabelFunction;
				nameList.addEventListener(IndexChangeEvent.CHANGE, nameList_changeHandler);
				nameList.addEventListener(KeyboardEvent.KEY_UP, namepList_keyUpHandler);
			}
			else if (instance == groupAddBtn) groupAddBtn.addEventListener(MouseEvent.CLICK, groupAddBtn_clickHandler);
			else if (instance == groupModifyBtn) groupModifyBtn.addEventListener(MouseEvent.CLICK, groupModifyBtn_clickHandler);
			else if (instance == groupDelBtn) groupDelBtn.addEventListener(MouseEvent.CLICK, groupDelBtn_clickHandler);
			
			else if (instance == nameMultSelectBtn) nameMultSelectBtn.addEventListener(MouseEvent.CLICK, nameMultSelectBtn_clickHandler);
			else if (instance == nameAddBtn) nameAddBtn.addEventListener(MouseEvent.CLICK, cardAddBtn_clickHandler);
			else if (instance == nameDelBtn) nameDelBtn.addEventListener(MouseEvent.CLICK, nameDelBtn_clickHandler);
			else if (instance == cardAddBtn) cardAddBtn.addEventListener(MouseEvent.CLICK, cardAddBtn_clickHandler);
			else if (instance == addressFromExcel) addressFromExcel.addEventListener(MouseEvent.CLICK, addressFromExcel_clickHandler);
			else if (instance == search) search.addEventListener("search" , search_clickHandler);
			else if (instance == groupName) {
				groupName.dataProvider = acGroup;
				groupName.labelField = "grpName";
			}
			else if (instance == cardGroup) cardGroup.visible = false;
			else if (instance == commitBtn) commitBtn.addEventListener(MouseEvent.CLICK, commitBtn_clickHandler);
			else if (instance == selectSend) selectSend.addEventListener(MouseEvent.CLICK, selectSend_clickHandler);
			
			
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
			else if (instance == groupModifyBtn) groupModifyBtn.removeEventListener(MouseEvent.CLICK, groupModifyBtn_clickHandler);
			else if (instance == groupDelBtn) groupDelBtn.removeEventListener(MouseEvent.CLICK, groupDelBtn_clickHandler);
				
			else if (instance == nameMultSelectBtn) nameMultSelectBtn.removeEventListener(MouseEvent.CLICK, nameMultSelectBtn_clickHandler);
			else if (instance == nameAddBtn) nameAddBtn.removeEventListener(MouseEvent.CLICK, cardAddBtn_clickHandler);
			else if (instance == nameDelBtn) nameDelBtn.removeEventListener(MouseEvent.CLICK, nameDelBtn_clickHandler);
			else if (instance == cardAddBtn) cardAddBtn.removeEventListener(MouseEvent.CLICK, cardAddBtn_clickHandler);
			else if (instance == addressFromExcel) addressFromExcel.removeEventListener(MouseEvent.CLICK, addressFromExcel_clickHandler);
			else if (instance == search) search.removeEventListener("search" , search_clickHandler);
			else if (instance == commitBtn) commitBtn.removeEventListener(MouseEvent.CLICK, commitBtn_clickHandler); 
			
			if (instance is LinkElement) {
				instance.removeEventListener(FlowElementMouseEvent.ROLL_OVER, tooltip_overHandler);
				instance.removeEventListener(FlowElementMouseEvent.ROLL_OUT, tooltip_outHandler);
			}
			
			
		}
		
		private function tracker(msg:String):void {
			MunjaNote(parentApplication).googleTracker("Address/"+msg);
		}
		
		// mini to send
		public function addSend(type:String, avo:AddressVO):void {
			
			if (type == "group") {
				
				getListAndSendPhone(avo.grpName);
				tracker("addSend/group");// tracker
			}
			else {
				if (avo != null) {
					var ac:ArrayCollection = new ArrayCollection();
					ac.addItem( getPhoneVO(avo.phone, avo.name) )
					dispatchEvent(new CustomEvent("sendAddress", ac ) );
				}
				tracker("addSend");// tracker
			}
		}
		private function getListAndSendPhone(grpName:String):void {
			RemoteSingleManager.getInstance.addEventListener("getAddrList", getListAndSendPhone_resultHandler, false, 0, true);
			RemoteSingleManager.getInstance.callresponderToken 
				= RemoteSingleManager.getInstance.service.getAddrList(1, currentGroupName);
		}
		private function getListAndSendPhone_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("getAddrList", getListAndSendPhone_resultHandler);
			
			var data:ArrayCollection = event.result as ArrayCollection;
			
			if (data != null) {
				dispatchEvent(new CustomEvent("sendAddress", parsePhoneVO(data) ) );
			}
			tracker("getListAndSendPhone_resultHandler");// tracker
			
		}
		
		private function parsePhoneVO(ac:ArrayCollection):ArrayCollection {
			
			var rslt:ArrayCollection = new ArrayCollection();
			if (ac != null) {
				var cnt:int = ac.length;
				var avo:AddressVO = null;
				for (var i:int = 0; i < cnt; i++) {
					avo = ac.getItemAt(i) as AddressVO;
					rslt.addItem( getPhoneVO(avo.phone, avo.name) );
				}
			}
			
			return rslt;
		}
		
		private function getPhoneVO(pno:String, pname:String):PhoneVO {
			var pvo:PhoneVO = new PhoneVO();
			pvo.pNo = pno;
			pvo.pName = pname;
			return pvo;
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
				tracker("search_clickHandler");// tracker
				
			}
		}
		
		private var bGetGroup:Boolean = false;
		/**
		 * group list
		 * */
		private function getGroup():void {
			
			if (Gv.bLogin) {
				bGetGroup = true;
				RemoteSingleManager.getInstance.addEventListener("getAddrList", getGroup_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.getAddrList(0, "");
			}
			tracker("getGroup");// tracker
		}
		private function getGroup_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("getAddrList", getGroup_resultHandler);
			var data:ArrayCollection = event.result as ArrayCollection;
			acGroup.removeAll();
			// allGroup add
			acGroup.addItem( allAddressGroupVO() );
			acGroup.addAll(data);
			bGetGroup = false;
			setGvGroup();
		}
		private function groupList_keyUpHandler(event:KeyboardEvent):void {
			
			if (event.keyCode == 46
				&& AddressVO(groupList.selectedItem).grpName != "모두") {
				delGroup();
				
			}
				
		}
		private function delGroup():void {
			confirmAlert = new AlertManager("["+AddressVO(groupList.selectedItem).grpName+"] 그룹의 전화번호도 모두 삭제 됩니다.\n 삭제 하시겠습니까?","그룹삭제", 1|8, Sprite(parentApplication), groupList.selectedIndex);
			confirmAlert.addEventListener("yes",deleteGroup_confirmHandler, false, 0, true);
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
			tracker("deleteGroup_confirmHandler");// tracker
		}
		
		/**
		 * group list click
		 * */
		private function groupList_changeHandler(event:IndexChangeEvent):void {
			
			var vo:AddressVO = acGroup.getItemAt(groupList.selectedIndex) as AddressVO;
			if (vo != null) {
				var gName:String = (vo.idx == 0)? "":vo.grpName;
				currentGroupName = gName;
				getNameList();
			}
			tracker("groupList_changeHandler");// tracker
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
			
		}
		
		private function nameLabelFunction(item:Object):String {
			
			var avo:AddressVO = item as AddressVO;
			return (avo.name != "") ? avo.name : avo.phone;
		}
		
		private function commitBtn_clickHandler(event:MouseEvent):void {
			
			setCard();
			activeCommit();
		}
		
		
		private function activeCommit():void {
			
			if (groupName.selectedIndex < 0) { // group insert and cart insert
				activeAddress(23, activeAddressVO);
			}
			else if (activeAddressVO.idx == 0) {// insert
				activeAddress(20, activeAddressVO);
			}
			else {// update
				activeAddress(21, activeAddressVO);
			}
		}
		private function setCard():void {
			
			var idx:int = 0;
			if (nameList.selectedIndex >= 0) {
				
				var avo:AddressVO = AddressVO( acName.getItemAt( nameList.selectedIndex ) );
				idx = avo.idx;
				/*avo.grp = 1;
				avo.grpName = AddressVO(groupName.selectedItem).grpName;
				avo.name = nameL.text;
				avo.phone = phone.text;
				avo.memo = memo.text;*/
			}
			
			activeAddressVO = new AddressVO(); 
			activeAddressVO.idx = idx;
			activeAddressVO.grp = 1;
			if (groupName.selectedItem is AddressVO)
				activeAddressVO.grpName = AddressVO(groupName.selectedItem).grpName;
			else 
				activeAddressVO.grpName = groupName.selectedItem;
			activeAddressVO.name = nameL.text;
			activeAddressVO.phone = phone.text;
			activeAddressVO.memo = memo.text;
			
		}
		private function viewCard():void {
			if (cardGroup) {
				if (nameList.selectedIndex >= 0) {
					var avo:AddressVO = AddressVO( acName.getItemAt( nameList.selectedIndex ) );
					
					if (avo.grpName) groupName.selectedItem = avo;
					nameL.text = avo.name;
					phone.text = avo.phone;
					memo.text = avo.memo;
					
					if (cardGroup)
						cardGroup.visible = true;
				}
				else {
					if (cardGroup)
						cardGroup.visible = false;
				}
			}
			
		}
		private function viewCreatCard():void {
			
			cardGroup.visible = true;
			if (groupList.selectedIndex > 0) {
				var avo:AddressVO = AddressVO( acGroup.getItemAt( groupList.selectedIndex ) );
				if (avo.grpName) groupName.selectedItem = avo;
			}
			else
				groupName.selectedIndex = -1;
			
			nameL.text = "";
			phone.text = "";
			memo.text = "";
			nameList.selectedIndex = -1;
		}
		
		private function nameList_changeHandler(event:IndexChangeEvent):void {
			viewCard();
		}
		
		private function namepList_keyUpHandler(event:KeyboardEvent):void {
			
			if (event.keyCode == 46) {
				nameListDel();
			}
			
		}
		private function nameListDel():void {
			
			var cnt:int = nameList.selectedItems.length;
			if (nameList.selectedItems) {
				confirmAlert = new AlertManager("선택된 "+String(nameList.selectedItems.length)+"건의 전화번호를 삭제 하시겠습니까?","전화번호삭제", 1|8, Sprite(parentApplication), nameList.selectedIndex);
				confirmAlert.addEventListener("yes",deleteName_confirmHandler, false, 0, true);
			}
			
		}
		private function deleteName_confirmHandler(event:CustomEvent):void {
			
			confirmAlert.removeEventListener("yes",deleteName_confirmHandler);
			confirmAlert = null;
			
			var act:Vector.<Object> = nameList.selectedItems;
			var cnt:int = act.length;
			var ac:ArrayCollection = new ArrayCollection();
			var i:int = 0;
			for(i = 0; i < cnt; i++) {
				ac.addItem( AddressVO( nameList.selectedItems[i] ) );
			}
			
			if (ac.length == 0) {
				SLibrary.alert("선택된 전화번호가 없습니다.");
			}else {
				
				RemoteSingleManager.getInstance.addEventListener("modifyManyAddr", deleteName_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.modifyManyAddr(33, ac, "");	
			}
			
			for( i = 0; i < cnt; i++) {
				acName.removeItemAt( acName.getItemIndex( act[i] as AddressVO ) );
			}
			nameCount.text = String(acName.length);
			viewCard();
			
		}
		private function deleteName_resultHandler(event:CustomEvent):void {
			
			SLibrary.alert( String(event.result) +"건의 전화번호가 삭제 되었습니다." );
			tracker("deleteName_resultHandler");// tracker
		}
		
		private function selectSend_clickHandler(event:MouseEvent):void {
			
			var act:Vector.<Object> = nameList.selectedItems;
			var cnt:int = act.length;
			var ac:ArrayCollection = new ArrayCollection();
			var i:int = 0;
			for(i = 0; i < cnt; i++) {
				ac.addItem( AddressVO( nameList.selectedItems[i] ) );
			}
			
			if (ac.length == 0) {
				SLibrary.alert("선택된 전화번호가 없습니다.");
			}else {
				dispatchEvent(new CustomEvent("sendAddress", parsePhoneVO(ac) ) );
			}
			tracker("selectSend_clickHandler");// tracker
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
			tracker("groupAddBtn_clickHandler");// tracker
		}
		
		/**
		 * insert or update group
		 * */
		private function activeAddress(code:Number, avo:AddressVO):void {
			
			if (avo.grpName == null || avo.grpName == "") {
				SLibrary.alert("그룹이름이 없습니다.");
			} 
			else if (code >= 20 && (avo.phone == "" || avo.phone == null )){
				SLibrary.alert("전화번호를 입력 하세요.");
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
				case 21: {
					
					activeAddressVO.idx = i;
					groupList.selectedIndex = getGroupSelectedIndex(activeAddressVO.grpName);
					
					groupList.dispatchEvent( new IndexChangeEvent(IndexChangeEvent.CHANGE) );
					break;
				}
				case 23: {
					getGroup();
				}
				default: { break; }
			}
			
			setGvGroup();
		}
		
		private function getGroupSelectedIndex(grp:String):int {
			
			var cnt:int = acGroup.length;
			var i:int = 0;
			for ( i = 0; i < cnt; i++) {
				if (AddressVO(acGroup.getItemAt(i)).grpName == grp) break;
			}
			return i;
		}
		
		private function groupModifyBtn_clickHandler(event:MouseEvent):void {
			
			var idx:int = groupList.selectedIndex;
			if (idx < 0 ) SLibrary.alert("그룹을 선택 하세요.");
			else if (idx == 0) SLibrary.alert("모두는 수정 할 수 없습니다.");
			else {
				var obj:GroupRenderer = groupList.dataGroup.getElementAt(idx) as GroupRenderer;
				obj.onEdit(null); 
			}
			
			
		}
		private function groupDelBtn_clickHandler(event:MouseEvent):void {
			
			var idx:int = groupList.selectedIndex;
			if (idx < 0 ) SLibrary.alert("그룹을 선택 하세요.");
			else {
				delGroup();
			}
		}
		
		
		/**
		 * name method
		 * */
		private function nameMultSelectBtn_clickHandler(event:MouseEvent):void {
			
			if (nameList.allowMultipleSelection) {
				nameList.allowMultipleSelection = false;
				nameMultSelectBtn.alpha = 0.4;
			}else {
				nameList.allowMultipleSelection = true;
				nameMultSelectBtn.alpha = 1;
				SLibrary.alert("여러개의 전화번호를 선택 하실 수 있습니다.");
			}
		}
		
		private function nameDelBtn_clickHandler(event:MouseEvent):void {
			
			nameListDel();
		}
		
		private function editeSelect():void {
			nameList.selectedIndex = 0;
			nameList.dispatchEvent( new IndexChangeEvent(IndexChangeEvent.CHANGE) );
			
		}
		
		private function cardAddBtn_clickHandler(event:MouseEvent):void {
			
			viewCreatCard();
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
			excel = new Excel(true);
			excel.horizontalCenter = 0;
			excel.top = 48;
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