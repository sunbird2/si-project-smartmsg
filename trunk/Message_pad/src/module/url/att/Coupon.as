package module.url.att
{
	import flash.events.KeyboardEvent;
	
	import module.url.att.skin.BtnSkin;
	import module.url.att.skin.CouponSkin;
	
	import mx.collections.ArrayCollection;
	import mx.controls.RichTextEditor;
	
	import spark.components.Button;
	import spark.components.DropDownList;
	import spark.components.Group;
	import spark.components.TextInput;
	import spark.components.supportClasses.SkinnableComponent;
	
	[SkinState("default")]
	[SkinState("view")]
	[SkinState("actEmpty")]
	[SkinState("actContent")]
	public class Coupon extends SkinnableComponent implements IAtt
	{
		[SkinPart(required="true")]public var ele:Group;
		[SkinPart(required="true")]public var attribute:Group;
		
		private var _att:Object;
		public function set att(val:Object):void { _att = val; }
		public function get att():Object { return _att; }
		
		private var _stat:String = "default";
		public function get state():String { return _stat; }
		public function set state(value:String):void {
			_stat = value;
			invalidateSkinState();
		}
		
		public function Coupon(val:Object){ 
			super(); 
			init();
			setStyle("skinClass", CouponSkin);
		}
		private function init():void {
			if (att != null) {
				
			}
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
			if (att != null && _stat == "actEmpty") _stat = "actContent";
			else if (att != null && _stat == "default") {
				_stat = "view";
			}
			return this._stat;
		} 
		
		override protected function partAdded(partName:String, instance:Object) : void
		{
			super.partAdded(partName, instance);
			
		}
		
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
		}
		
	}
}