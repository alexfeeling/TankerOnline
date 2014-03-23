package component 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author alexfeeling
	 */
	public class RedTank extends BaseTank 
	{
		
		private var _recordTime:Number = 0;
		
		public function RedTank(vId:String) 
		{
			super(vId);
		}
		
		override protected function init():void 
		{
			super.init();
			//tankMc = new RED_TANK();
			//leftTrack = tankMc["leftTrack"] as MovieClip;
			//rightTrack = tankMc["rightTrack"] as MovieClip;
			//barrel = tankMc["barrel"] as MovieClip;
			//
			//leftTrack.stop();
			//rightTrack.stop();
			//barrel.stop();
			//
			//this.addChild(tankMc);
			
			this._speed = 2;
			this._turnSpeed = 2;
		}
		
		public function receiveOperation(type:int):void {
			
		}
		
	}

}