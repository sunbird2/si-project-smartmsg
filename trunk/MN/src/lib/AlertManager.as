package lib
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	
	import mx.controls.Alert;
	import mx.core.IFlexModuleFactory;
	import mx.events.CloseEvent;

	public class AlertManager extends EventDispatcher
	{
		private var obj:Object;
		
		public function AlertManager(text:String="", title:String="", flags:uint=4, parent:Sprite=null, customEventObj:Object=null, iconClass:Class=null, defaultButtonFlag:uint=4, moduleFactory:IFlexModuleFactory=null )
		{
			this.obj = customEventObj; 
			Alert.show(text, title, flags, parent, closeHandler, iconClass, defaultButtonFlag, moduleFactory);
		}
		
		private function closeHandler(event:CloseEvent):void {
			
			if(event.detail == Alert.YES) {
				this.dispatchEvent(new CustomEvent("yes",obj));
			}
			else if (event.detail == Alert.CANCEL){
				return;
			} 
		}
		
	}
}