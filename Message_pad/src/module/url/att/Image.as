package module.url.att
{
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	
	import lib.FileUploadUrl;
	import lib.SLibrary;
	
	import module.url.att.skin.ImageSkin;
	
	import mx.collections.ArrayCollection;
	import mx.controls.ProgressBar;
	
	import spark.components.Button;
	import spark.components.ButtonBar;
	import spark.components.Group;
	import spark.components.List;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.IndexChangeEvent;
	import spark.formatters.NumberFormatter;
	import spark.layouts.HorizontalLayout;
	import spark.layouts.TileLayout;
	import spark.layouts.VerticalLayout;
	import spark.layouts.supportClasses.LayoutBase;
	import spark.primitives.BitmapImage;
	
	[SkinState("default")]
	[SkinState("view")]
	[SkinState("actEmpty")]
	[SkinState("actContent")]
	public class Image extends SkinnableComponent implements IAtt
	{
		[SkinPart(required="true")]public var ele:Group;
		[SkinPart(required="true")]public var attribute:Group;
		[SkinPart(required="true")]public var imgList:List;
		[SkinPart(required="true")]public var imgLayout:ButtonBar;
		[SkinPart(required="true")]public var uploadBtn:Button;
		[SkinPart(required="true")]public var imgToolBtn:Button;
		[SkinPart(required="true")]public var progressBar:ProgressBar;
		
		// upload
		[Bindable]
		private var loadFileRef:FileReference = new FileReference();
		private var fileTypes:FileFilter = new FileFilter("Image", "*.jpg;*.jpeg;*;*.gif;*.png;*");
		// timers to track upload time
		private var startTime:Date;
		private var endTime:Date;
		private var numberFormatter:NumberFormatter = new NumberFormatter();
		private var fuurl:FileUploadUrl = null;
		
		
		private var _att:Object;
		public function set att(val:Object):void { _att = val; }
		public function get att():Object { return _att; }
		
		private var _stat:String = "default";
		public function get state():String { return _stat; }
		public function set state(value:String):void {
			_stat = value;
			invalidateSkinState();
		}
		
		
		override protected function getCurrentSkinState():String {
			if (att != null && _stat == "actEmpty") _stat = "actContent";
			else if (att != null && _stat == "default") {
				_stat = "view";
				if (imgList != null && imgList.selectedIndex >= 0) imgList.selectedIndex = -1;
			}
			
			//trace(_stat);
			return this._stat;
		} 
		
		public function Image(val:Object){ 
			super(); 
			att = val;
			setStyle("skinClass", ImageSkin);
		}

		override protected function partAdded(partName:String, instance:Object) : void {
			
			super.partAdded(partName, instance);
			
			if (instance == imgList) {
				if (att != null) { 
					setImgListLayout();
					imgList.dataProvider = new ArrayCollection( att.imgs );
					
				}
			}
			else if (instance == imgLayout) {
				if (att != null) {
					if (att.layout == "horizontal") imgLayout.selectedIndex = 0;
					else if (att.layout == "vertical") imgLayout.selectedIndex = 1;
					else if (att.layout == "tile") imgLayout.selectedIndex = 2;
				}
				
				imgLayout.addEventListener(IndexChangeEvent.CHANGE, imgLayout_changeHandler);
			}
			else if (instance == uploadBtn) {
				uploadBtn.addEventListener(MouseEvent.CLICK, uploadBtn_clickHandler);
			}
			else if (instance == imgToolBtn) {
				imgToolBtn.addEventListener(MouseEvent.CLICK, imgToolBtn_clickHandler);
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
		}
		
		private function attInit():void {
			att = {layout:"horizontal", imgs:[]};
		}
		
		private function img_clickHandler(event:MouseEvent):void {
			
		}
		
		private function getImgListLayout(str:String):LayoutBase {
			
			var layout:LayoutBase = null;
			if (att.layout == "horizontal") {
				var h:HorizontalLayout = new HorizontalLayout();
				h.variableColumnWidth = false;
				h.columnWidth = 300;
				//h.variableColumnWidth = false;
				//h.clipAndEnableScrolling = true;
				layout = h;
			} else if (att.layout == "vertical") {
				var v:VerticalLayout = new VerticalLayout();
				v.variableRowHeight = false;
				//v.variableColumnWidth = false;
				//v.clipAndEnableScrolling = true;
				layout = v;
			} else if (att.layout == "tile") {
				var t:TileLayout = new TileLayout();
				t.verticalGap = 0;
				t.horizontalGap = 0;
				t.columnWidth = 100;
				t.rowHeight = 100;
				t.requestedColumnCount = 3;
				t.clipAndEnableScrolling = true;
				//t.rowHeight = 72;
				//t.clipAndEnableScrolling = true;
				layout = t;
			} 
				
			return layout
		}
		
		private function setImgListLayout():void {
			
			if (imgList != null) {
				imgList.layout = getImgListLayout(att.layout);
			}
		}
		
		private function imgLayout_changeHandler(event:IndexChangeEvent):void {
			
			var selIndex:int = event.newIndex;
			var strLayout:String = "";
			switch(selIndex)
			{
				case 0:{strLayout = "horizontal";break;}
				case 1:{strLayout = "vertical";break;}
				case 2:{strLayout = "tile";break;}
				default:{break;}
			}
			this.att.layout = strLayout;
			setImgListLayout();
		}
		
		private function uploadBtn_clickHandler(event:MouseEvent):void {
			
			if (fuurl == null) {
				fuurl = new FileUploadUrl(true);
				if (progressBar != null) fuurl.pb = progressBar;
				fuurl.url = "/API/upload.jsp";
				fuurl.addEventListener("done", fuurl_doneHandler);
			}
			
			fuurl.browse();
		}
		private function fuurl_doneHandler(event:Event):void {
			
			var arr:Array = fuurl.arrRs;
			if (arr != null) {
				var cnt:uint = arr.length;
				for (var i:int = 0; i < cnt; i++) {
					if (arr[i].b == "true")
						setImage(arr[i].img,"");
				}
				if (cnt > 0) {
					setImgListLayout();
					imgList.dataProvider = new ArrayCollection( att.imgs );
					state = "actContent";
				}
			}
		}
		private function setImage(aurl:String, alink:String):void {
			
			if (att == null) attInit();
			(att.imgs  as Array).push({url:"/urlImage/201307/1375167902810.png",link:alink});
			(att.imgs  as Array).push({url:"/urlImage/201307/1375167902810.png",link:alink});
		}
		
		private function imgToolBtn_clickHandler(event:MouseEvent):void {
			
		}
		
		private function initAtt():void {
			if (att == null) {
				att = new Object();
				att.layout = "horizontal";
				att.imgs = new Array();
			}
		}
		private function getImgObj(url:String, link:String):Object {
			return {url:url,link:link};
		}
	}
}