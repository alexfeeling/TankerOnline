package component 
{
	import animation.AnimationManager;
	import animation.IAnimation;
	import com.alex.pattern.IOrderExecutor;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author alex
	 */
	public class World extends Sprite implements IOrderExecutor, IAnimation
	{
		
		public static var STAGE_WIDTH:int = 0;
		public static var STAGE_HEIGHT:int = 0;
		
		public static var GRID_WIDTH:int = 100;
		public static var GRID_HEIGHT:int = 100;
		
		private static const COMMAND_HANDLER_NAME:String = "world";
		
		private var _map:Map;
		
		private var _allComponents:Vector.<BaseComponent>;
		public var controllingTank:ControlledTank;
		
		private var _angleSpeed:Number = 2;
		
		private var _allGrids:Dictionary;
		
		public function World() 
		{
			if (_instance) {
				throw "error";
			}
			_instance = this;
			init();
			AnimationManager.getInstance().addToAnimation(this);
		}
		
		private static var _instance:World;
		public static function get instance():World {
			if (_instance) return _instance;
			_instance = new World();
			return _instance;
		}
		
		private function init():void {
			_allComponents = new Vector.<BaseComponent>();
			_allGrids = new Dictionary();
			controllingTank = new ControlledTank("tank_1");
			controllingTank.x = 0;
			controllingTank.y = 0;
			controllingTank.mapX = 100;
			controllingTank.mapY = 100;
			this.addComponent(controllingTank);
			
			//var pos:Point = this.localToGlobal(new Point(controllingTank.x, controllingTank.y));
			this.x = (World.STAGE_WIDTH >> 1);// - pos.x;
			this.y = World.STAGE_HEIGHT - 200;
			
			var redTank:RedTank = new RedTank("red");
			redTank.mapX = 0;
			redTank.mapY = 0;
			redTank.refreshXY();
			this.addComponent(redTank);
		}
		
		public function setMap(map:Map):void {
			this._map = map;
			this.addChild(map);
			this.setChildIndex(map, 0);
		}
		
		private var _emptyIdx:Array = [];
		public function addComponent(cpn:BaseComponent):Boolean {
			var gridX:int = int(cpn.mapX / GRID_WIDTH);
			var gridY:int = int(cpn.mapY / GRID_HEIGHT);
			var key:String = gridX + "-" + gridY;
			if (_allGrids[key] != null) {
				return false;
			}
			_allGrids[key] = cpn;
			if (_emptyIdx.length > 0) {
				_allComponents[_emptyIdx.pop()] = cpn;
			} else {
				_allComponents.push(cpn);
			}
			this.addChild(cpn);
			return true;
		}
		
		public function removeComponent(cpn:BaseComponent):Boolean {
			var gridX:int = int(cpn.mapX / GRID_WIDTH);
			var gridY:int = int(cpn.mapY / GRID_HEIGHT);
			var key:String = gridX + "-" + gridY;
			if (_allGrids[key] == null) {
				return false;
			}
			_allGrids[key] = null;
			delete _allGrids[key];
			this.removeChild(cpn);
			var idx:int = _allComponents.indexOf(cpn);
			if (idx >= 0) {
				_allComponents[idx] = null;
				_emptyIdx.push(idx);
			}
			return true;
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
			for (var i:int = 0; i < _allComponents.length; i++) {
				if (_allComponents[i] != null) {
					_allComponents[i].gotoNextFrame(passedTime);
					if (i > 0) {//i==0时是controllingTank
						_allComponents[i].refreshXY();
					}
				}
			}
			if (this.rotation != -controllingTank.rotation) {
				if (Math.abs(this.rotation + controllingTank.rotation) < 1) {
					this.rotation = -controllingTank.rotation;
				} else {
					if ((this.rotation + controllingTank.rotation + 360) % 360 > 180) 
					{
						var turnAngle:Number = (( -controllingTank.rotation - this.rotation + 360) % 360);
						if (turnAngle > 30) {
							this.rotation += turnAngle - 30;
						} else {
							this.rotation+=turnAngle / 8;
						}
						//this.rotation += turnAngle / 4;
					} else {
						turnAngle = ((this.rotation + controllingTank.rotation + 360) % 360);
						if (turnAngle > 30) {
							this.rotation -= turnAngle - 30;
						} else {
							this.rotation -= turnAngle / 8;
						}
						//this.rotation -= turnAngle / 4;
					}
				}
			}
		}
		
	}

}