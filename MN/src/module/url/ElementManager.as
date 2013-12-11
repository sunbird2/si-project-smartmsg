package module.url
{
	
	import module.url.att.Btn;
	import module.url.att.Coupon;
	import module.url.att.Image;
	import module.url.att.Input;
	import module.url.att.Mileage;
	import module.url.att.Research;
	import module.url.att.Text;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.supportClasses.SkinnableComponent;

	public class ElementManager
	{ 
		public static const TXT:int = 0;
		public static const IMG:int = 1;
		public static const INPUT:int = 2;
		public static const BTN:int = 3;
		public static const MILEAGE:int = 4;
		public static const ASKLIST:int = 5;
		public static const COUPON:int = 6;
		public static const SHOPLIST:int = 7;
		
		[Bindable]
		private var val:Object = null;
		
		public function ElementManager() {}
		public function getObject(type:int, value:Object):SkinnableComponent {
			
			val = value;
			var ive:SkinnableComponent = null;
			switch(type)
			{
				case IMG: { ive = getIMG(val); break; }
				case TXT: { ive = getTXT(val); break; }
				case INPUT: { ive = getINPUT(val); break; }
				case BTN: { ive = getBTN(val); break; }
				case MILEAGE: { ive = getMILEAGE(val); break; }
				case ASKLIST: {	ive = getASKLIST(val); break; }
				case COUPON: {	ive = getCOUPON(val); break; }
				case SHOPLIST: { ive = getSHOPLIST(val); break; }
				
				default:
				{
					break;
				}
			}
			return ive;
		}
		
		private function getIMG(value:Object):SkinnableComponent {
			
			return new Image(val);
		}
		private function getTXT(value:Object):SkinnableComponent {
			return new Text(val);
		}
		private function getINPUT(value:Object):SkinnableComponent {
			
			return new Input(val);
		}
		private function getBTN(value:Object):SkinnableComponent {
			
			return new Btn(val);
		}
		private function getMILEAGE(value:Object):SkinnableComponent {
			
			return new Mileage(val);
		}
		private function getASKLIST(value:Object):SkinnableComponent {
			
			return new Research(val);
		}
		private function getCOUPON(value:Object):SkinnableComponent {
			
			return new Coupon(val);
		}
		
		private function getSHOPLIST(value:Object):SkinnableComponent {
			
			return null;
		}
		
		public function jsonParse(json:String):ArrayCollection {
			var data:*  =JSON.parse(json);
			var ac:ArrayCollection = new ArrayCollection(data);
			return ac;
		}
	}
}