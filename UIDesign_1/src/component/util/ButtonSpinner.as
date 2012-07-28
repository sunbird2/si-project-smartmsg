package component.util
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	
	import spark.components.Button;
	
	
	/* A component must identify the view states that its skin supports. 
	Use the [SkinState] metadata tag to define the view states in the component class. 
	[SkinState("normal")] */
	
	public class ButtonSpinner extends Button
	{
		/* To declare a skin part on a component, you use the [SkinPart] metadata. 
		[SkinPart(required="true")] */
		
		private var _bLoading:Boolean = false;
		private var spinner:Spinner = null;
		
		public function ButtonSpinner()
		{
			//TODO: implement function
			super();
		}
		
		/* Implement the getCurrentSkinState() method to set the view state of the skin class. */

		public function get bLoading():Boolean{	return _bLoading; }
		public function set bLoading(value:Boolean):void {
			_bLoading = value;
			super.enabled = value;
			if (!super.enabled) createSpinner();
			else removeSpinner();
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
		}
		
		/* Implement the partRemoved() method to remove the even handlers added in partAdded() */
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
		}
		
		private function createSpinner():void {
			
			spinner = new Spinner;
			spinner.delay = 100;
			spinner.startImmediately = true;
			spinner.verticalCenter = 0;
			spinner.horizontalCenter = 0;
			this.addChild( spinner );
		}
		
		private function removeSpinner():void {
			
			this.removeChild(spinner);
			spinner = null;
		}
		
		
		
	}
}