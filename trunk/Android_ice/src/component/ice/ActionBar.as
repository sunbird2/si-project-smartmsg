package component.ice
{
	/* For guidance on writing an ActionScript Skinnable Component please refer to the Flex documentation: 
	www.adobe.com/go/actionscriptskinnablecomponents */
	
	import component.ice.skin.ActionBar_black;
	
	import spark.components.supportClasses.SkinnableComponent;
	import spark.components.supportClasses.TextBase;
	import spark.primitives.BitmapImage;
	
	
	/* A component must identify the view states that its skin supports. 
	Use the [SkinState] metadata tag to define the view states in the component class. 
	[SkinState("normal")] */
	
	public class ActionBar extends SkinnableComponent
	{
		/* To declare a skin part on a component, you use the [SkinPart] metadata. 
		[SkinPart(required="true")] */
		[SkinPart(required="false")] public var icon:BitmapImage;
		[SkinPart(required="false")] public var title_text:TextBase;
		[SkinPart(required="false")] public var titleSub_text:TextBase;
		[SkinPart(required="false")] public var back:BitmapImage;
		
		
		private var _iconSource:String;
		public function get iconSource():String { return _iconSource; }
		public function set iconSource(value:String):void { _iconSource = value; }
		
		private var _title:String;
		public function get title():String { return _title; }
		public function set title(value:String):void { _title = value; }
		
		private var _titleSub:String;
		public function get titleSub():String { return _titleSub; }
		public function set titleSub(value:String):void { _titleSub = value; }
		
		private var _backEnable:Boolean = true;;
		public function get backEnable():Boolean{ return _backEnable; }
		public function set backEnable(value:Boolean):void { _backEnable = value; }
		
		public function ActionBar()
		{
			super();
			setStyle("skinClass", ActionBar_black);
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
			if (instance == icon) icon.source = iconSource;
			else if (instance == title_text) title_text.text = title ;
			else if (instance == titleSub_text) titleSub_text.text = titleSub ;
			else if (instance == back) {
				if (backEnable) back.visible = true;
				else back.visible = false;
			}
		}
		
		/* Implement the partRemoved() method to remove the even handlers added in partAdded() */
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
		}
		
	}
}