package lib
{
	import flash.external.ExternalInterface;
	/**
	 - useage
		//Set a cookie named mycookie with a value of mycookie value with a time to live of 30 days 
		CookieUtil.setCookie(“mycookie”, “mycookie value”, 30); 
		//Get that cookie and trace its value 
		trace(CookieUtil.getCookie(“mycookie”)); 
		//Delete the cookie from the users computer 
		CookieUtil.deleteCookie(“mycookie”); 
	 * */
	public class CookieUtil
	{
		public function CookieUtil()
		{
		}
		
		private static const FUNCTION_SETCOOKIE:String = 
			"document.insertScript = function ()" +
			"{ " +
			"if (document.snw_setCookie==null)" +
			"{" +
			"snw_setCookie = function (name, value, days)" +
			"{" +
			"if (days) {"+
			"var date = new Date();"+
			"date.setTime(date.getTime()+(days*24*60*60*1000));"+
			"var expires = '; expires='+date.toGMTString();"+
			"}" +
			"else var expires = '';"+
			"document.cookie = name+'='+value+expires+'; path=/';" +
			"}" +
			"}" +
			"}";
		
		private static const FUNCTION_GETCOOKIE:String = 
			"document.insertScript = function ()" +
			"{ " +
			"if (document.snw_getCookie==null)" +
			"{" +
			"snw_getCookie = function (name)" +
			"{" +
			"var nameEQ = name + '=';"+
			"var ca = document.cookie.split(';');"+
			"for(var i=0;i < ca.length;i++) {"+
			"var c = ca[i];"+
			"while (c.charAt(0)==' ') c = c.substring(1,c.length);"+
			"if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);"+
			"}"+
			"return null;" +
			"}" +
			"}" +
			"}";
		
		
		private static var INITIALIZED:Boolean = false;
		
		private static function init():void{
			
			
		}
		
		public static function setCookie(name:String, value:Object, days:int):void{
		
			
		}
		
		public static function getCookie(name:String):Object{
			return null;
		}
		
		public static function deleteCookie(name:String):void{
			
		}
		
	}
}