package component.address.renderer
{
	[Bindable]public class NameItem
	{
		private var _idx:uint;
		private var _name:String;
		private var _company:String;
		private var _hp:String;
		private var _phone:String;
		private var _memo:String;
		private var _photo:String;
		
		public function NameItem()
		{
		}

		public function get photo():String
		{
			return _photo;
		}

		public function set photo(value:String):void
		{
			_photo = value;
		}

		public function get memo():String
		{
			return _memo;
		}

		public function set memo(value:String):void
		{
			_memo = value;
		}

		public function get phone():String
		{
			return _phone;
		}

		public function set phone(value:String):void
		{
			_phone = value;
		}

		public function get hp():String
		{
			return _hp;
		}

		public function set hp(value:String):void
		{
			_hp = value;
		}

		public function get company():String
		{
			return _company;
		}

		public function set company(value:String):void
		{
			_company = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get idx():uint
		{
			return _idx;
		}

		public function set idx(value:uint):void
		{
			_idx = value;
		}

	}
}