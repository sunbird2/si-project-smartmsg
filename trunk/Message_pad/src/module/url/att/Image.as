package module.url.att
{
	
	import flash.events.MouseEvent;
	
	import module.url.att.skin.ImageSkin;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.Group;
	import spark.components.List;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.primitives.BitmapImage;
	
	[SkinState("default")]
	[SkinState("view")]
	[SkinState("actEmpty")]
	[SkinState("actContent")]
	public class Image extends SkinnableComponent implements IAtt
	{
		[SkinPart(required="true")]public var ele:Group;
		[SkinPart(required="true")]public var attribute:Group;
		[SkinPart(required="true")]public var imgList:List;
		
		private var _att:Object;
		public function set att(val:Object):void { _att = val; }
		public function get att():Object { return _att; }
		
		private var _stat:String = "default";
		public function get state():String { return _stat; }
		public function set state(value:String):void {
			
			_stat = value;
			invalidateSkinState();
		}
		override protected function getCurrentSkinState():String {
			if (att != null && _stat == "actEmpty") _stat = "actContent";
			else if (att != null && _stat == "default") _stat = "view";
			
			trace(_stat);
			return this._stat;
		} 
		
		public function Image(val:Object){ 
			super(); 
			att = val;
			setStyle("skinClass", ImageSkin);
		}

		override protected function partAdded(partName:String, instance:Object) : void {
			
			super.partAdded(partName, instance);
			
			if (instance == imgList) {
				if (att != null) { imgList.dataProvider = new ArrayCollection( att.imgs ); }
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