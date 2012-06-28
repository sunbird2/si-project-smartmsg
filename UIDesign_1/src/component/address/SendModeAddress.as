package component.address
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import lib.AlertManager;
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
	
	import spark.components.RichText;
	import spark.components.TextInput;
	import spark.components.supportClasses.SkinnableComponent;
	
	import valueObjects.PhoneVO;
	
	
	/* A component must identify the view states that its skin supports. 
	Use the [SkinState] metadata tag to define the view states in the component class. 
	[SkinState("normal")] */
	[Event(name="sendAddress", type="lib.CustomEvent")]
	[Event(name="close", type="flash.events.Event")]
	
	public class SendModeAddress extends SkinnableComponent
	{
		/* To declare a skin part on a component, you use the [SkinPart] metadata. 
		[SkinPart(required="true")] */
		[SkinPart(required="false")]public var searchTextInput:TextInput;
		[SkinPart(required="false")]public var addressTree:Tree;
		[SkinPart(required="true")] public var close:RichText;
		
		private var xml:XMLListCollection = new XMLListCollection;
		private var pvo:PhoneVO = null;
		private var confirmAlert:AlertManager;
		
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
				addressTree.addEventListener(ListEvent.CHANGE, addressTree_changeHandler);
				
			}
			else if (instance == searchTextInput) searchTextInput.addEventListener(KeyboardEvent.KEY_UP, search_keyUpHandler);
			else if (instance == close)	close.addEventListener(MouseEvent.CLICK, close_clickHandler);
			
		}
		
		/* Implement the partRemoved() method to remove the even handlers added in partAdded() */
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
			if (instance == addressTree) {
				Object(addressTree.dataProvider).removeAll();
				addressTree.removeEventListener(ListEvent.CHANGE, addressTree_changeHandler);
				
			}
			else if (instance == searchTextInput) searchTextInput.removeEventListener(KeyboardEvent.KEY_UP, search_keyUpHandler);
			else if (instance == close)	close.removeEventListener(MouseEvent.CLICK, close_clickHandler);
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
			
			var selXML:XML = addressTree.selectedItem as XML;
			var type:String = selXML.attribute("type");
			var xmlList:XMLList = new XMLList(selXML);
			//data.attribute('type'), new XMLList(treeListData.item)
			var ac:ArrayCollection = new ArrayCollection();
			if (type == "group") {
				for each(var element:XML in xmlList.elements()) {
					
					ac.addItem( getPhoneVO(element.@phone,element.@label) )
				}
				
				confirmAlert = new AlertManager(element.@group+" 그룹 "+String(ac.length)+"명을 전송에 추가 하시겠습니까?","전송추가", 1|8, Sprite(parentApplication), ac);
				confirmAlert.addEventListener("yes",addressTree_sendGroupConfirmHandler, false, 0, true);
				
			}else if (type == "all" && searchTextInput.text == "") {
				confirmAlert = new AlertManager(element.@group+"모두를 전송에 추가 하시겠습니까?","전송추가", 1|8, Sprite(parentApplication), ac);
				confirmAlert.addEventListener("yes",addressTree_sendGroupConfirmHandler, false, 0, true);
			}
			else {
				ac.addItem( getPhoneVO(selXML.@phone,selXML.@label) )
				dispatchEvent(new CustomEvent("sendAddress", ac ) );
			}
			
			
		}
		private function addressTree_sendGroupConfirmHandler(event:CustomEvent):void {
			
			confirmAlert.removeEventListener("yes",addressTree_sendGroupConfirmHandler);
			dispatchEvent(new CustomEvent("sendAddress", event.result as ArrayCollection ) );
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
		private var timeoutID:uint;
		private var duration:Number = 1000;
		private function search_keyUpHandler(evnet:KeyboardEvent):void {
			
			clearTimeout(timeoutID);
			timeoutID = setTimeout(searchHandler,duration);	
		}
		
		protected function searchHandler():void {
			
			if (xml != null) {
				addressTree.dataProvider = xml;
				xml.refresh();
				filterDataDescriptor();
				callLater(expendTree);
			}else {
				
			}
		}
		
		private function filterDataDescriptor():void {
			// 하위노드 필터링
			var descriptor:ITreeDataDescriptor = new FilteredTreeDataDescriptor(getFilteredCollection);
			addressTree.dataDescriptor = descriptor;
		}
		
		private function getFilteredCollection(item:Object):ICollectionView {
			
			var node:XML = item as XML;
			var dp:XMLListCollection = new XMLListCollection(node.children());
			dp.filterFunction = checkString;
			dp.refresh();
			
			return dp;
		}
		
		private function checkString(item:Object):Boolean {
			
			var _searchString:String = searchTextInput.text;
			if(!_searchString) return true;
			
			var node:XML = item as XML;
			var label:String = node.@label;
			var pattern:String = ".*"+_searchString+".*";
			
			
			if ( new String(node.@label).match(pattern) || new String(node.@phone).match(pattern) ) {
				trace(node.@label + "/"+node.@phone);
				return true;
			}
			
			var children:XMLList = node.children();
			
			// 재귀호출로 하위노드 검사
			for each ( var child:XML in children ) {
				
				if (checkString(child))	return true;
			}				
			return false;
		}
		
		// 노드 모두 펼침
		private function expendTree():void {
			
			if(addressTree) {
				
				var len:int = xml.length;
				for(var i:int=0; i<len; ++i) {
					addressTree.expandChildrenOf(xml.getItemAt(i), true);
				}
			}
			//callLater(spinnerStop);
		}
		
		// 그룹 노드 펼침
		private function expendGroupTree():void {
			
			if(addressTree) {
				if (xml.length > 0)
					addressTree.expandItem(xml.getItemAt(0), true);
				
			}
			
			//callLater(spinnerStop);
		}
		private function close_clickHandler(event:MouseEvent):void {
			this.dispatchEvent(new Event("close"));
		}
		
		public function destroy(e:Event):void {
			
			addressTree.removeEventListener(ListEvent.CHANGE, addressTree_changeHandler);
			xml.removeAll();
			xml = null;
			pvo = null;
			confirmAlert = null;
		}
		
	}
}