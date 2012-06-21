package component
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	import flash.events.MouseEvent;
	
	import lib.CustomEvent;
	import lib.Gv;
	import lib.RemoteSingleManager;
	import lib.SLibrary;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.Button;
	import spark.components.Image;
	import spark.components.List;
	import spark.components.RichEditableText;
	import spark.components.RichText;
	import spark.components.TextInput;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.IndexChangeEvent;
	
	import valueObjects.AddressVO;
	
	
	/* A component must identify the view states that its skin supports. 
	Use the [SkinState] metadata tag to define the view states in the component class. 
	[SkinState("normal")] */
	[SkinState("group")]
	[SkinState("nameCard")]
	
	public class Address extends SkinnableComponent
	{
		/* To declare a skin part on a component, you use the [SkinPart] metadata. 
		[SkinPart(required="true")] */
		
		// group
		[SkinPart(required="false")]public var groupList:List;
		[SkinPart(required="false")]public var groupAddInput:TextInput;
		[SkinPart(required="false")]public var groupAddBtn:Button;
		
		// name
		[SkinPart(required="false")]public var nameList:List;
		
		// card
		[SkinPart(required="false")]public var photo:Image;
		[SkinPart(required="true")]public var nameL:TextInput;
		[SkinPart(required="true")]public var phone:TextInput;
		[SkinPart(required="false")]public var memo:RichEditableText;
		[SkinPart(required="false")]public var cardBtn:Button;
		
		//function
		[SkinPart(required="false")]public var addressFromExcel:RichText;
		[SkinPart(required="false")]public var addressFromCopy:RichText;
		
		
		private var acGroup:ArrayCollection = new ArrayCollection();
		private var acName:ArrayCollection = new ArrayCollection();
		
		private var card:AddressVO = new AddressVO();
		
		private var currentGroupName:String = "";
		
		private var currentStat:String = "group";
		
		public function Address() {
			super();
			getGroup();
		}
		
		/* Implement the getCurrentSkinState() method to set the view state of the skin class. */
		override protected function getCurrentSkinState():String
		{
			return currentStat;
		} 
		
		/* Implement the partAdded() method to attach event handlers to a skin part, 
		configure a skin part, or perform other actions when a skin part is added. */	
		override protected function partAdded(partName:String, instance:Object) : void
		{
			super.partAdded(partName, instance);
			if (instance == groupList) {
				groupList.dataProvider = acGroup;
				groupList.addEventListener(IndexChangeEvent.CHANGE, groupList_changeHandler);
			}
			else if (instance == nameList) {
				nameList.dataProvider = acName;
				nameList.addEventListener(IndexChangeEvent.CHANGE, nameList_changeHandler);
			}
			else if (instance == groupAddBtn) groupAddBtn.addEventListener(MouseEvent.CLICK, groupAddBtn_clickHandler);
			else if (instance == cardBtn) cardBtn.addEventListener(MouseEvent.CLICK, cardBtn_clickHandler);

		}
		
		/* Implement the partRemoved() method to remove the even handlers added in partAdded() */
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
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
		}
		private function allAddressGroupVO():AddressVO {
			
			var avo:AddressVO = new AddressVO();
			avo.grpName = "전체";
			avo.idx = 0;
			
			return avo;
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
			
			if (data != null && data.length > 0) {
				acName.removeAll();
				acName.addAll(data);
				callLater(viewCard, [card]);
			}else {
				callLater(viewCard, [new AddressVO()]);
			}
			currentStat = "nameCard";
			invalidateSkinState();
			
		}
		private function viewCard(avo:AddressVO):void {
			
			card = avo;
			
			nameL.text = avo.name;
			phone.text = avo.phone;
			memo.text = avo.memo;
		}
		private function cardBtn_clickHandler(event:MouseEvent):void {
			
			getCard();
			
			
			if (card.idx == 0) {// insert
				if (currentGroupName == "") SLibrary.alert("그룹 선택 후 저장하세요.");
				else {
					RemoteSingleManager.getInstance.addEventListener("modifyAddr", cardBtn_resultHandler, false, 0, true);
					RemoteSingleManager.getInstance.callresponderToken
						= RemoteSingleManager.getInstance.service.modifyAddr(20, card); 
				}
						
			}else {// update
				RemoteSingleManager.getInstance.addEventListener("modifyAddr", cardBtn_resultHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.modifyAddr(21, card);	
			}
				
		}
		private function getCard():void {
			
			card.grp = 1;
			card.grpName = currentGroupName;
			card.name = nameL.text;
			card.phone = phone.text;
			card.memo = memo.text;
		}
		private function setCard(avo:AddressVO):void {
			
			card = avo;
			nameL.text = card.name;
			phone.text = card.phone;
			memo.text = card.memo;
		}
		private function cardBtn_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("modifyAddr", cardBtn_resultHandler);
			
			var i:int = event.result as int;
			if (i > 0) getNameList();
			else SLibrary.alert("적용 되지 않았습니다.");
		}
		
		private function nameList_changeHandler(event:IndexChangeEvent):void {
			
			var vo:AddressVO = acName.getItemAt(event.newIndex) as AddressVO;
			if (vo != null) {
				setCard(vo);
			}
		}
		
		
		/**
		 * add Group
		 * */
		private function groupAddBtn_clickHandler(event:MouseEvent):void {
			
			if (groupAddInput.text == "") {
				SLibrary.alert("그룹이름을 입력하세요.")
			}else {
				var avo:AddressVO = new AddressVO();
				avo.user_id = Gv.user_id;
				avo.grpName = groupAddInput.text;
				
				RemoteSingleManager.getInstance.addEventListener("modifyAddr", groupAddBtn_changHandler, false, 0, true);
				RemoteSingleManager.getInstance.callresponderToken 
					= RemoteSingleManager.getInstance.service.modifyAddr(10, avo);	
			}
			
		}
		private function groupAddBtn_changHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("modifyAddr", groupAddBtn_changHandler);
			var i:int = event.result as int;
			if (i > 0) getGroup();
			else SLibrary.alert("적용 되지 않았습니다.");
		}
		
	}
}