package component 
{
	import com.alex.animation.AnimationManager;
	import com.alex.animation.IAnimation;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author alexfeeling
	 */
	public class Bullet extends BaseComponent implements IAnimation
	{
		
		private var _speed:int = 3;
		
		public var owner:BaseComponent;
		
		public function Bullet(bx:int, by:int, angle:Number) 
		{
			this.id = "bul";
			//var shape:Shape = new Shape();
			//shape.graphics.beginFill(0xff0000);
			//shape.graphics.drawCircle(0, 0, 10);
			//shape.graphics.endFill();
			//this.addChild(shape);
			var image:Image = new Image(getBulletTexture());
			image.pivotX = 10;
			image.pivotY = 10;
			this.mapX = bx;
			this.mapY = by;
			this.rotation = angle;
			moveDir = 1;
			this.solid = false;
			//bounds = new Rectangle(this.mapX, this.mapY, 10, 10);
		}
		
		private static var _bulletTexture:Texture;
		public static function getBulletTexture():Texture {
			if (!_bulletTexture) 
				_bulletTexture = Texture.fromColor(20, 20, 0xff0000);
			return _bulletTexture;
		}
		
		override public function getBoundRect():Rectangle 
		{
			bounds.x = this.mapX - 5;
			bounds.y = this.mapY - 5;
			return bounds;
		}
		
		//override public function isPlayEnd():Boolean {
			//var pos:Point = this.parent.localToGlobal(new Point(this.x, this.y));
			//if (Math.abs(pos.x) > World.STAGE_WIDTH || Math.abs(pos.y) > World.STAGE_HEIGHT) 
			//{
				//this.parent.removeChild(this);
				//return true;
			//}
			//return false;
		//}
		
		override public function refreshXY():void 
		{
			super.refreshXY();
			if (Math.abs(this.x) > World.STAGE_WIDTH || Math.abs(this.y) > World.STAGE_HEIGHT)
			{
				this.world.removeComponent(this);
			}
		}
		
		override public function updateTime(passedTime:Number):void {
			if (passedTime == -1) {
				var distance:Number = this._speed;
			} else if (passedTime > 0) {
				distance = this._speed * (passedTime / 60); 
			} else {
				return;
			}
			
			//var moveX:Number = Math.sin(this.rotation * Math.PI / 180) * distance;
			//var moveY:Number = Math.cos(this.rotation * Math.PI / 180) * distance;
			//this.mapX += moveX;
			//this.mapY -= moveY;
			//if (mapX != oldMapX || mapY != oldMapY) {
				//var hitCpn:BaseComponent = world.componentMove(this);
				//if (hitCpn && hitCpn != this.owner) {
					//this.mapX = this.oldMapX;
					//this.mapY = this.oldMapY;
					//hitCpn.hitedBy(this);
					//world.removeComponent(this);
				//}
			//}
			
		}
		
	}

}