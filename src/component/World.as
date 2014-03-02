package component 
{
	import animation.AnimationManager;
	import animation.IAnimation;
	import com.alex.pattern.IOrderExecutor;
	import controll.Controller;
	import flash.desktop.InteractiveIcon;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
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
			this.cacheAsBitmap = true;
			this.cacheAsBitmapMatrix = new Matrix();
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
			controllingTank.mapX = 400;
			controllingTank.mapY = 300;
			this.addComponent(controllingTank);
			
			this.x = World.STAGE_WIDTH >> 1;
			this.y = World.STAGE_HEIGHT - 200;
			
			//for (var i:int = 0; i < 50; i++) {
				var redTank:RedTank = new RedTank("red");
				redTank.mapX = Math.random() * STAGE_WIDTH;
				redTank.mapY = Math.random() * STAGE_HEIGHT;
				redTank.refreshXY();
				this.addComponent(redTank);
			//}
		}
		
		public function setMap(map:Map):void {
			this._map = map;
			this.addChild(map);
			this.setChildIndex(map, 0);
		}
		
		private var _emptyIdx:Array = [];
		public function addComponent(cpn:BaseComponent):Boolean {
			if (cpn.solid) {
				cpn.gridX = int(cpn.mapX / GRID_WIDTH);
				cpn.gridY = int(cpn.mapY / GRID_HEIGHT);
				var key:String = cpn.gridX + "@" + cpn.gridY;
				if (_allGrids[key] != null) {
					return false;
				}
				_allGrids[key] = cpn;
			}
			if (_emptyIdx.length > 0) {
				_allComponents[_emptyIdx.pop()] = cpn;
			} else {
				_allComponents.push(cpn);
			}
			this.addChild(cpn);
			
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xffcc00, 0.5);
			shape.graphics.drawRect(-50, -50, GRID_WIDTH, GRID_HEIGHT);
			shape.graphics.endFill();
			shape.x = cpn.gridX * GRID_WIDTH - controllingTank.mapX;
			shape.y = cpn.gridY * GRID_HEIGHT-controllingTank.mapY;
			this.addChild(shape);
			return true;
		}
		
		public function removeComponent(cpn:BaseComponent):Boolean {
			if (cpn.solid) {
				var key:String = cpn.gridX + "@" + cpn.gridY;
				if (_allGrids[key] == null) {
					return false;
				}
				_allGrids[key] = null;
				delete _allGrids[key];
			}
			var idx:int = _allComponents.indexOf(cpn);
			if (idx >= 0) {
				_allComponents[idx] = null;
				_emptyIdx.push(idx);
			}
			this.removeChild(cpn);
			return true;
		}
		
		public function componentMove(cpn:BaseComponent):BaseComponent {
			var newGridX:int = int(cpn.mapX / GRID_WIDTH);
			var newGridY:int = int(cpn.mapY / GRID_HEIGHT);
			if (cpn.moveDir == 1) {
				var rot:Number = cpn.rotation * cpn.moveDir;
			} else if (cpn.moveDir == -1) {
				rot = cpn.rotation + 180;
				rot = rot > 180?rot - 360:rot;
			}
			if (rot > 0 && rot < 90) {
				var idxList:Array = [0, -1, 1, -1, 1, 0];
			} else if (rot > 90 && rot < 180) {
				idxList = [1, 0, 1, 1, 0, 1];
			} else if (rot < 0 && rot > -90) {
				idxList = [0, -1, -1, -1, -1, 0];
			} else if (rot < -90) {
				idxList = [ -1, 0, -1, 1, 0, 1];
			} else if (rot == 0) {
				idxList = [ -1, -1, 0, -1, 1, -1];
			} else if (rot == 90) {
				idxList = [1, -1, 1, 0, 1, 1];
			} else if (rot == 180) {
				idxList = [ -1, 1, 0, 1, 1, 1];
			} else {
				idxList = [ -1, -1, -1, 0, -1, 1];
			}
			
			for (var i:int = 0; i < idxList.length; i += 2) {
				var tcpn:BaseComponent = _allGrids[(newGridX + idxList[i]) + "@" + (newGridY + idxList[i + 1])] as BaseComponent;
				if (tcpn && tcpn != cpn /*&& tcpn.hitTestObject(cpn)*/) {
					return tcpn;
				}
			}
			if (cpn.solid && (newGridX != cpn.gridX || newGridY != cpn.gridY)) {
				if (_allGrids[newGridX + "@" + newGridY]) throw "error";
				_allGrids[cpn.gridX + "@" + cpn.gridY] = null;
				_allGrids[newGridX + "@" + newGridY] = cpn;
			}
			cpn.gridX = newGridX;
			cpn.gridY = newGridY;
			cpn.oldMapX = cpn.mapX;
			cpn.oldMapY = cpn.mapY;
			return null;
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
					if (i > 0 && _allComponents[i]) {//i==0时是controllingTank
						_allComponents[i].refreshXY();
					}
				}
			}
			//return;
			this.rotation = -controllingTank.rotation;
			return;
			//if (!controllingTank.turning()) {
				//return;
			//}
			var angle:Number = 90 * Controller.instance.accX;
				//this.rotation = -angle;
			//} else {
				//angle = 0;
			//}
			this.rotation = int(-controllingTank.rotation + angle);
			trace("angle",angle,"world rotation", this.rotation);
			return;
			if (controllingTank.turning()) {
				//var angle:Number = 90 * Controller.instance.accX;
				//this.rotation = -controllingTank.rotation + angle;
			} else if (this.rotation != -controllingTank.rotation) {
				if (Math.abs(this.rotation + controllingTank.rotation) < 1) {
					this.rotation = -controllingTank.rotation;
				} else {
					if ((this.rotation + controllingTank.rotation + 360) % 360 > 180) 
					{
						var turnAngle:Number = (( -controllingTank.rotation - this.rotation + 360) % 360);
						if (turnAngle > 15) {
							this.rotation += turnAngle - 15;
						} else {
							this.rotation += 1;// turnAngle / 8;
						}
						//this.rotation += turnAngle / 4;
					} else {
						turnAngle = ((this.rotation + controllingTank.rotation + 360) % 360);
						if (turnAngle > 15) {
							this.rotation -= turnAngle - 15;
						} else {
							this.rotation -= 1;// turnAngle / 8;
						}
						//this.rotation -= turnAngle / 4;
					}
				}
			}
		}
		
	}

}