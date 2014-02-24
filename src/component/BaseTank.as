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
	public class BaseTank extends Sprite implements IComponent, IOrderExecutor, IAnimation
	{
		
		protected var _id:String;
		//protected var _ui:Sprite;
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
		
		public function BaseTank(vId:String)
		{
			this.setId(vId);
			this.init();
			Commander.registerExecutor(this);
			AnimationManager.getInstance().addToAnimation(this);
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
			this.x += moveX;
			this.y -= moveY;
			var orginPos:Point = new Point(this.x, this.y);
			var gpos:Point = this.parent.localToGlobal(orginPos);
			//this.parent.x = (Main.STAGE_WIDTH >> 1) - gpos.x+this.parent.x;
			//this.parent.y = (Main.STAGE_HEIGHT >> 1) - gpos.y + this.parent.y;
			
			//var a:Number = Math.atan2(this.y, this.x);
			//var l:Number = this.x / Math.cos(a);
			//var newX:Number = l * Math.cos(a + this.parent.rotation * Math.PI / 180);
			//var newY:Number = l * Math.sin(a + this.parent.rotation * Math.PI / 180);
			//this.parent.x = int((Main.STAGE_WIDTH >> 1) - newX);
			//this.parent.y = int((Main.STAGE_HEIGHT >> 1) - newY);
			this.parent.x = (World.STAGE_WIDTH >> 1) - gpos.x + this.parent.x;
			this.parent.y = (World.STAGE_HEIGHT >> 1) - gpos.y + this.parent.y;
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
			this.x -= moveX;
			this.y += moveY;
			var gpos:Point = this.parent.localToGlobal(new Point(this.x, this.y));
			this.parent.x = (World.STAGE_WIDTH >> 1) - gpos.x + this.parent.x;
			this.parent.y = (World.STAGE_HEIGHT >> 1) - gpos.y + this.parent.y;
			
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
			//this.parent.rotation = -this.rotation;
			//var a:Number = Math.atan2(this.y, this.x);
			//var l:Number = Math.sqrt(this.x * this.x + this.y * this.y);// this.x / Math.cos(a);
			//var newX:Number = l * Math.cos(a + this.parent.rotation * Math.PI / 180);
			//var newY:Number = l * Math.sin(a + this.parent.rotation * Math.PI / 180);
			//this.parent.x = (Main.STAGE_WIDTH >> 1) - newX;
			//this.parent.y = (Main.STAGE_HEIGHT >> 1) - newY;
			var gpos:Point = this.parent.localToGlobal(new Point(this.x, this.y));
			//trace(newX - gpos.x + this.parent.x, newY - gpos.y + this.parent.y);
			this.parent.x += (World.STAGE_WIDTH >> 1) - gpos.x;
			this.parent.y += (World.STAGE_HEIGHT >> 1) - gpos.y;
			
			
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
			//this.parent.rotation = -this.rotation;// -= degree;
			var gpos:Point = this.parent.localToGlobal(new Point(this.x, this.y));
			this.parent.x = (World.STAGE_WIDTH >> 1) - gpos.x + this.parent.x;
			this.parent.y = (World.STAGE_HEIGHT >> 1) - gpos.y + this.parent.y;
		}
		
		//实现接口的方法
		public function getId():String
		{
			return this._id;
		}
		
		public function setId(vId:String):void
		{
			this._id = getQualifiedClassName(this) + vId;
			this.name = this._id;
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
			return this._id;
		}
		
		/* INTERFACE animation.IAnimation */
		
		public function isPause():Boolean 
		{
			return false;
		}
		
		public function isPlayEnd():Boolean 
		{
			return false;
		}
		
		public function gotoNextFrame(passedTime:Number):void 
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
				this.barrel.rotation -= 1;// Math.PI / 3;
			} else if (this._isBarrelTurnRight) {
				this.barrel.rotation += 1;// Math.PI / 3;
			}
		}
	
	}

}