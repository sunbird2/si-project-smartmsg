package lib
{
	import flash.net.LocalConnection;

	public class GC
	{
		public function GC() {}
		public static function run():void {
			
			try	{
				new LocalConnection().connect('foo');
				new LocalConnection().connect('foo');
			}catch (e:Error){}   
		}
	}
}