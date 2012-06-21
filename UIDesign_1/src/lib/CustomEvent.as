package lib
{

		//createcomps_events/myEvents/EnableChangeEventConst.as
		import flash.events.Event;
		
		public class CustomEvent extends Event
		{   
			// Public constructor. 
			public function CustomEvent(type:String, obj:Object=null) {
				// Call the constructor of the superclass.
				super(type);
				
				// Set the new property.
				this.result = obj;
			}
			
			// Define static constant.
			public static const SEND_OBJECT:String = "sendObject";
			
			// Define a public variable to hold the state of the enable property.
			public var result:Object;
			
			// Override the inherited clone() method. 
			override public function clone():Event {
				return new CustomEvent(type, result);
			}
		}
	
}