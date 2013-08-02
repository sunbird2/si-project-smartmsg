package module.url.att
{
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	import flash.utils.ByteArray;
	
	import lib.FileUploadUrl;
	import lib.SLibrary;
	
	import module.ie.ImageEditorAble;
	import module.url.att.skin.ImageSkin;
	
	import mx.collections.ArrayCollection;
	import mx.controls.ProgressBar;
	import mx.events.ModuleEvent;
	
	import spark.components.Button;
	import spark.components.ButtonBar;
	import spark.components.Group;
	import spark.components.Image;
	import spark.components.List;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.events.IndexChangeEvent;
	import spark.formatters.NumberFormatter;
	import spark.layouts.HorizontalLayout;
	import spark.layouts.TileLayout;
	import spark.layouts.VerticalLayout;
	import spark.layouts.supportClasses.LayoutBase;
	import spark.modules.ModuleLoader;
	import spark.primitives.BitmapImage;
	
	[SkinState("default")]
	[SkinState("view")]
	[SkinState("actEmpty")]
	[SkinState("actContent")]
	public class Image extends SkinnableComponent implements IAtt, ImageEditorAble
	{
		[SkinPart(required="true")]public var ele:Group;
		[SkinPart(required="true")]public var attribute:Group;
		[SkinPart(required="true")]public var imgList:List;
		[SkinPart(required="true")]public var imgLayout:ButtonBar;
		[SkinPart(required="true")]public var uploadBtn:Button;
		[SkinPart(required="true")]public var imgToolBtn:Button;
		[SkinPart(required="true")]public var progressBar:ProgressBar;
		[SkinPart(required="true")]public var nextIcon:spark.components.Image;
		[SkinPart(required="true")]public var preIcon:spark.components.Image;
		
		
		[SkinPart(required="true")]public var imgDelBtn:Button;
		[SkinPart(required="true")]public var uploadAddBtn:Button;
		[SkinPart(required="true")]public var imgToolAddBtn:Button;
		// ImageEditor Module
		[SkinPart(required="true")]public var moduleLoaderIme:ModuleLoader;
		// loading
		[SkinPart(reqired='false')]public var loading:Group;
		
		// upload
		[Bindable]
		private var loadFileRef:FileReference = new FileReference();
		private var fileTypes:FileFilter = new FileFilter("Image", "*.jpg;*.jpeg;*;*.gif;*.png;*");
		// timers to track upload time
		private var startTime:Date;
		private var endTime:Date;
		private var numberFormatter:NumberFormatter = new NumberFormatter();
		private var fuurl:FileUploadUrl = null;
		
		private var isViewNextPreIcon:Boolean = false;
		
		
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
			if (att.layout == "horizontal") isViewNextPreIcon = true;
			
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
			else if (instance == uploadBtn || instance == uploadAddBtn) {
				instance.addEventListener(MouseEvent.CLICK, uploadBtn_clickHandler);
			}
			else if (instance == imgToolBtn || instance == imgToolAddBtn) {
				instance.addEventListener(MouseEvent.CLICK, imgToolBtn_clickHandler);
			}
			else if (instance == imgDelBtn) {
				imgDelBtn.addEventListener(MouseEvent.CLICK, imgDelBtn_clickHandler);
			}
			else if (instance == nextIcon) {
				nextIcon.addEventListener(MouseEvent.CLICK, preNextIcon_clickHandler);
			}
			else if (instance == preIcon) {
				preIcon.addEventListener(MouseEvent.CLICK, preNextIcon_clickHandler);
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
			preNextIconView(false);
			if (att.layout == "horizontal") {
				var h:HorizontalLayout = new HorizontalLayout();
				h.variableColumnWidth = false;
				h.columnWidth = 300;
				preNextIconView(true);
				layout = h;
			} else if (att.layout == "vertical") {
				var v:VerticalLayout = new VerticalLayout();
				v.variableRowHeight = false;
				layout = v;
			} else if (att.layout == "tile") {
				var t:TileLayout = new TileLayout();
				t.verticalGap = 0;
				t.horizontalGap = 0;
				t.columnWidth = 100;
				t.rowHeight = 100;
				t.requestedColumnCount = 3;
				t.clipAndEnableScrolling = true;
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
			fuurl.arrRs = new Array();
			progressBar.visible = false;
			removeModuleIme();
			
		}
		private function setImage(aurl:String, alink:String):void {
			
			if (att == null) attInit();
			(att.imgs  as Array).push({url:"/urlImage/201307/1375167902810.png",link:alink});
		}
		
		private function imgToolBtn_clickHandler(event:MouseEvent):void {
			createModuleIme("module/ie/ImageEditor.swf");
		}
		
		private function imgDelBtn_clickHandler(event:MouseEvent):void {att = null;imgList.dataProvider = null;state = "default";}
		
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
		
		public function upload(data:ByteArray, fName:String):void {
			if (fuurl == null) {
				fuurl = new FileUploadUrl(true);
				if (progressBar != null) fuurl.pb = progressBar;
				fuurl.url = "/API/upload.jsp";
				fuurl.addEventListener("done", fuurl_doneHandler);
			}
			
			fuurl.uploadByteArray(data, fName);
		}
		// image tool
		public function createModuleIme(s:String):void {
			
			if (moduleLoaderIme == null) { moduleLoaderIme = new ModuleLoader(); }
			loading.visible = true;
			moduleLoaderIme.addEventListener(ModuleEvent.READY, ime_moduleReadyHandler);
			if (!moduleLoaderIme.url) { moduleLoaderIme.url = s; }
			moduleLoaderIme.loadModule();
		}
		private function ime_moduleReadyHandler(event:ModuleEvent):void {
			loading.visible = false;
		}
		
		private function preNextIconView(b:Boolean):void {
			isViewNextPreIcon = b;
			if (nextIcon != null) nextIcon.visible = isViewNextPreIcon;
			if (preIcon != null) preIcon.visible = isViewNextPreIcon;
		}
		private function preNextIcon_clickHandler(event:MouseEvent):void {
			
			var num:int = 1;
			if (event.currentTarget == preIcon) num = -1;
			//trace(imgList.layout.horizontalScrollPosition+"/"+imgList.width) ;
			
			var pg:int = Math.floor( imgList.layout.horizontalScrollPosition /imgList.width ) + num;
			imgList.ensureIndexIsVisible(pg);
			
		}
		
		public function removeModuleIme():void {
			
			if (moduleLoaderIme != null) {
				moduleLoaderIme.removeEventListener(ModuleEvent.READY, ime_moduleReadyHandler);
				moduleLoaderIme.unloadModule();
			}
			loading.visible = false;
		}
	}
}