package net 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author alexfeeling
	 */
	public class SocketPackage 
	{
		
		//public var name:String;
		public var data:Object;
		
		
		public function SocketPackage(vData:Object) 
		{
			//if (vName) {
				//name = vName;
			//}
			if (vData) {
				data = vData;
			}
		}
		
		public function getDataStr():String {
			return codeData(data);
		}
		
		public static function codeData(vData:Object):String {
			if (vData == null) {
				return "";
			}
			var resultList:Array = [];
			for (var key:String in vData) {
				resultList.push(key + "=" + vData[key]);
			}
			return resultList.join("&");
		}
		
		public static function encodeData(vStr:String):Object {
			var dataList:Array = vStr.split("&");
			var resultObj:Object = { };
			for each(var str:String in dataList) {
				var strArr:Array = str.split("=");
				resultObj[strArr[0]] = strArr[1];
			}
			return resultObj;
		}
	}

}