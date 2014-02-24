package component 
{
	import animation.AnimationManager;
	import animation.IAnimation;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author alexfeeling
	 */
	public class Bullet extends Sprite implements IAnimation
	{
		
		private var _speed:int = 5;
		
		public function Bullet(bx:int, by:int, angle:Number) 
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xff0000);
			shape.graphics.drawCircle(0, 0, 10);
			shape.graphics.endFill();
			this.addChild(shape);
			this.x = bx;
			this.y = by;
			this.rotation = angle;
			AnimationManager.getInstance().addToAnimation(this);
		}
		
		public function isPause():Boolean {
			return false;
		}
		
		public function isPlayEnd():Boolean {
			var pos:Point = this.parent.localToGlobal(new Point(this.x, this.y));
			if (pos.x < 0 || pos.x > World.STAGE_WIDTH || 
				pos.y < 0 || pos.y > World.STAGE_HEIGHT) 
			{
				this.parent.removeChild(this);
				return true;
			}
			return false;
		}
		
		public function gotoNextFrame(passedTime:Number):void {
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
			
		}
		
	}

}