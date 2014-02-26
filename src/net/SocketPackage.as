package net 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author alexfeeling
	 */
	public class SocketPackage 
	{
		
		public var data:Array;
		public var code:int;
		
		public function SocketPackage() 
		{
		}
		
		public function setDataByStr(str:String):void {
			this.data = encodeData(str);
		}
		
		public function getDataStr():String {
			return codeData(data);
		}
		
		public static function codeData(vData:Array):String {
			if (vData == null) {
				return "";
			}
			//var resultList:Array = [];
			//for (var key:String in vData) {
				//resultList.push(key + "=" + vData[key]);
			//}
			//return resultList.join("&");
			return vData.join(",");
		}
		
		public static function encodeData(vStr:String):Array {
			//var dataList:Array = vStr.split("&");
			//var resultObj:Object = { };
			//for each(var str:String in dataList) {
				//var strArr:Array = str.split("=");
				//resultObj[strArr[0]] = strArr[1];
			//}
			//return resultObj;
			var dataList:Array = vStr.split(",");
			return dataList;
		}
	}

}