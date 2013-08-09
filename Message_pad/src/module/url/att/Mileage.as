package module.url.att
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import module.url.att.skin.MileageSkin;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.Button;
	import spark.components.DropDownList;
	import spark.components.Group;
	import spark.components.List;
	import spark.components.NumericStepper;
	import spark.components.TextInput;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.layouts.TileLayout;
	import spark.layouts.supportClasses.LayoutBase;
	
	[SkinState("default")]
	[SkinState("view")]
	[SkinState("actEmpty")]
	[SkinState("actContent")]
	public class Mileage extends SkinnableComponent implements IAtt
	{
		[SkinPart(required="true")]public var ele:Group;
		[SkinPart(required="true")]public var attribute:Group;
		
		[SkinPart(required="true")]public var mileageList:List;
		[SkinPart(required="true")]public var mileageCnt:NumericStepper;
		
		[SkinPart(required="true")]public var passwordInput:TextInput;
		
		
		private var _att:Object;
		public function set att(val:Object):void { _att = val; }
		public function get att():Object { return _att; }
		
		private var _stat:String = "default";
		public function get state():String { return _stat; }
		public function set state(value:String):void {
			_stat = value;
			invalidateSkinState();
		}
		
		private var _mcount:int = 0;
		public function set mcount(val:int):void { _mcount = val; }
		public function get mcount():int { return _mcount; }
		
		private var acMileage:ArrayCollection = new ArrayCollection(["☆","☆","☆","☆"]);
		
		
		public function Mileage(val:Object){ 
			super(); 
			att = val;
			init();
			setStyle("skinClass", MileageSkin);
		}
		private function init():void {
			if (att != null) {
				mcount = att.cnt;
				acMileage = getAc(mcount);
			}
		}
		private function getAc(cnt:int):ArrayCollection {
			acMileage = new ArrayCollection();
			for (var i:int = 0; i < cnt; i++)
				acMileage.addItem("☆");
			
			return acMileage;
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
			if (instance == mileageList) {
				
				mileageList.dataProvider = acMileage;
				mileageList.layout = getImgListLayout("tile");
			}
			else if (instance == passwordInput) {
				if (att != null && att.passwd)
					passwordInput.text = att.passwd;
			}
			else if (instance == mileageCnt) {
					mileageCnt.value = mcount;
					mileageCnt.addEventListener(Event.CHANGE ,mileageCnt_changeHandler);
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
		}
		
		private function getImgListLayout(str:String):LayoutBase {
			
			var layout:LayoutBase = null;
			
			if (str == "tile") {
				var t:TileLayout = new TileLayout();
				t.verticalGap = 0;
				t.horizontalGap = 0;
				t.columnWidth = 60;
				t.rowHeight = 60;
				t.requestedColumnCount = 5;
				t.clipAndEnableScrolling = true;
				layout = t;
			}
			
			return layout
		}
		
		private function mileageCnt_changeHandler(event:Event):void {
			
			mcount = mileageCnt.value;
			var def:int = acMileage.length - mcount;
			if (def < 0) {
				def *= -1;
				for (var i:int = 0; i < def; i++) {
					acMileage.addItem("☆");
				}
			} else {
				for (var j:int = 0; j < def; j++) {
					acMileage.removeItemAt(0);
				}
			}
		}
		
	}
}