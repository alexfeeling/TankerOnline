package component 
{
	import com.alex.animation.AnimationManager;
	import com.alex.animation.IAnimation;
	import com.alex.pattern.Commander;
	import com.alex.pattern.IOrderExecutor;
	import controll.Controller;
	import flash.desktop.InteractiveIcon;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	import texture.TextureManager;
	import util.MoveDirection;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import util.OrderConst;
	
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
		
		private var _mostLeftCpn:BaseComponent;
		private var _mostRightCpn:BaseComponent;
		private var _mostUpCpn:BaseComponent;
		private var _mostDownCpn:BaseComponent;
		
		private var _mostRcpn4Rbod:BaseComponent;
		private var _mostLcpn4Lbod:BaseComponent;
		private var _mostDcpn4Dbod:BaseComponent;
		private var _mostUcpn4Ubod:BaseComponent;
		
		private var _angleSpeed:Number = 2;
		
		private var _allGrids:Dictionary;
		
		public function World() 
		{
			if (_instance) {
				throw "error";
			}
			_instance = this;
			init();
			AnimationManager.addToAnimationList(this);
			Commander.registerExecutor(this);
		}
		
		private static var _instance:World;
		public static function get instance():World {
			if (_instance) return _instance;
			_instance = new World();
			return _instance;
		}
		
		private function init():void {
			this.touchable = false;
			_allComponents = new Vector.<BaseComponent>();
			_allGrids = new Dictionary();
			
			//this.x = World.STAGE_WIDTH >> 1;
			//this.y = World.STAGE_HEIGHT - 200;
			
		}
		
		public function cpnMove(cpn:BaseComponent, dir:int/*, distance:Number*/):void {
			var upCpn:BaseComponent;
			var downCpn:BaseComponent;
			var veryUpCpn:BaseComponent;
			var veryDownCpn:BaseComponent;
			var leftCpn:BaseComponent;
			var veryLeftCpn:BaseComponent;
			var rightCpn:BaseComponent;
			var veryRightCpn:BaseComponent;
			switch(dir) {
				case MoveDirection.UP:
					upCpn = cpn.upCpn4DownBd;
					while (upCpn) {
						if (upCpn.getBoundRect().bottom > cpn.getBoundRect().top) {
							if (upCpn.getBoundRect().bottom > cpn.getBoundRect().bottom) {
								//switch 
								veryUpCpn = upCpn.upCpn4DownBd;
								upCpn.upCpn4DownBd = cpn;
								cpn.upCpn4DownBd = veryUpCpn;
								if (cpn == _mostDcpn4Dbod) _mostDcpn4Dbod = upCpn;
								upCpn = veryUpCpn;
							} else if (upCpn.getBoundRect().intersects(cpn.getBoundRect())) {
								//hit
								cpn.mapY = upCpn.getBoundRect().bottom + (cpn.getBoundRect().height >> 1);
								break;
							} else break;
						} else break;
					}
					downCpn = cpn.downCpn4UpBd;
					while (downCpn) {
						if (downCpn.getBoundRect().top < cpn.getBoundRect().top) {
							veryDownCpn = downCpn.downCpn4UpBd;
							downCpn.downCpn4UpBd = cpn;
							cpn.downCpn4UpBd = veryDownCpn;
							if (cpn == _mostUcpn4Ubod) _mostUcpn4Ubod = downCpn;
							downCpn = veryDownCpn;
						} else break;
					}
					break;
				case MoveDirection.DOWN:
					downCpn = cpn.downCpn4UpBd;
					while (downCpn) {
						if (downCpn.getBoundRect().top < cpn.getBoundRect().bottom) {
							if (downCpn.getBoundRect().top < cpn.getBoundRect().top) {
								//switch
								veryDownCpn = downCpn.downCpn4UpBd;
								downCpn.downCpn4UpBd = cpn;
								cpn.downCpn4UpBd = veryDownCpn;
								if (cpn == _mostUcpn4Ubod) _mostUcpn4Ubod = downCpn;
								downCpn = veryDownCpn;
							} else if (downCpn.getBoundRect().intersects(cpn.getBoundRect())) {
								cpn.mapY = downCpn.getBoundRect().top - (cpn.getBoundRect().height >> 1);
								break;
							} else break;
						} else break;
					}
					upCpn = cpn.upCpn4DownBd;
					while (upCpn) {
						if (upCpn.getBoundRect().bottom > cpn.getBoundRect().bottom) {
							veryUpCpn = upCpn.upCpn4DownBd;
							upCpn.upCpn4DownBd = cpn;
							cpn.upCpn4DownBd = veryUpCpn;
							if (cpn == _mostDcpn4Dbod) _mostDcpn4Dbod = upCpn;
							upCpn = veryUpCpn;
						} else break;
					}
					break;
				case MoveDirection.LEFT:
					leftCpn = cpn.leftCpn4RightBd;
					while (leftCpn) {
						if (leftCpn.getBoundRect().right > cpn.getBoundRect().left) {
							if (leftCpn.getBoundRect().right > cpn.getBoundRect().right) {
								//switch
								veryLeftCpn = leftCpn.leftCpn4RightBd;
								leftCpn.leftCpn4RightBd = cpn;
								cpn.leftCpn4RightBd = veryLeftCpn;
								if (cpn == _mostRcpn4Rbod) _mostRcpn4Rbod = leftCpn;
								leftCpn = veryLeftCpn;
							} else if (leftCpn.getBoundRect().intersects(cpn.getBoundRect())) {
								cpn.mapX = leftCpn.getBoundRect().right + (cpn.getBoundRect().width >> 1);
								break;
							} else break;
						} else break;
					}
					rightCpn = cpn.rightCpn4LeftBd;
					while (rightCpn) {
						if (rightCpn.getBoundRect().left < cpn.getBoundRect().left) {
							veryRightCpn = rightCpn.rightCpn4LeftBd;
							rightCpn.rightCpn4LeftBd = cpn;
							cpn.rightCpn4LeftBd = veryRightCpn;
							if (cpn == _mostLcpn4Lbod) _mostLcpn4Lbod = cpn;
							rightCpn = veryRightCpn;
						} else break;
					}
					break;
				case MoveDirection.RIGHT:
					rightCpn = cpn.rightCpn4LeftBd;
					while (rightCpn) {
						if (rightCpn.getBoundRect().left < cpn.getBoundRect().right) {
							if (rightCpn.getBoundRect().left < cpn.getBoundRect().left) {
								//switch
								veryRightCpn = rightCpn.rightCpn4LeftBd;
								rightCpn.rightCpn4LeftBd = cpn;
								cpn.rightCpn4LeftBd = veryRightCpn;
								if (cpn == _mostLcpn4Lbod) _mostLcpn4Lbod = rightCpn;
								rightCpn = veryRightCpn;
							} else if (rightCpn.getBoundRect().intersects(cpn.getBoundRect())) {
								cpn.mapX = rightCpn.getBoundRect().left - (cpn.getBoundRect().width >> 1);
								break;
							} else break;
						} else break;
					}
					leftCpn = cpn.leftCpn4RightBd;
					while (leftCpn) {
						if (leftCpn.getBoundRect().right > cpn.getBoundRect().right) {
							veryLeftCpn = leftCpn.leftCpn4RightBd;
							leftCpn.leftCpn4RightBd = cpn;
							cpn.leftCpn4RightBd = veryLeftCpn;
							if (cpn == _mostRcpn4Rbod) _mostRcpn4Rbod == cpn;
							leftCpn = veryLeftCpn;
						} else break;
					}
					break;
			}
			cpn.x = cpn.mapX;
			cpn.y = cpn.mapY;
		}
		
		public function componentMove(cpn:BaseComponent):void {
			
		}
		
		private var _emptyIdx:Array = [];
		private var _id:String = "world";
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
			if (cpn != controllingTank) {
				var leftCpnLeftBod:BaseComponent = _mostLcpn4Lbod;
				while (leftCpnLeftBod) {
					if (leftCpnLeftBod.getBoundRect().left < cpn.getBoundRect().left) {
						if (leftCpnLeftBod.rightCpn4LeftBd == null) {
							leftCpnLeftBod.rightCpn4LeftBd = cpn;
						} else if (leftCpnLeftBod.rightCpn4LeftBd.getBoundRect().left > cpn.getBoundRect().left) {
							cpn.rightCpn4LeftBd = leftCpnLeftBod.rightCpn4LeftBd;
							leftCpnLeftBod.rightCpn4LeftBd = cpn;
						} else {
							leftCpnLeftBod = leftCpnLeftBod.rightCpn4LeftBd;
							continue;
						}
					} else {
						cpn.rightCpn4LeftBd = leftCpnLeftBod;
						if (cpn.rightCpn4LeftBd == _mostLcpn4Lbod) _mostLcpn4Lbod = cpn;
					}
					break;
				}
				var rightCpnRightBod:BaseComponent = _mostRcpn4Rbod;
				while (rightCpnRightBod) {
					if (rightCpnRightBod.getBoundRect().right > cpn.getBoundRect().right) {
						if (rightCpnRightBod.leftCpn4RightBd == null) {
							rightCpnRightBod.leftCpn4RightBd = cpn;
						} else if (rightCpnRightBod.leftCpn4RightBd.getBoundRect().right < cpn.getBoundRect().right) {
							cpn.leftCpn4RightBd = rightCpnRightBod.leftCpn4RightBd;
							rightCpnRightBod.leftCpn4RightBd = cpn;
						} else {
							rightCpnRightBod = rightCpnRightBod.leftCpn4RightBd;
							continue;
						}
					} else {
						cpn.leftCpn4RightBd = rightCpnRightBod;
						if (cpn.leftCpn4RightBd == _mostRcpn4Rbod) _mostRcpn4Rbod = cpn;
					}
					break;
				}
				var upCpnUpBod:BaseComponent = _mostUcpn4Ubod;
				while (upCpnUpBod) {
					if (upCpnUpBod.getBoundRect().top < cpn.getBoundRect().top) {
						if (upCpnUpBod.downCpn4UpBd == null) {
							upCpnUpBod.downCpn4UpBd = cpn;
						} else if (upCpnUpBod.downCpn4UpBd.getBoundRect().top < cpn.getBoundRect().top) {
							cpn.downCpn4UpBd = upCpnUpBod.downCpn4UpBd;
							upCpnUpBod.downCpn4UpBd = cpn;
						} else {
							upCpnUpBod = upCpnUpBod.downCpn4UpBd;
							continue;
						}
					} else {
						cpn.downCpn4UpBd = upCpnUpBod;
						if (cpn.downCpn4UpBd == _mostUcpn4Ubod) _mostUcpn4Ubod = cpn;
					}
					break;
				}
				var downCpnDownBod:BaseComponent = _mostDcpn4Dbod;
				while (downCpnDownBod) {
					if (downCpnDownBod.getBoundRect().bottom > cpn.getBoundRect().bottom) {
						if (downCpnDownBod.upCpn4DownBd == null) {
							downCpnDownBod.upCpn4DownBd = cpn;
						} else if (downCpnDownBod.upCpn4DownBd.getBoundRect().bottom > cpn.getBoundRect().bottom) {
							cpn.upCpn4DownBd = downCpnDownBod.upCpn4DownBd;
							downCpnDownBod.upCpn4DownBd = cpn;
						} else {
							downCpnDownBod = downCpnDownBod.upCpn4DownBd;
							continue;
						}
					} else {
						cpn.upCpn4DownBd = downCpnDownBod;
						if (cpn.upCpn4DownBd == _mostDcpn4Dbod) _mostDcpn4Dbod = cpn;
					}
					break;
				}
			} else {
				_mostRcpn4Rbod = controllingTank;
				_mostLcpn4Lbod = controllingTank;
				_mostDcpn4Dbod = controllingTank;
				_mostUcpn4Ubod = controllingTank;
			}
			//var shape:Shape = new Shape();
			//shape.graphics.beginFill(0xffcc00, 0.5);
			//shape.graphics.drawRect(-50, -50, GRID_WIDTH, GRID_HEIGHT);
			//shape.graphics.endFill();
			//shape.x = cpn.gridX * GRID_WIDTH - controllingTank.mapX;
			//shape.y = cpn.gridY * GRID_HEIGHT-controllingTank.mapY;
			//this.addChild(shape);
			cpn.x = cpn.mapX;
			cpn.y = cpn.mapY;
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
		
		/*
		 * public function componentMove(cpn:BaseComponent):BaseComponent {
			var newGridX:int = int(cpn.mapX / GRID_WIDTH);
			var newGridY:int = int(cpn.mapY / GRID_HEIGHT);
			if (cpn.moveDir == 1) {
				var rot:Number = cpn.rotation * cpn.moveDir;
			} else if (cpn.moveDir == -1) {
				rot = cpn.rotation + 180;
				rot = rot > 180?rot - 360:rot;
			}
			
			if (rot > 0 && rot < 90) {
				var idxList:Array = [ -1, -1, 0, -1, 1, -1, 1, 0, 1, 1];
			} else if (rot > 90 && rot < 180) {
				idxList = [1, -1, 1, 0, 1, 1, 0, 1, -1, 1];
			} else if (rot < 0 && rot > -90) {
				idxList = [1, -1, 0, -1, -1, -1, -1, 0, -1, 1];
			} else if (rot < -90) {
				idxList = [ -1, -1, -1, 0, -1, 1, 0, 1, 1, 1];
			} else if (rot == 0) {
				idxList = [ -1, -1, 0, -1, 1, -1];
			} else if (rot == 90) {
				idxList = [1, -1, 1, 0, 1, 1];
			} else if (rot == 180) {
				idxList = [ -1, 1, 0, 1, 1, 1];
			} else {
				idxList = [ -1, -1, -1, 0, -1, 1];
			}
			
			if (cpn.solid) {
				idxList.push(0, 0);
			}
			
			for (var i:int = 0; i < idxList.length; i += 2) {
				var tcpn:BaseComponent = _allGrids[(newGridX + idxList[i]) + "@" + (newGridY + idxList[i + 1])] as BaseComponent;
				if (tcpn && tcpn != cpn ) {
					if (tcpn.getBoundRect().intersects(cpn.getBoundRect()))
						return tcpn;
				}
			}
			if (cpn.solid && (newGridX != cpn.gridX || newGridY != cpn.gridY)) {
				if (_allGrids[newGridX + "@" + newGridY]) {
					cpn.mapX = cpn.oldMapX;
					cpn.mapY = cpn.oldMapY;
					return null;
				} else {
					_allGrids[cpn.gridX + "@" + cpn.gridY] = null;
					_allGrids[newGridX + "@" + newGridY] = cpn;
				}
			}
			cpn.gridX = newGridX;
			cpn.gridY = newGridY;
			cpn.oldMapX = cpn.mapX;
			cpn.oldMapY = cpn.mapY;
			return null;
		}
		*/
		
		/* INTERFACE com.alex.pattern.IOrderExecutor */
		
		public function getExecuteOrderList():Array 
		{
			return [OrderConst.ALL_LOAD_COMPLETE];
		}
		
		public function executeOrder(orderName:String, orderParam:Object = null):void 
		{
			switch(orderName) {
				case OrderConst.ALL_LOAD_COMPLETE:
					var ttat:TextureAtlas = TextureManager.getTexture("tank_1");
					controllingTank = new ControlledTank("tank_1", ttat);
					controllingTank.mapX = 500;
					controllingTank.mapY = 500;
					this.addComponent(controllingTank);
					var e1:EnemyTank = new EnemyTank("e1", ttat);
					e1.mapX = 200;
					e1.mapY = 200;
					this.addComponent(e1);
					break;
			}
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
						//_allComponents[i].refreshXY();
					}
				}
			}
			return;
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
		
		/* INTERFACE com.alex.animation.IAnimation */
		
		public function get id():String 
		{
			return _id;
		}
		
	}

}