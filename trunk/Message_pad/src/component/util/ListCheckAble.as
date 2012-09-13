package component.util
{
	import flash.events.MouseEvent;
	
	import spark.components.List;

	public class ListCheckAble extends List
	{
		private var checkAble:Boolean = false;
		public function ListCheckAble()	{}
		
		override protected function item_mouseDownHandler(event:MouseEvent):void
		{
			if (allowMultipleSelection) {
				event.ctrlKey = true;
			}
			super.item_mouseDownHandler(event);
		}
		
		
	}
}