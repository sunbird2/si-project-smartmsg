package component.address.renderer
{
	[Bindable]public class GroupItem
	{
		private var _name:String;
		private var _count:uint;
		
		public function GroupItem()
		{
		}
				
		public function get count():uint
		{
			return _count;
		}

		public function set count(value:uint):void
		{
			_count = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

	}
}