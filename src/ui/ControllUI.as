package ui 
{
	import com.alex.pattern.Commander;
	import component.World;
	import flash.display.Sprite;
	import flash.events.TouchEvent;
	import mx.resources.ResourceManagerImpl;
	import util.OrderConst;
	
	/**
	 * ...
	 * @author alexfeeling
	 */
	public class ControllUI extends Sprite 
	{
		
		private var _forwardBtn:Sprite;
		private var _backBtn:Sprite;
		private var _fireBtn:Sprite;
		
		private var _barrelTurnLeftBtn:Sprite;
		private var _barrelTurnRightBtn:Sprite;
		
		public function ControllUI() 
		{
			_forwardBtn = new Sprite();
			_forwardBtn.graphics.beginFill(0xffcc00, 0.5);
			_forwardBtn.graphics.drawRect(0, 0, 150, 150);
			_forwardBtn.graphics.endFill();
			_forwardBtn.x = 0;
			_forwardBtn.y = World.STAGE_HEIGHT - 150;
			this.addChild(_forwardBtn);
			_forwardBtn.addEventListener(TouchEvent.TOUCH_BEGIN, function (evt:TouchEvent):void { 
				Commander.sendOrder(OrderConst.KEY_UP_PRESSING);
			} );
			_forwardBtn.addEventListener(TouchEvent.TOUCH_ROLL_OUT, function (evt:TouchEvent):void {
				Commander.sendOrder(OrderConst.KEY_UP_RELEASE);
			});
			_forwardBtn.addEventListener(TouchEvent.TOUCH_END, function (evt:TouchEvent):void { 
				Commander.sendOrder(OrderConst.KEY_UP_RELEASE);
			} );
			
			_backBtn = new Sprite();
			_backBtn.graphics.beginFill(0x0000ff, 0.5);
			_backBtn.graphics.drawRect(0, 0, 150, 150);
			_backBtn.graphics.endFill();
			_backBtn.x = 150;
			_backBtn.y = World.STAGE_HEIGHT - 150;
			this.addChild(_backBtn);
			_backBtn.addEventListener(TouchEvent.TOUCH_BEGIN, function(evt:TouchEvent):void { 
				Commander.sendOrder(OrderConst.KEY_DOWN_PRESSING);
			});
			_backBtn.addEventListener(TouchEvent.TOUCH_ROLL_OUT, function(evt:TouchEvent):void {
				Commander.sendOrder(OrderConst.KEY_DOWN_RELEASE);
			});
			_backBtn.addEventListener(TouchEvent.TOUCH_END, function(evt:TouchEvent):void { 
				Commander.sendOrder(OrderConst.KEY_DOWN_RELEASE);
			} );
			
			_fireBtn = new Sprite();
			_fireBtn.graphics.beginFill(0xff0000, 0.5);
			_fireBtn.graphics.drawRect(0, 0, 150, 150);
			_fireBtn.graphics.endFill();
			_fireBtn.x = World.STAGE_WIDTH - 150;
			_fireBtn.y = World.STAGE_HEIGHT - 150;
			this.addChild(_fireBtn);
			_fireBtn.addEventListener(TouchEvent.TOUCH_BEGIN, function onTouchBegin(evt:TouchEvent):void { 
					Commander.sendOrder(OrderConst.BARREL_FIRE);
				} );
			
			_barrelTurnLeftBtn = new Sprite();
			_barrelTurnLeftBtn.graphics.beginFill(0x00ff00, 0.5);
			_barrelTurnLeftBtn.graphics.drawRect(0, 0, 100, 100);
			_barrelTurnLeftBtn.graphics.endFill();
			_barrelTurnLeftBtn.x = World.STAGE_WIDTH - 250;
			_barrelTurnLeftBtn.y = World.STAGE_HEIGHT - 100;
			this.addChild(_barrelTurnLeftBtn);
			_barrelTurnLeftBtn.addEventListener(TouchEvent.TOUCH_BEGIN, function (evt:TouchEvent):void { 
				Commander.sendOrder(OrderConst.BARREL_TURN_LEFT, true);
			} );
			_barrelTurnLeftBtn.addEventListener(TouchEvent.TOUCH_ROLL_OUT, function (evt:TouchEvent):void {
				Commander.sendOrder(OrderConst.BARREL_TURN_LEFT, false);
			});
			_barrelTurnLeftBtn.addEventListener(TouchEvent.TOUCH_END, function (evt:TouchEvent):void { 
				Commander.sendOrder(OrderConst.BARREL_TURN_LEFT, false);
			} );
			
			_barrelTurnRightBtn = new Sprite();
			_barrelTurnRightBtn.graphics.beginFill(0x00ff00, 0.5);
			_barrelTurnRightBtn.graphics.drawRect(0, 0, 100, 100);
			_barrelTurnRightBtn.graphics.endFill();
			_barrelTurnRightBtn.x = World.STAGE_WIDTH - 100;
			_barrelTurnRightBtn.y = World.STAGE_HEIGHT - 250;
			this.addChild(_barrelTurnRightBtn);
			_barrelTurnRightBtn.addEventListener(TouchEvent.TOUCH_BEGIN, function (evt:TouchEvent):void { 
				Commander.sendOrder(OrderConst.BARREL_TURN_RIGHT, true);
			} );
			_barrelTurnRightBtn.addEventListener(TouchEvent.TOUCH_ROLL_OUT, function (evt:TouchEvent):void {
				Commander.sendOrder(OrderConst.BARREL_TURN_RIGHT, false);
			});
			_barrelTurnRightBtn.addEventListener(TouchEvent.TOUCH_END, function (evt:TouchEvent):void { 
				Commander.sendOrder(OrderConst.BARREL_TURN_RIGHT, false);
			} );
			
		}
		
	}

}