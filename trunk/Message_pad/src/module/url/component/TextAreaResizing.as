package module.url.component
{
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	
	import mx.controls.TextArea;
	
	public class TextAreaResizing extends TextArea
	{
		public function TextAreaResizing()
		{
			super();
			horizontalScrollPolicy = "off";
			verticalScrollPolicy = "off";
			this.addEventListener(Event.CHANGE, changeHandler);
		}
		
		private function changeHandler(event:Event):void {
			invalidateSize();
		}
		
		override protected function childrenCreated():void 
		{
			this.textField.autoSize = TextFieldAutoSize.LEFT;
			//this.textField.wordWrap = false;
			super.childrenCreated();
		}
		
		override protected function measure():void 
		{
			super.measure();
			//measuredWidth = textField.width;
			measuredHeight = textField.height;
		}

	}
}