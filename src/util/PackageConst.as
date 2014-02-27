package util 
{
	/**
	 * ...
	 * @author alex
	 */
	public class PackageConst 
	{
		
		public function PackageConst() 
		{
			throw "error";
		}
		
		public static const TYPE_INT8:int = 101;
		public static const TYPE_INT16:int = 102;
		public static const TYPE_INT32:int = 103;
		public static const TYPE_FLOAT:int = 104;
		public static const TYPE_DOUBLE:int = 105;
		public static const TYPE_STRING:int = 106;
		public static const TYPE_ARRAY:int = 107;
		
		public static const LOGIN_CODE:int = 0;
		public static const LOGIN_REQ_DATA_TYPE:Array = [TYPE_STRING, TYPE_STRING];
		public static const LOGIN_REQ_USERNAME:int = 0;
		public static const LOGIN_REQ_PASSWORD:int = 1;
		public static const LOGIN_REP_DATA_TYPE:Array = [TYPE_INT8, TYPE_STRING];
		public static const LOGIN_REP_RESULT:int = 0;
		public static const LOGIN_REP_ID:int = 1;
		
		public static const REGISTER_CODE:int = 1;
		public static const REGISTER_REQ_DATA_TYPE:Array = [TYPE_STRING, TYPE_STRING];
		public static const REGISTER_REQ_USERNAME:int = 0;
		public static const REGISTER_REQ_PASSWORD:int = 1;
		public static const REGISTER_REP_DATA_TYPE:Array = [TYPE_INT8, TYPE_STRING];
		public static const REGISTER_REP_RESULT:int = 0;
		public static const REGISTER_REP_ID:int = 1;
		
		public static const MOVE_CODE:int = 2;
		public static const MOVE_REQ_DATA_TYPE:Array = [TYPE_INT16, TYPE_INT16, TYPE_FLOAT];
		public static const MOVE_REQ_X:int = 0;
		public static const MOVE_REQ_Y:int = 1;
		public static const MOVE_REQ_ROTATION:int = 2;
		
		public static const MOVE_BOARDCAST_CODE:int = 3;
		public static const MOVE_BOARDCAST_DATA_TYPE:Array = [TYPE_STRING, TYPE_INT16, TYPE_INT16, TYPE_FLOAT];
		public static const MOVE_BOARDCAST_TANK_ID:int = 0;
		public static const MOVE_BOARDCAST_X:int = 0;
		public static const MOVE_BOARDCAST_Y:int = 0;
		public static const MOVE_BOARDCAST_ROTATION:int = 0;
		
	}

}