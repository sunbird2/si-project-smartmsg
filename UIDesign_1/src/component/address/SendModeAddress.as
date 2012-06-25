package component.address
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import lib.CustomEvent;
	import lib.FilteredTreeDataDescriptor;
	import lib.RemoteSingleManager;
	import lib.SLibrary;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;
	import mx.collections.XMLListCollection;
	import mx.controls.Tree;
	import mx.controls.treeClasses.ITreeDataDescriptor;
	import mx.events.ListEvent;
	import mx.rpc.events.ResultEvent;
	
	import skin.excel.SendModeAddressSkin;
	
	import spark.components.TextInput;
	import spark.components.supportClasses.SkinnableComponent;
	
	import valueObjects.PhoneVO;
	
	
	/* A component must identify the view states that its skin supports. 
	Use the [SkinState] metadata tag to define the view states in the component class. 
	[SkinState("normal")] */
	[Event(name="sendAddress", type="lib.CustomEvent")]
	
	public class SendModeAddress extends SkinnableComponent
	{
		/* To declare a skin part on a component, you use the [SkinPart] metadata. 
		[SkinPart(required="true")] */
		[SkinPart(required="false")]public var searchTextInput:TextInput;
		[SkinPart(required="false")]public var addressTree:Tree;
		
		private var xml:XMLListCollection = new XMLListCollection;
		private var pvo:PhoneVO = null;
		
		
		public function SendModeAddress()
		{
			super();
			setStyle("skinClass", SendModeAddressSkin);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy, false, 0, true);
			
			getAddress();
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
			if (instance == addressTree) {
				addressTree.dataProvider = xml;
				addressTree.labelField = "@label";
				addressTree.dataDescriptor = new FilteredTreeDataDescriptor(filterFunc);
				addressTree.addEventListener(ListEvent.CHANGE, addressTree_changeHandler);
				
			}
			else if (instance == searchTextInput) searchTextInput.addEventListener(KeyboardEvent.KEY_UP, searchTextInput_changeHandler);
			
		}
		
		/* Implement the partRemoved() method to remove the even handlers added in partAdded() */
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
		}
		
		private function getAddress():void {
			
			RemoteSingleManager.getInstance.addEventListener("getAddrTree", getAddrList_resultHandler, false, 0, true);
			RemoteSingleManager.getInstance.callresponderToken 
				= RemoteSingleManager.getInstance.service.getAddrTree();
		}
		private function getAddrList_resultHandler(event:CustomEvent):void {
			
			RemoteSingleManager.getInstance.removeEventListener("getAddrTree", getAddrList_resultHandler);
			
			var xlData:XMLList = new XMLList(event.result);
			
			if(xlData.elements("msg").toString()!="ok") {
				SLibrary.alert(xlData.elements("msg").toString());
			}
			else {
				xml.removeAll();
				xml.addAll(new XMLListCollection(xlData.elements("addrs")));
			}
		}
		private function addressTree_changeHandler(event:ListEvent):void {
			
			var phone:String = "";
			var selXML:XML = addressTree.selectedItem as XML;
			var type:String = selXML.attribute("type");
			var xmlList:XMLList = new XMLList(selXML);
			//data.attribute('type'), new XMLList(treeListData.item)
			var ac:ArrayCollection = new ArrayCollection();
			if (type == "group") {
				for each(var element:XML in xmlList.elements()) {
					
					ac.addItem( getPhoneVO(element.@phone,element.@label) )
				}
			}else {
				ac.addItem( getPhoneVO(selXML.@phone,selXML.@label) )
			}
			
			phone = phone.substr(0, phone.length -1);
			dispatchEvent(new CustomEvent("sendAddress", ac ) );
			
		}
		private function getPhoneVO(pno:String, pname:String):PhoneVO {
			pvo = new PhoneVO();
			pvo.pNo = pno;
			pvo.pName = pname;
			return pvo;
		}
		
		/**
		 * filter
		 * */
		private function searchTextInput_changeHandler(event:KeyboardEvent):void {
			
			/*if (addressTree != null) {
				(addressTree.dataDescriptor as TreeDescriptor).filter = searchTextInput.text;
				
			}*/
			addressTree.invalidateList();
			
		}
		
		private function filterFunc(node:Object):ICollectionView
		{
			return new XMLListCollection(node.addr.( @label.match(new RegExp("^" + searchTextInput.text, "i")) || @phone.match(new RegExp("^" + searchTextInput.text, "i"))  ));
		}
		
		public function destroy():void {
			
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy, false);
		}
		
	}
}