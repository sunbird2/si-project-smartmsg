package component.util
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	
	import flash.events.MouseEvent;
	
	import lib.CustomEvent;
	
	import skin.compnent.TextInputSearchSkin;
	
	import spark.components.Group;
	import spark.components.TextInput;
	
	
	/* A component must identify the view states that its skin supports. 
	Use the [SkinState] metadata tag to define the view states in the component class. 
	[SkinState("normal")] */
	[Event(name="search", type="lib.CustomEvent")]
	
	public class TextInputSearch extends TextInput
	{
		/* To declare a skin part on a component, you use the [SkinPart] metadata. 
		[SkinPart(required="true")] */
		[SkinPart(required="true")] public var search:Group;
		
		public function TextInputSearch()
		{
			//TODO: implement function
			super();
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
			if (instance == search) search.addEventListener( MouseEvent.CLICK, dispatchSearchEvent );
			
		}
		
		/* Implement the partRemoved() method to remove the even handlers added in partAdded() */
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			if (instance == search) search.removeEventListener( MouseEvent.CLICK, dispatchSearchEvent );
			super.partRemoved(partName, instance);
		}
		
		override public function stylesInitialized():void {
			setStyle("skinClass", TextInputSearchSkin);
		}
		
		private function dispatchSearchEvent(event:MouseEvent):void
		{
			this.dispatchEvent(new CustomEvent("search", this.text));
		}
		
	}
}