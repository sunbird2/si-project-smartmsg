package component.home
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import mx.controls.Alert;
	[Event(name="nodeClick", type="component.home.NodeClickEvent")]
	public class Tag extends Sprite {
		
		//private var _back:Sprite;
		private var _node:Object;
		private var _cx:Number;
		private var _cy:Number;
		private var _cz:Number;
		private var _color:Number;
		private var _hicolor:Number;
		private var _active:Boolean;
		private var _tf:TextField;
		private var keyword:String;



		public function Tag( node:Object, color:Number, hicolor:Number ){
					
			_node = node;
			keyword = node.name;
			_color = color;
			_hicolor = hicolor;
			_active = false;
			// create the text field
			_tf = new TextField();
			_tf.autoSize = TextFieldAutoSize.LEFT;
			_tf.selectable = false;
			// set styles
			var format:TextFormat = new TextFormat();
			format.font = "NGD";
			format.bold = true;
			format.color = color;
			format.size = ((8*node.size)/90);
			_tf.defaultTextFormat = format;
			_tf.embedFonts = false;
			// set text
			_tf.text = node.name;
			addChild(_tf);
			// scale and add
			_tf.x = -this.width / 2;
			_tf.y = -this.height / 2;
			// create the back
			/*_back = new Sprite();
			_back.graphics.beginFill( _hicolor, .4 );
			_back.graphics.lineStyle( 0, _hicolor );
			_back.graphics.drawRect( 0, 0, _tf.textWidth+20, _tf.textHeight+5 );
			_back.graphics.endFill();
			addChildAt( _back, 0 );
			_back.x = -( _tf.textWidth/2 ) - 10;
			_back.y = -( _tf.textHeight/2 ) - 2;
			_back.visible = false;*/
			// force mouse cursor on rollover
			this.mouseChildren = false;
			this.buttonMode = true;
			this.useHandCursor = true;
			// events
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		private function mouseOverHandler( e:MouseEvent ):void {
			//_back.visible = true;
			_tf.textColor = _hicolor;
			_active = true;
		}
		
		private function mouseOutHandler( e:MouseEvent ):void {
			//_back.visible = false;
			_tf.textColor = _color;
			_active = false;
		}
		
		private function mouseUpHandler( e:MouseEvent ):void {
			
			dispatchEvent(new NodeClickEvent(NodeClickEvent.NODE_CLICK,e.currentTarget._node.val));
			//Set the actions you want for click here
			//Alert.show("How dare you? You clicked me!"+e.currentTarget._node.name);
		}

		// setters and getters
		public function set cx( n:Number ):void{ _cx = n }
		public function get cx():Number { return _cx; }
		public function set cy( n:Number ):void{ _cy = n }
		public function get cy():Number { return _cy; }
		public function set cz( n:Number ):void{ _cz = n }
		public function get cz():Number { return _cz; }
		public function get active():Boolean { return _active; }

	}

}
