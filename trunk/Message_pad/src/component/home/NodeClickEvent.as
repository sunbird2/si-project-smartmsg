package component.home
{
	import flash.events.Event;
	
	public class NodeClickEvent extends Event
	{
		public var val:String = "";
		
		public function NodeClickEvent(type:String, val:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.isEnabled = isEnabled;
			this.val = val;
		}
		
		// Define static constant.
		public static const NODE_CLICK:String = "nodeClick";
		
		// Define a public variable to hold the state of the enable property.
		public var isEnabled:Boolean;
		
		// Override the inherited clone() method.
		override public function clone():Event {
			return new NodeClickEvent(type, "", isEnabled);
		}

	}
}