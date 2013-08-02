package module.ie
{
	import flash.utils.ByteArray;

	public interface ImageEditorAble
	{
		function upload(data:ByteArray, fName:String):void ;
		function removeModuleIme():void ;
	}
}