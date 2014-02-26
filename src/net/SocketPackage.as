package net 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author alexfeeling
	 */
	public class SocketPackage 
	{
		
		public var code:int;
		public var data:Array;
		
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
			//var ba:ByteArray = new ByteArray();
			//for (var i:int = 0; i < vData.length; i++) {
				//if (vData[i] is int) {
					//ba.writeByte(1);
					//ba.writeShort(vData[i]);
				//} else if (vData[i] is Number) {
					//ba.writeByte(2);
					//ba.writeFloat(vData[i] as Number);
				//} else if (vData[i] is String) {
					//ba.writeByte(3);
					//ba.writeUTF(vData[i] as String);
				//}
			//}
			//return ba;
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