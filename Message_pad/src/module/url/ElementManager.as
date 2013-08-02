package module.url
{
	
	import module.url.att.Image;
	import module.url.att.Text;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.supportClasses.SkinnableComponent;

	public class ElementManager
	{ 
		public static const TXT:int = 0;
		public static const IMG:int = 1;
		public static const INPUT:int = 2;
		public static const BTN:int = 3;
		public static const SHOPLIST:int = 4;
		public static const ASKLIST:int = 5;
		
		public function ElementManager() {}
		public function getObject(type:int, value:Object):SkinnableComponent {
			
			var ive:SkinnableComponent = null;
			switch(type)
			{
				case IMG: { ive = getIMG(value); break; }
				case TXT: { ive = getTXT(value); break; }
				case INPUT: { ive = getINPUT(value); break; }
				case BTN: { ive = getBTN(value); break; }
				case SHOPLIST: { ive = getSHOPLIST(value); break; }
				case ASKLIST: {	ive = getASKLIST(value); break; }
				default:
				{
					break;
				}
			}
			return ive;
		}
		
		private function getIMG(value:Object):SkinnableComponent {
			
			return new Image(value);
		}
		private function getTXT(value:Object):SkinnableComponent {
			return new Text(value);
		}
		private function getINPUT(value:Object):SkinnableComponent {
			
			return null;
		}
		private function getBTN(value:Object):SkinnableComponent {
			
			return null;
		}
		private function getSHOPLIST(value:Object):SkinnableComponent {
			
			return null;
		}
		private function getASKLIST(value:Object):SkinnableComponent {
			
			return null;
		}
		
		private function jsonParse(json:String):ArrayCollection {
			var data:*  =JSON.parse(json);
			var ac:ArrayCollection = new ArrayCollection(data);
			return ac;
		}
	}
}