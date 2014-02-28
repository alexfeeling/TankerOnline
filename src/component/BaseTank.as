package component
{
	import animation.AnimationManager;
	import animation.IAnimation;
	import com.alex.pattern.Commander;
	import com.alex.pattern.IOrderExecutor;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author alex
	 */
	public class BaseTank extends BaseComponent implements IOrderExecutor
	{
		
		protected var _speed:Number = 0;
		protected var _turnSpeed:Number = 0;
		protected var _turnG:Number = 1;
		
		[Embed(source="../../bin/assets/robotCar.swf", symbol="TankRole_A")]
		public static const BLUE_TANK:Class;
		[Embed(source="../../bin/assets/robotCar.swf", symbol="TankRole_B")]
		public static const RED_TANK:Class;
		
		protected var tankMc:DisplayObject;
		protected var leftTrack:MovieClip;
		protected var rightTrack:MovieClip;
		protected var barrel:MovieClip;
		
		protected var _isUpPressing:Boolean = false;
		protected var _isDownPressing:Boolean = false;
		protected var _isLeftPressing:Boolean = false;
		protected var _isRightPressing:Boolean = false;
		
		protected var _isPause:Boolean = false;
		protected var _isPlayEnd:Boolean = false;
		
		protected var _isFiring:Boolean = false;
		protected var _isBarrelTurnLeft:Boolean = false;
		protected var _isBarrelTurnRight:Boolean = false;
		
		private var _mapX:Number = 0;
		private var _mapY:Number = 0;
		
		public function BaseTank(vId:String)
		{
			this.id = vId;
			this.init();
			Commander.registerExecutor(this);
		}
		
		protected function init():void
		{
			
		}
		
		public function moveForward(passedTime:Number = -1):void
		{
			if (passedTime == -1) {
				var distance:Number = this._speed;
			} else if (passedTime > 0) {
				distance = this._speed * (passedTime / AnimationManager.TIME_DELAY); 
			} else {
				return;
			}
			var moveX:Number = Math.sin(this.rotation * Math.PI / 180) * distance;
			var moveY:Number = Math.cos(this.rotation * Math.PI / 180) * distance;
			this.mapX += moveX;
			this.mapY -= moveY;
		}
		
		public function moveBack(passedTime:Number = -1):void
		{
			if (passedTime == -1) {
				var distance:Number = this._speed;
			} else if (passedTime > 0) {
				distance = this._speed * (passedTime / AnimationManager.TIME_DELAY); 
			} else {
				return;
			}
			var moveX:Number = Math.sin(this.rotation * Math.PI / 180) * distance;
			var moveY:Number = Math.cos(this.rotation * Math.PI / 180) * distance;
			this.mapX -= moveX;
			this.mapY += moveY;
			
		}
		
		public function turnLeft(passedTime:Number):void
		{
			if (passedTime == -1) {
				var degree:Number = this._turnSpeed;
			} else if (passedTime > 0) {
				degree = this._turnSpeed * (passedTime / AnimationManager.TIME_DELAY) * _turnG; 
			} else {
				return;
			}
			this.rotation -= degree;
		}
		
		public function turnRight(passedTime:Number):void
		{
			if (passedTime == -1) {
				var degree:Number = this._turnSpeed;
			} else if (passedTime > 0) {
				degree = this._turnSpeed * (passedTime / AnimationManager.TIME_DELAY) * _turnG; 
			} else {
				return;
			}
			this.rotation += degree;
		}
		
		public function dispose():void {
			this.removeChildren(0, -1);
			if (this.parent != null) {
				this.parent.removeChild(this);
			}
			Commander.cancelExecutor(this);
		}
		
		/* INTERFACE com.alex.pattern.IOrderExecutor */
		
		public function getExecuteOrderList():Array 
		{
			return [];
		}
		
		public function executeOrder(orderName:String, orderParam:Object = null):void 
		{
			
		}
		
		public function getExecutorId():String 
		{
			return this.id;
		}
		
		override public function gotoNextFrame(passedTime:Number):void 
		{
			if (_isUpPressing) {
				this.moveForward(passedTime);
			} else if (_isDownPressing) {
				this.moveBack(passedTime);
			}
			
			if (_isLeftPressing) {
				this.turnLeft(passedTime);
			} else if (_isRightPressing) {
				this.turnRight(passedTime);
			}
			if (!_isLeftPressing && !_isRightPressing) {
				if (_isUpPressing) {
					leftTrack.gotoAndStop((leftTrack.currentFrame + 1) % leftTrack.totalFrames+1);
					rightTrack.gotoAndStop((rightTrack.currentFrame + 1) % rightTrack.totalFrames+1);
				} else if (_isDownPressing) {
					leftTrack.gotoAndStop((leftTrack.currentFrame - 1 + leftTrack.totalFrames-1) % leftTrack.totalFrames+1);
					rightTrack.gotoAndStop((rightTrack.currentFrame - 1 + rightTrack.totalFrames-1) % rightTrack.totalFrames+1);
				}
			} else if (_isLeftPressing) {
				if (_isUpPressing) {
					rightTrack.gotoAndStop((rightTrack.currentFrame + 1) % rightTrack.totalFrames+1);
				} else if (_isDownPressing) {
					leftTrack.gotoAndStop((leftTrack.currentFrame - 1 + leftTrack.totalFrames-1) % leftTrack.totalFrames+1);
				} else {
					leftTrack.gotoAndStop((leftTrack.currentFrame - 1 + leftTrack.totalFrames-1) % leftTrack.totalFrames+1);
					rightTrack.gotoAndStop((rightTrack.currentFrame + 1) % rightTrack.totalFrames+1);
				}
			} else if (_isRightPressing) {
				if (_isUpPressing) {
					leftTrack.gotoAndStop((leftTrack.currentFrame + 1) % leftTrack.totalFrames+1);
				} else if (_isDownPressing) {
					rightTrack.gotoAndStop((rightTrack.currentFrame - 1 + rightTrack.totalFrames-1) % rightTrack.totalFrames+1);
				} else {
					leftTrack.gotoAndStop((leftTrack.currentFrame + 1) % leftTrack.totalFrames + 1);
					rightTrack.gotoAndStop((rightTrack.currentFrame - 1 + rightTrack.totalFrames-1) % rightTrack.totalFrames+1);
				}
			}
			if (this._isFiring) {
				if (barrel.currentFrame < barrel.totalFrames) {
					barrel.nextFrame();
				} else {
					barrel.gotoAndStop(1);
					this._isFiring = false;
				}
			}
			if (this._isBarrelTurnLeft) {
				this.barrel.rotation -= 1;
			} else if (this._isBarrelTurnRight) {
				this.barrel.rotation += 1;
			}
		}
		
	}

}