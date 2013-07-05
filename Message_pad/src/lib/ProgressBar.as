package lib
{
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	
	import spark.components.supportClasses.Range;
	
	public class ProgressBar extends Range
	{
		private var _txt:String = "";
		
		[Bindable]
		public function get txt():String { return _txt; }
		public function set txt(str:String):void { _txt = str; }
		
		
		public function ProgressBar()
		{
			super();
			snapInterval = 0;
			minimum = 0;
			maximum = 100;
		}
		
		private var _eventSource:IEventDispatcher;
		
		/**
		 * An optional IEventDispatcher dispatching progress events.  The progress events will
		 * be used to update the <code>value</code> and <code>maximum</code> properties.
		 */
		public function get eventSource():IEventDispatcher
		{
			return _eventSource;
		}
		
		/**
		 * @private
		 */
		public function set eventSource(value:IEventDispatcher):void
		{
			if (_eventSource != value)
			{
				removeEventSourceListeners();
				_eventSource = value;
				addEventSourceListeners();
			}
		}
		
		/**
		 * @private
		 * Removes listeners from the event source.
		 */
		protected function removeEventSourceListeners():void
		{
			if (eventSource)
			{
				eventSource.removeEventListener(ProgressEvent.PROGRESS, eventSource_progressHandler);
			}
		}
		
		/**
		 * @private
		 * Adds listeners to the event source.
		 */
		protected function addEventSourceListeners():void
		{
			if (eventSource)
			{
				eventSource.addEventListener(ProgressEvent.PROGRESS, eventSource_progressHandler, 
					false, 0, true);
			}
		}
		
		/**
		 * @private
		 * Updates the <code>value</code> and <code>maximum</code> properties when progress
		 * events are dispatched from the <code>eventSource</code>.
		 */
		protected function eventSource_progressHandler(event:ProgressEvent):void
		{
			value = event.bytesLoaded;
			maximum = event.bytesTotal;
		}
	}
}