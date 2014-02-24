package component 
{
	import animation.AnimationManager;
	import animation.IAnimation;
	import com.alex.pattern.IOrderExecutor;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author alex
	 */
	public class World extends Sprite implements IOrderExecutor, IAnimation
	{
		
		public static var STAGE_WIDTH:int = 0;
		public static var STAGE_HEIGHT:int = 0;
		
		private static const COMMAND_HANDLER_NAME:String = "world";
		
		private var _map:Map;
		
		private var _allComponents:Vector.<IComponent>;
		private var _controllingTank:ControlledTank;
		
		private var _angleSpeed:Number = 2;
		
		public function World() 
		{
			init();
			AnimationManager.getInstance().addToAnimation(this);
		}
		
		private function init():void {
			_allComponents = new Vector.<IComponent>();
			
			_controllingTank = new ControlledTank("tank_1");
			_controllingTank.x = 450;
			_controllingTank.y = 300;
			this.addChild(_controllingTank);
			var pos:Point = this.localToGlobal(new Point(_controllingTank.x, _controllingTank.y));
			this.x = (World.STAGE_WIDTH >> 1) - pos.x;
			this.y = (World.STAGE_HEIGHT >> 1) - pos.y;
			
			this.addChild(new RedTank("red"));
		}
		
		public function setMap(map:Map):void {
			this._map = map;
			this.addChild(map);
			this.setChildIndex(map, 0);
		}
		
		public function addComponent(component:IComponent):void {
			_allComponents.push(component);
			this.addChild(component as DisplayObject);
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
			return COMMAND_HANDLER_NAME;
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
			if (this.rotation != -_controllingTank.rotation) {
				if (Math.abs(this.rotation + _controllingTank.rotation) < 1) {
					this.rotation = -_controllingTank.rotation;
				} else {
					if ((this.rotation + _controllingTank.rotation + 360) % 360 > 180) 
					{
						var turnAngle:Number = (( -_controllingTank.rotation - this.rotation + 360) % 360);
						if (turnAngle > 30) {
							this.rotation += turnAngle - 30;
						} else {
							this.rotation+=turnAngle / 8;
						}
						//this.rotation += turnAngle / 4;
					} else {
						turnAngle = ((this.rotation + _controllingTank.rotation + 360) % 360);
						if (turnAngle > 30) {
							this.rotation -= turnAngle - 30;
						} else {
							this.rotation -= turnAngle / 8;
						}
						//this.rotation -= turnAngle / 4;
					}
					//trace("turnAngle", turnAngle);
				}
				var gpos:Point = this.localToGlobal(new Point(_controllingTank.x, _controllingTank.y));
				this.x += (World.STAGE_WIDTH >> 1) - gpos.x;
				this.y += (World.STAGE_HEIGHT >> 1) - gpos.y;
			}
		}
		
	}

}