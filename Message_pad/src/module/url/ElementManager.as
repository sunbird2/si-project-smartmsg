package module.url
{
	
	import mx.collections.ArrayCollection;
	import mx.core.IVisualElement;

	public class ElementManager
	{ 
		public static const IMG:int = 0;
		public static const TXT:int = 1;
		public static const INPUT:int = 2;
		public static const BTN:int = 3;
		public static const SHOPLIST:int = 4;
		public static const ASKLIST:int = 5;
		
		public function ElementManager() {}
		public function getObject(type:int, value:String):IVisualElement {
			
			var ive:IVisualElement = null;
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
		
		private function getIMG(value:String):IVisualElement {
			
			return null;
		}
		private function getTXT(value:String):IVisualElement {
			
			return null;
		}
		private function getINPUT(value:String):IVisualElement {
			
			return null;
		}
		private function getBTN(value:String):IVisualElement {
			
			return null;
		}
		private function getSHOPLIST(value:String):IVisualElement {
			
			return null;
		}
		private function getASKLIST(value:String):IVisualElement {
			
			return null;
		}
		
		private function jsonParse(json:String):ArrayCollection {
			var data:*  =JSON.parse(json);
			var ac:ArrayCollection = new ArrayCollection(data);
			return ac;
		}
	}
}