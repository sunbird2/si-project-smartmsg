package module.url
{
	import flash.events.IEventDispatcher;

	public interface IMobileWebEditor extends IEventDispatcher {
		
		function setKey(key:int):void;
		function getKey():int;
	}
}