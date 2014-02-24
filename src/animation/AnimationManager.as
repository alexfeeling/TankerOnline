package animation 
{
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author alex
	 */
	public class AnimationManager 
	{
		public static const FPS:int = 60;
		static public const TIME_DELAY:Number = 10;
		
		private static var _instance:AnimationManager;
		
		private var _allAnimation:Vector.<IAnimation>;
		private var _beginTime:int;
		public function AnimationManager() 
		{
			if (_instance != null) {
				return;
			}
			_allAnimation = new Vector.<IAnimation>();
			start();
		}
		
		public static function getInstance():AnimationManager {
			if (_instance == null) {
				_instance = new AnimationManager();
			}
			return _instance;
		}
	
		private function start():void {
			var timer:Timer = new Timer(1000/AnimationManager.FPS);
			timer.addEventListener(TimerEvent.TIMER, updateTime);
			timer.start();
			_beginTime = getTimer();
		}
		
		public function addToAnimation(animation:IAnimation):void {
			if (animation != null) {
				_allAnimation.push(animation);
			}
		}
		
		private function updateTime(event:TimerEvent):void {
			var timer:Timer = event.target as Timer;
			var currentTime:int = getTimer();
			var passedTime:Number = currentTime - _beginTime;
			_beginTime = currentTime;
			for (var i:int = 0, len:int = _allAnimation.length; i < len; i++) {
				if (_allAnimation[i].isPlayEnd()) {
					_allAnimation.splice(i, 1);
					i--;
					len = _allAnimation.length;
					continue;
				}
				if (!_allAnimation[i].isPause()) {
					_allAnimation[i].gotoNextFrame(passedTime);
				}
			}
		}
		
	}

}