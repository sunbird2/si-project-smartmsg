package module.url.att
{
	
	import flash.events.MouseEvent;
	
	import module.url.att.skin.ImageSkin;
	
	import spark.components.Group;
	import spark.components.supportClasses.SkinnableComponent;
	
	[SkinState("normal")]
	[SkinState("active")]
	public class Image extends SkinnableComponent implements IAtt
	{
		[SkinPart(required="true")]public var ele:Group;
		[SkinPart(required="true")]public var attribute:Group;
		[SkinPart(required="true")]public var img:spark.components.Image;
		
		private var _att:Object;
		public function set att(val:Object):void { _att = val; }
		public function get att():Object { return _att; }
		
		private var _stat:String = "normal";
		public function get state():String { return _stat; }
		public function set state(value:String):void {
			_stat = value;
			invalidateSkinState();
		}
		override protected function getCurrentSkinState():String { return this._stat; } 
		
		public function Image(val:Object){ 
			super(); 
			att = val;
			setStyle("skinClass", ImageSkin);
		}
		
		
		
		
		override protected function partAdded(partName:String, instance:Object) : void {
			
			super.partAdded(partName, instance);
			
			if (instance == img) {
				img.source = att.url;
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
		}
		
		private function img_clickHandler(event:MouseEvent):void {
			
		}
		
	}
}