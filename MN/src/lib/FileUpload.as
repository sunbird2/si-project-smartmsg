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
	import flash.utils.ByteArray;
	
	import mx.core.UIComponent;

	public class FileUpload extends UIComponent
	{
		private var _bMulti:Boolean = false;
		private var _fileList:FileReferenceList;    
		private var _file:FileReference;
		
		private var _fileFilter:FileFilter = new FileFilter("All Files (*)","*.*");
		private var _uploadFiles:Array = new Array();
		
		public function FileUpload(bMulti:Boolean=false) {
			_bMulti = bMulti;
			if (_bMulti == true) _fileList = new FileReferenceList();
			else _file = new FileReference();
		}
		
		// ex) "Image Files (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg; *.jpeg; *.gif; *.png"
		public function setFilter(description:String, extension:String):void {
			_fileFilter = new FileFilter(description, extension);
		}
		
		public function browse():void {
			
			if (_bMulti == true) fileListBrowse();
			else fileBrowse();
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
				return true;
			}
			
		}
		
		public function upload():void {
			
			if(_uploadFiles.length > 0) {
				_file = _uploadFiles[0].file;
				_file.addEventListener(Event.COMPLETE, completeHandler);
				_file.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				_file.addEventListener(ProgressEvent.PROGRESS, progressHandler);
				_file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				
				_file.load();
			} else {
				// upload 완료
				this.dispatchEvent(new Event("done"));
			}
		}
		
		private function completeHandler(event:Event):void {
			
			_uploadFiles.shift();
			
			var fure:FileUploadByRemoteObjectEvent = new FileUploadByRemoteObjectEvent(FileUploadByRemoteObjectEvent.COMPLETE, event);
			fure.isEnabled = true;
			this.dispatchEvent(fure);
		}
		private function ioErrorHandler(event:IOErrorEvent):void {
			
		}
		private function progressHandler(event:ProgressEvent):void {
			this.dispatchEvent(event);
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