package component
{
	import com.alex.animation.AnimationManager;
	import com.alex.pattern.Commander;
	import com.alex.pattern.IOrderExecutor;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.MovieClip;
	import starling.textures.TextureAtlas;
	import starling.utils.deg2rad;
	import util.MoveDirection;
	
	/**
	 * ...
	 * @author alex
	 */
	public class BaseTank extends BaseComponent implements IOrderExecutor
	{
		
		public var blood:int = 100;
		
		protected var _speed:Number = 0;
		protected var _turnSpeed:Number = 0;
		protected var _turnG:Number = 1;
		
		//[Embed(source="../../bin/assets/robotCar.swf", symbol="TankRole_A")]
		//public static const BLUE_TANK:Class;
		//[Embed(source="../../bin/assets/robotCar.swf", symbol="TankRole_B")]
		//public static const RED_TANK:Class;
		
		//protected var tankMc:DisplayObject;
		//protected var leftTrack:MovieClip;
		//protected var rightTrack:MovieClip;
		
		protected var thruster:MovieClip;
		protected var body:MovieClip
		protected var weapon:MovieClip;
		
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
		
		private var _textureAtlas:TextureAtlas;
		
		
		public function BaseTank(vId:String, textureAtlas:TextureAtlas)
		{
			this.id = vId;
			_textureAtlas = textureAtlas;
			this.init();
			Commander.registerExecutor(this);
		}
		
		protected function init():void
		{
			thruster = new MovieClip(_textureAtlas.getTextures("thruster"));
			thruster.fps = 12;
			Starling.juggler.add(thruster);
			body = new MovieClip(_textureAtlas.getTextures("body"));
			weapon = new MovieClip(_textureAtlas.getTextures("weapon"));
			this.addChild(thruster);
			this.addChild(body);
			this.addChild(weapon);
		}
		
		private var rect:Rectangle;
		override public function getBoundRect():Rectangle 
		{
			if (!rect) {
				rect = new Rectangle(0, 0, 100, 100);
			}
			rect.x = this.mapX - 50;
			rect.y = this.mapY - 50;
			return rect;
		}
		
		public function moveForward(passedTime:Number = -1):void
		{
			if (passedTime == -1) {
				var distance:Number = this._speed;
			} else if (passedTime > 0) {
				distance = this._speed * (passedTime / 100); 
			} else {
				return;
			}
			var moveX:Number = Math.sin(this.rotation) * distance;
			var moveY:Number = Math.cos(this.rotation) * distance;
			this.mapX += moveX;
			if (moveX > 0) world.cpnMove(this, MoveDirection.RIGHT);
			else if (moveX < 0) world.cpnMove(this, MoveDirection.LEFT);
			this.mapY -= moveY;
			if (moveY > 0) world.cpnMove(this, MoveDirection.UP);
			else if (moveY < 0) world.cpnMove(this, MoveDirection.DOWN);
			//this.x = this.mapX;
			//this.y = this.mapY;
		}
		
		public function moveBack(passedTime:Number = -1):void
		{
			if (passedTime == -1) {
				var distance:Number = this._speed;
			} else if (passedTime > 0) {
				distance = this._speed * (passedTime / 100); 
			} else {
				return;
			}
			var moveX:Number = Math.sin(this.rotation) * distance;
			var moveY:Number = Math.cos(this.rotation) * distance;
			this.mapX -= moveX;
			if (moveX < 0) world.cpnMove(this, MoveDirection.RIGHT);
			else if (moveX > 0) world.cpnMove(this, MoveDirection.LEFT);
			this.mapY += moveY;
			if (moveY < 0) world.cpnMove(this, MoveDirection.DOWN);
			else if (moveY > 0) world.cpnMove(this, MoveDirection.UP);
			//this.x = this.mapX;
			//this.y = this.mapY;
		}
		
		public function turnLeft(passedTime:Number):void
		{
			if (passedTime == -1) {
				var degree:Number = this._turnSpeed;
			} else if (passedTime > 0) {
				degree = this._turnSpeed * (passedTime / 100) * _turnG; 
			} else {
				return;
			}
			this.rotation -= deg2rad(degree);
		}
		
		public function turnRight(passedTime:Number):void
		{
			if (passedTime == -1) {
				var degree:Number = this._turnSpeed;
			} else if (passedTime > 0) {
				degree = this._turnSpeed * (passedTime / 100) * _turnG; 
			} else {
				return;
			}
			this.rotation += deg2rad(degree);
		}
		
		override public function dispose():void {
			Commander.cancelExecutor(this);
			this.removeFromParent();
			super.dispose();
			
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
				moveDir = 1;
				this.moveForward(passedTime);
				thruster.play();
				//thruster.currentFrame = (thruster.currentFrame + 1) % thruster.numFrames;
			} else if (_isDownPressing) {
				this.moveBack(passedTime);
				thruster.play();
				//thruster.currentFrame = (thruster.currentFrame + 1) % thruster.numFrames;
				moveDir = -1;
			} else {
				moveDir = 0;
				thruster.stop();
			}
			
			if (_isLeftPressing) {
				this.turnLeft(passedTime);
			} else if (_isRightPressing) {
				this.turnRight(passedTime);
			}
			if (!_isLeftPressing && !_isRightPressing) {
				
				if (_isUpPressing) {
					//leftTrack.gotoAndStop((leftTrack.currentFrame + 1) % leftTrack.totalFrames+1);
					//rightTrack.gotoAndStop((rightTrack.currentFrame + 1) % rightTrack.totalFrames+1);
				} else if (_isDownPressing) {
					//leftTrack.gotoAndStop((leftTrack.currentFrame - 1 + leftTrack.totalFrames-1) % leftTrack.totalFrames+1);
					//rightTrack.gotoAndStop((rightTrack.currentFrame - 1 + rightTrack.totalFrames-1) % rightTrack.totalFrames+1);
				}
			} else if (_isLeftPressing) {
				if (_isUpPressing) {
					//rightTrack.gotoAndStop((rightTrack.currentFrame + 1) % rightTrack.totalFrames+1);
				} else if (_isDownPressing) {
					//leftTrack.gotoAndStop((leftTrack.currentFrame - 1 + leftTrack.totalFrames-1) % leftTrack.totalFrames+1);
				} else {
					//leftTrack.gotoAndStop((leftTrack.currentFrame - 1 + leftTrack.totalFrames-1) % leftTrack.totalFrames+1);
					//rightTrack.gotoAndStop((rightTrack.currentFrame + 1) % rightTrack.totalFrames+1);
				}
			} else if (_isRightPressing) {
				if (_isUpPressing) {
					//leftTrack.gotoAndStop((leftTrack.currentFrame + 1) % leftTrack.totalFrames+1);
				} else if (_isDownPressing) {
					//rightTrack.gotoAndStop((rightTrack.currentFrame - 1 + rightTrack.totalFrames-1) % rightTrack.totalFrames+1);
				} else {
					//leftTrack.gotoAndStop((leftTrack.currentFrame + 1) % leftTrack.totalFrames + 1);
					//rightTrack.gotoAndStop((rightTrack.currentFrame - 1 + rightTrack.totalFrames-1) % rightTrack.totalFrames+1);
				}
			}
			if (this._isFiring) {
				//if (barrel.currentFrame < barrel.totalFrames) {
					//barrel.nextFrame();
				//} else {
					//barrel.gotoAndStop(1);
					//this._isFiring = false;
				//}
			}
			if (this._isBarrelTurnLeft) {
				//this.barrel.rotation -= 1;
				weapon.rotation -= deg2rad(this._turnSpeed * (passedTime / 100) * _turnG);
			} else if (this._isBarrelTurnRight) {
				//this.barrel.rotation += 1;
				weapon.rotation += deg2rad(this._turnSpeed * (passedTime / 100) * _turnG);
			}
			//if (mapX != oldMapX || mapY != oldMapY) {
				//var hitCpn:BaseComponent = world.componentMove(this);
				//if (hitCpn) {
					//this.mapX = this.oldMapX;
					//this.mapY = this.oldMapY;
				//}
			//}
		}
		
	}

}