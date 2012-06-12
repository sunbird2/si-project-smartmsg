package component
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	import spark.components.Button;
	import spark.components.Image;
	import spark.components.List;
	import spark.components.RichEditableText;
	import spark.components.RichText;
	import spark.components.TextInput;
	import spark.components.supportClasses.SkinnableComponent;
	
	
	/* A component must identify the view states that its skin supports. 
	Use the [SkinState] metadata tag to define the view states in the component class. 
	[SkinState("normal")] */
	
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
		[SkinPart(required="true")]public var company:TextInput;
		[SkinPart(required="true")]public var hp:TextInput;
		[SkinPart(required="true")]public var phone:TextInput;
		[SkinPart(required="false")]public var memo:RichEditableText;
		[SkinPart(required="false")]public var cardBtn:Button;
		
		//function
		[SkinPart(required="false")]public var addressFromExcel:RichText;
		[SkinPart(required="false")]public var addressFromCopy:RichText;
		
		
		
		public function Address()
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
		}
		
		/* Implement the partRemoved() method to remove the even handlers added in partAdded() */
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
		}
		
	}
}