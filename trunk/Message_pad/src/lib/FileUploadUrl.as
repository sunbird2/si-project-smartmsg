package lib
{
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import mx.controls.ProgressBar;
	import mx.core.UIComponent;
	
	public class FileUploadUrl extends UIComponent
	{
		// Hard-code the URL of the remote upload script.
		private var _url:String = null;
		public function set url(str:String):void { this._url = str; }
		public function get url():String { return this._url; }
		private var _pb:ProgressBar = null;
		public function set pb(str:ProgressBar):void { this._pb = str; }
		
		private var _byteTotal:Number = 0;
		public function set byteTotal(str:Number):void { this._byteTotal = str; }
		public function get byteTotal():Number { return this._byteTotal; }
		
		public var arrRs:Array = new Array();
		
		private var _uploadByte:Number = 0;
		
		
		private var _bMulti:Boolean = false;
		private var _fileList:FileReferenceList;    
		private var _file:FileReference;
		
		private var _fileFilter:FileFilter = new FileFilter("All Files (*)","*.*");
		private var _uploadFiles:Array = new Array();
		
		public function FileUploadUrl(bMulti:Boolean=false) {
			_bMulti = bMulti;
			if (_bMulti == true) _fileList = new FileReferenceList();
			else _file = new FileReference();
		}
		
		// ex) "Image Files (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg; *.jpeg; *.gif; *.png"
		public function setFilter(description:String, extension:String):void {
			_fileFilter = new FileFilter(description, extension);
		}
		
		public function browse():void {
			
			byteTotal = 0;
			
			if (_bMulti == true) fileListBrowse();
			else fileBrowse();
		}
		
		public function init():void {
			byteTotal = 0;
			_uploadFiles = new Array();
			arrRs = new Array();
		}
		
		private function fileListBrowse():void {
			_fileList.browse([_fileFilter]);
			_fileList.addEventListener(Event.SELECT,selectHandler, false, 0, true); 
			
		}
		private function fileBrowse():void {
			_file.browse([_fileFilter]);
			_file.addEventListener(Event.SELECT,selectHandler, false, 0, true); 
		}
		
		private function selectHandler(event:Event):void { 
			
			_uploadFiles = [];
			if (_bMulti == true) fileListSelect();
			else fileSelect();
			
		}
		private function fileListSelect():void {
			
			var b:Boolean = false;
			for(var i:Number = 0; i < _fileList.fileList.length; i++) {
				b = pushUpload(_fileList.fileList[i]);
				if (b == false) break;
			}
			if (b == true)	upload();
		}
		private function fileSelect():void {
			
			if (pushUpload(_file) == true)	upload();
		}
		private function pushUpload(fr:FileReference):Boolean {
			
			if ( Number(fr.size) > Number(1024*1024*10) ) {
				SLibrary.alert("10MB 이상의 파일은 사용 하실 수 없습니다.("+fr.name+")");
				return false;
			} else {
				_uploadFiles.push({  name:fr.name, 
					size:formatFileSize(fr.size), 
					realsize:String(fr.size),
					file:fr
				});
				byteTotal += fr.size;
				return true;
			}
			
		}
		
		public function upload():void {
			
			if(_uploadFiles.length > 0) {
				_file = _uploadFiles[0].file;
				_file.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, completeHandler);
				_file.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				_file.addEventListener(ProgressEvent.PROGRESS, progressHandler);
				_file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				
				var request:URLRequest = new URLRequest();
				request.url = url;
				_file.upload(request);

			} else {
				// upload 완료
				this.dispatchEvent(new Event("done"));
			}
		}
		
		private function completeHandler(event:DataEvent):void {
			
			if (event.data != null) {
				var data:*  =JSON.parse(event.data);
				arrRs.push(data);
			}
			if (_pb != null)
				_uploadByte = _pb.value;
			
			_uploadFiles.shift();
			upload();
		}
		private function ioErrorHandler(event:IOErrorEvent):void {
			
		}
		private function progressHandler(event:ProgressEvent):void {
			
			if (_pb != null) {
				_pb.label = "UPLOADING %3%%";
				_pb.setProgress(event.bytesLoaded+_uploadByte, byteTotal);
			}
			
			//this.dispatchEvent(event);
		}
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			
		}
		
		// Called to format number to file size 
		private function formatFileSize(numSize:Number):String { 
			
			var strReturn:String; 
			numSize = Number(numSize / 1000); 
			strReturn = String(numSize.toFixed(1) + " KB"); 
			if (numSize > 1000) { 
				numSize = numSize / 1000; 
				strReturn = String(numSize.toFixed(1) + " MB"); 
				if (numSize > 1000) { 
					numSize = numSize / 1000; 
					strReturn = String(numSize.toFixed(1) + " GB"); 
				} 
			}    
			return strReturn; 
		}
	}
}