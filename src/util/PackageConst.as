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
		
		public static const LOGIN_CODE:int = 0;
		public static const LOGIN_REQ_USERNAME:int = 0;
		public static const LOGIN_REQ_PASSWORD:int = 1;
		public static const LOGIN_REP_RESULT:int = 0;
		public static const LOGIN_REP_ID:int = 1;
		
		public static const REGISTER_CODE:int = 1;
		public static const REGISTER_REQ_USERNAME:int = 0;
		public static const REGISTER_REQ_PASSWORD:int = 1;
		public static const REGISTER_REP_RESULT:int = 0;
		public static const REGISTER_REP_ID:int = 1;
		
		public static const MOVE_CODE:int = 2;
		public static const MOVE_REQ_X:int = 0;
		public static const MOVE_REQ_Y:int = 1;
		
		public static const TURN_CODE:int = 3;
		public static const TURN_REQ_ANGLE:int = 0;		
		
		
	}

}