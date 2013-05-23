package component.util
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	
	import spark.components.Button;

	[SkinState("up")]
	[SkinState("over")]
	[SkinState("down")]
	[SkinState("disabled")]
	[SkinState("loading")]
	
	public class ButtonSpinner extends Button
	{
		/* To declare a skin part on a component, you use the [SkinPart] metadata. 
		[SkinPart(required="true")] */
		[SkinPart(required="true")]	public var sp:Spinner;
		
		private var _bLoading:Boolean = false;
		
		public function ButtonSpinner()
		{
			//TODO: implement function
			super();
		}
		
		/* Implement the getCurrentSkinState() method to set the view state of the skin class. */

		public function get bLoading():Boolean{	return _bLoading; }
		public function set bLoading(value:Boolean):void {
			_bLoading = value;
			super.enabled = !value;
		}

		override protected function getCurrentSkinState():String
		{
			var s:String = "down";
			if (bLoading) s =  "loading";
			else s =  super.getCurrentSkinState();
			return s;
		} 
		
		/* Implement the partAdded() method to attach event handlers to a skin part, 
		configure a skin part, or perform other actions when a skin part is added. */	
		override protected function partAdded(partName:String, instance:Object) : void
		{
			super.partAdded(partName, instance);
			if (instance == sp) {
				sp.visible = true;
				sp.start();
			}
		}
		
		/* Implement the partRemoved() method to remove the even handlers added in partAdded() */
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			if (instance == sp) {
				sp.stop();
			}
			super.partRemoved(partName, instance);
		}
		
		override public function stylesInitialized():void
		{
			super.stylesInitialized();
			setStyle("skinClass", ButtonSpinnerSkin);
		}
		
		
	}
}