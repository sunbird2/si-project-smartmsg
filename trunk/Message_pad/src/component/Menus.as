package component
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	
	import flash.events.MouseEvent;
	
	import lib.CustomEvent;
	
	import mx.core.UIComponent;
	
	import spark.components.Group;
	import spark.components.RichText;
	import spark.components.supportClasses.SkinnableComponent;
	
	[Event(name="change", type="lib.CustomEvent")]
	/* A component must identify the view states that its skin supports. 
	Use the [SkinState] metadata tag to define the view states in the component class. 
	[SkinState("normal")] */
	[SkinState("home")]
	[SkinState("send")]
	[SkinState("address")]
	[SkinState("bill")]
	[SkinState("log")]
	
	public class Menus extends SkinnableComponent
	{
		/* To declare a skin part on a component, you use the [SkinPart] metadata. 
		[SkinPart(required="true")] */
		
		[SkinPart(required="false")]public var labelHome:UIComponent;
		[SkinPart(required="true")]public var labelSend:UIComponent;
		[SkinPart(required="true")]public var labelAddress:UIComponent;
		[SkinPart(required="true")]public var labelBill:UIComponent;
		[SkinPart(required="true")]public var labelLog:UIComponent;
		
		private var _clickStat:String;
		
		public function Menus()
		{
			//TODO: implement function
			super();
		}
		
		/* Implement the getCurrentSkinState() method to set the view state of the skin class. */

		public function get clickStat():String{	return _clickStat;	}
		public function set clickStat(value:String):void {	
			_clickStat = value;	
			dispatchEvent(new CustomEvent("change",_clickStat));
			callLater(invalidateMenusState);
		}

		override protected function getCurrentSkinState():String
		{
			return clickStat;
		} 
		
		/* Implement the partAdded() method to attach event handlers to a skin part, 
		configure a skin part, or perform other actions when a skin part is added. */	
		override protected function partAdded(partName:String, instance:Object) : void
		{
			super.partAdded(partName, instance);
			
			var m:UIComponent = instance as UIComponent;
			m.addEventListener(MouseEvent.CLICK, changeState);
		}
		
		/* Implement the partRemoved() method to remove the even handlers added in partAdded() */
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
		}
		
		private function changeState(event:MouseEvent):void {
			
			if (event.currentTarget == labelHome) clickStat = "home";
			else if (event.currentTarget == labelSend) clickStat = "send";
			else if (event.currentTarget == labelAddress) clickStat = "address";
			else if (event.currentTarget == labelBill) clickStat = "bill";
			else if (event.currentTarget == labelLog) clickStat = "log";
			
			
			

		}
		
		private function invalidateMenusState():void
		{
			invalidateProperties();
			invalidateSkinState();
		}
		
	}
}