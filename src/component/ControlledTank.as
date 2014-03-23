package component 
{
	import com.alex.pattern.Commander;
	import com.alex.pattern.IOrderExecutor;
	import starling.textures.TextureAtlas;
	//import flash.display.MovieClip;
	import util.OrderConst;
	
	/**
	 * ...
	 * @author alex
	 */
	public class ControlledTank extends BaseTank
	{
		public function ControlledTank(vId:String, textureAtlas:TextureAtlas) 
		{
			super(vId, textureAtlas);
		}
		
		override protected function init():void 
		{
			super.init();
			thruster.pivotX = 100;
			thruster.pivotY = 100;
			body.pivotX = 74;
			body.pivotY = 85;
			weapon.pivotX = 64;
			weapon.pivotY = 185;
			this.scaleX = 0.5;
			this.scaleY = 0.5;
			this._speed = 20;
			this._turnSpeed = 10;
		}
		
		public function turning():Boolean {
			return this._isLeftPressing || this._isRightPressing;
		}
		
		override public function getExecuteOrderList():Array {
			return [
							OrderConst.KEY_UP_PRESSING,
							OrderConst.KEY_DOWN_PRESSING,
							OrderConst.KEY_LEFT_PRESSING,
							OrderConst.KEY_RIGHT_PRESSING,
							
							OrderConst.KEY_UP_RELEASE,
							OrderConst.KEY_DOWN_RELEASE,
							OrderConst.KEY_LEFT_RELEASE,
							OrderConst.KEY_RIGHT_RELEASE,
							
							OrderConst.BARREL_FIRE,
							OrderConst.BARREL_TURN_LEFT,
							OrderConst.BARREL_TURN_RIGHT
						];
		}
		
		override public function executeOrder(orderName:String, orderParam:Object = null):void {
			switch(orderName) {
				case OrderConst.KEY_UP_PRESSING:
					_isUpPressing = true;
					_isDownPressing = false;
					break;
				case OrderConst.KEY_DOWN_PRESSING:
					_isDownPressing = true;
					_isUpPressing = false;
					break;
				case OrderConst.KEY_LEFT_PRESSING:
					_isLeftPressing = true;
					_isRightPressing = false;
					if (orderParam) {
						_turnG = orderParam as Number;
					}
					break;
				case OrderConst.KEY_RIGHT_PRESSING:
					_isRightPressing = true;
					_isLeftPressing = false;
					if (orderParam) {
						_turnG = orderParam as Number;
					}
					break;
				case OrderConst.KEY_UP_RELEASE:
					_isUpPressing = false;
					break;
				case OrderConst.KEY_DOWN_RELEASE:
					_isDownPressing = false;
					break;
				case OrderConst.KEY_LEFT_RELEASE:
					_isLeftPressing = false;
					break;
				case OrderConst.KEY_RIGHT_RELEASE:
					_isRightPressing = false;
					break;
				case OrderConst.BARREL_FIRE:
					if (this._isFiring) break;
					this._isFiring = true;
					var rot:Number = this.rotation + this.weapon.rotation;
					var bx:Number = Math.sin(rot * Math.PI / 180) * 50;
					var by:Number = Math.cos(rot * Math.PI / 180) * 50;
					var bullet:Bullet = new Bullet(this.mapX + bx, this.mapY -by, rot);
					bullet.owner = this;
					world.addComponent(bullet);
					break;
				case OrderConst.BARREL_TURN_LEFT:
					if (orderParam) {
						this._isBarrelTurnLeft = true;
						this._isBarrelTurnRight = false;
					} else {
						this._isBarrelTurnLeft = false;
					}
					break;
				case OrderConst.BARREL_TURN_RIGHT:
					if (orderParam) {
						this._isBarrelTurnLeft = false;
						this._isBarrelTurnRight = true;
					} else {
						this._isBarrelTurnRight = false;
					}
					break;
			}
		}
		
	}

}