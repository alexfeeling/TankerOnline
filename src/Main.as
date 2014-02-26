package 
{
	import com.alex.pattern.Commander;
	import component.ControlledTank;
	import component.World;
	import controll.Controller;
	import flash.desktop.NativeApplication;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.sensors.Accelerometer;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import net.SocketManager;
	import ui.ControllUI;
	import util.OrderConst;
	import util.Stats;
	
	/**
	 * ...
	 * @author alexfeeling
	 */
	public class Main extends Sprite 
	{
		
		public var world:World;
		
		//public static var STAGE_WIDTH:int = 0;
		//public static var STAGE_HEIGHT:int = 0;
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			//stage.addEventListener(Event.ACTIVATE, init);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// entry point
			
			// new to AIR? please read *carefully* the readme.txt files!
			//init();
			SocketManager.instance.connectToServer();
		}
		
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
			
		}
		
		private function init():void {
			//STAGE_WIDTH = stage.fullScreenWidth;
			//STAGE_HEIGHT = stage.fullScreenHeight;
			World.STAGE_WIDTH = stage.fullScreenWidth;
			World.STAGE_HEIGHT = stage.fullScreenHeight;
			world = new World();
			this.addChild(world);
			//var btnSp:Sprite = new Sprite();
			//btnSp.graphics.beginFill(0xffcc00, 0.5);
			//btnSp.graphics.drawRect(0, 0, 200, 200);
			//btnSp.graphics.endFill();
			//btnSp.x = 0;
			//btnSp.y = stage.fullScreenHeight - 200;
			//this.stage.addChild(btnSp);
			//btnSp.addEventListener(TouchEvent.TOUCH_BEGIN, function onTouchBegin(evt:TouchEvent):void { 
				//Commander.sendOrder(OrderConst.KEY_UP_PRESSING);
			//} );
			//btnSp.addEventListener(TouchEvent.TOUCH_ROLL_OUT, function onTouchRollOut(evt:TouchEvent):void {
				//Commander.sendOrder(OrderConst.KEY_UP_RELEASE);
			//});
			//btnSp.addEventListener(TouchEvent.TOUCH_END, function onTouchEnd(evt:TouchEvent):void { 
				//Commander.sendOrder(OrderConst.KEY_UP_RELEASE);
			//} );
			//
			//btnSp = new Sprite();
			//btnSp.graphics.beginFill(0x0000ff, 0.5);
			//btnSp.graphics.drawRect(0, 0, 200, 200);
			//btnSp.graphics.endFill();
			//btnSp.x = 200;
			//btnSp.y = stage.fullScreenHeight - 200;
			//this.stage.addChild(btnSp);
			//btnSp.addEventListener(TouchEvent.TOUCH_BEGIN, function(evt:TouchEvent):void { 
				//Commander.sendOrder(OrderConst.KEY_DOWN_PRESSING);
			//});
			//btnSp.addEventListener(TouchEvent.TOUCH_ROLL_OUT, function(evt:TouchEvent):void {
				//Commander.sendOrder(OrderConst.KEY_DOWN_RELEASE);
			//});
			//btnSp.addEventListener(TouchEvent.TOUCH_END, function(evt:TouchEvent):void { 
				//Commander.sendOrder(OrderConst.KEY_DOWN_RELEASE);
			//} );
			//
			//btnSp = new Sprite();
			//btnSp.graphics.beginFill(0xff0000, 0.5);
			//btnSp.graphics.drawRect(0, 0, 200, 200);
			//btnSp.graphics.endFill();
			//btnSp.x = stage.fullScreenWidth - 200;
			//btnSp.y = stage.fullScreenHeight - 200;
			//this.stage.addChild(btnSp);
			//btnSp.addEventListener(TouchEvent.TOUCH_BEGIN, function onTouchBegin(evt:TouchEvent):void { 
					//Commander.sendOrder(OrderConst.BARREL_FIRE);
				//} );
			//
			var btnSp:Sprite = new Sprite();
			btnSp.graphics.beginFill(0xff0000, 0.5);
			btnSp.graphics.drawRect(0, 0, 100, 100);
			btnSp.graphics.drawRect(0, 300, 70, 70);
			btnSp.graphics.drawRect(100, 300, 60, 60);
			btnSp.graphics.drawRect(200, 400, 100, 50);
			btnSp.graphics.endFill();
			btnSp.x = 200;
			btnSp.y = 200;
			world.addChild(btnSp);
			
			new Controller(stage);
			this.addChild(new ControllUI());
			
			this.addChild(new Stats());
		}
		
	}
	
}