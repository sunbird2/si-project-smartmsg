package module.url.att
{
	
	import flash.events.MouseEvent;
	
	import spark.components.Group;
	import spark.components.supportClasses.SkinnableComponent;
	
	[SkinState("normal")]
	[SkinState("active")]
	public class Image extends SkinnableComponent implements IAtt
	{
		[SkinPart(required="true")]public var ele:Group;
		[SkinPart(required="true")]public var attribute:Group;
		[SkinPart(required="true")]public var img:spark.components.Image;
		
		
		public function Image(){ 
			super(); 
			//setStyle("skinClass", ExcelAddressSkin);
		}
		
		public function getJson():String
		{
			return null;
		}
		
		public function setJson(json:String):void
		{
		}
		
		override protected function getCurrentSkinState():String
		{
			return super.getCurrentSkinState();
		} 
		
		override protected function partAdded(partName:String, instance:Object) : void {
			
			super.partAdded(partName, instance);
			
			if (instance == img) img.addEventListener(MouseEvent.CLICK, img_clickHandler );
		}
		
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
		}
		
		private function img_clickHandler(event:MouseEvent):void {
			
		}
		
	}
}