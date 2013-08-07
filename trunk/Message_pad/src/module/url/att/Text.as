package module.url.att
{
	
	import lib.SLibrary;
	
	import module.url.att.skin.TextSkin;
	import module.url.component.TextEditor;
	
	import mx.collections.ArrayCollection;
	import mx.containers.HBox;
	import mx.controls.RichTextEditor;
	import mx.controls.Text;
	import mx.events.FlexEvent;
	
	import spark.components.ButtonBar;
	import spark.components.Group;
	import spark.components.Label;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.IndexChangeEvent;
	
	[SkinState("default")]
	[SkinState("view")]
	[SkinState("actEmpty")]
	[SkinState("actContent")]
	public class Text extends SkinnableComponent implements IAtt
	{
		[SkinPart(required="true")]public var ele:Group;
		[SkinPart(required="true")]public var attribute:Group;
		[SkinPart(required="true")]public var myRTE:TextEditor;
		
		
		private var _att:Object;
		public function set att(val:Object):void { _att = val; }
		public function get att():Object { return _att; }
		
		private var acMearg:ArrayCollection = new ArrayCollection(["이름","합성1","합성2","합성3"]);
		
		private var _stat:String = "default";
		public function get state():String { return _stat; }
		public function set state(value:String):void {
			_stat = value;
			invalidateSkinState();
		}
		
		public function Text(val:Object){ 
			super(); 
			att = val;
			setStyle("skinClass", TextSkin);
		}
		
		public function getJson():String
		{
			return null;
		}
		
		public function setJson(json:String):void
		{
		}
		
		override protected function getCurrentSkinState():String
		{
			if (att != null && _stat == "actEmpty") { _stat = "actContent"; }
			else if (att != null && _stat == "default") { _stat = "view";}
			
			return this._stat;
		} 
		
		override protected function partAdded(partName:String, instance:Object) : void
		{
			super.partAdded(partName, instance);
			if (instance == myRTE) {
				if (att != null && att.text) { myRTE.htmlText = att.text; }
			}
			
		}
		
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
		}
		
		
		private function bar_changeHandler(event:IndexChangeEvent):void {
			
			var caretStart:int = myRTE.textArea.selectionBeginIndex;
			var caretEnd:int = myRTE.textArea.selectionEndIndex;
			
			var newText:String = "";
			switch(event.newIndex)
			{
				case 0:{newText = "{이름}";break;}
				case 1:{newText = "{합성1}";break;}
				case 2:{newText = "{합성2}";break;}
				case 3:{newText = "{합성3}";break;}
				case 4:{newText = "{합성4}";break;}
				default:{break;}
			}

			myRTE.textArea.text = myRTE.textArea.text.substring(0,caretStart)
				+ newText
				+ myRTE.textArea.text.substr(caretEnd);
			
			(event.currentTarget as ButtonBar).selectedIndex = -1;
		}
		
	}
}