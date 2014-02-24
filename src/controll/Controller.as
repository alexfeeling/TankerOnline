package controll 
{
	import com.alex.pattern.Commander;
	import component.World;
	import flash.events.AccelerometerEvent;
	import flash.events.DRMReturnVoucherCompleteEvent;
	import flash.events.TouchEvent;
	import flash.sensors.Accelerometer;
	import util.OrderConst;
	//import component.BaseTank;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	//import 
	//import net.SocketManager;
	//import net.SocketPackage;
	//import pattern.OrderConst;
	//import pattern.Facade;
	/**
	 * ...
	 * @author alex
	 */
	public class Controller 
	{
		public static var KEY_UP:int = 87;
		public static var KEY_DOWN:int = 83;
		public static var KEY_LEFT:int = 65;
		public static var KEY_RIGHT:int = 68;
		
		public static var KEY_J:int = 74; 
		public static var KEY_K:int = 75;
		public static var KEY_L:int = 76;
		public static var KEY_I:int = 73;
		
		private var accelerometer:Accelerometer;
		
		private var stage:Stage;
					
		public function Controller(vStage:Stage) 
		{
			stage = vStage;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			//stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			//stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			if (Accelerometer.isSupported){
				accelerometer = new Accelerometer();
				accelerometer.addEventListener(AccelerometerEvent.UPDATE, onAcceleUpdate);
			}
		}
		
		private function onTouchBegin(evt:TouchEvent):void {
			if (evt.stageX <= 200 && evt.stageY >= World.STAGE_HEIGHT - 200) {
				Commander.sendOrder(OrderConst.KEY_UP_PRESSING);
			} else if (evt.stageX >= World.STAGE_WIDTH - 200 && 
						evt.stageY >= World.STAGE_HEIGHT - 200) 
			{
				Commander.sendOrder(OrderConst.BARREL_FIRE);
			}
		}
		
		private function onTouchEnd(evt:TouchEvent):void {
			if (evt.stageX <= 200 && evt.stageY >= World.STAGE_HEIGHT - 200) {
				Commander.sendOrder(OrderConst.KEY_UP_RELEASE);
			}
		}
		
		private function onAcceleUpdate(evt:AccelerometerEvent):void {
			if (Math.abs(evt.accelerationX) >= 0.1) {
				if (evt.accelerationX >= 0.1) {
					Commander.sendOrder(OrderConst.KEY_LEFT_PRESSING, Math.min(1, Math.abs(evt.accelerationX)*3));
				} else {
					Commander.sendOrder(OrderConst.KEY_RIGHT_PRESSING, Math.min(1, Math.abs(evt.accelerationX)*3));
				}
			} else {
				Commander.sendOrder(OrderConst.KEY_LEFT_RELEASE);
				Commander.sendOrder(OrderConst.KEY_RIGHT_RELEASE);
			}
		}
				
		private function onKeyDown(event:KeyboardEvent):void {
			switch(event.keyCode) {
				case KEY_UP:
					Commander.sendOrder(OrderConst.KEY_UP_PRESSING);
					break;
				case KEY_DOWN:
					Commander.sendOrder(OrderConst.KEY_DOWN_PRESSING);
					break;
				case KEY_LEFT:
					Commander.sendOrder(OrderConst.KEY_LEFT_PRESSING);
					break;
				case KEY_RIGHT:
					Commander.sendOrder(OrderConst.KEY_RIGHT_PRESSING);
					break;
				case KEY_I:
					Commander.sendOrder(OrderConst.BARREL_FIRE);
					//var pack:SocketPackage = new SocketPackage("tank_fire", { tankId:"main_role" } );
					//SocketManager.instance.sendPackage(pack);
					break;
				case KEY_J:
					Commander.sendOrder(OrderConst.BARREL_TURN_LEFT, true);
					break;
				case KEY_K:
					break;
				case KEY_L:
					Commander.sendOrder(OrderConst.BARREL_TURN_RIGHT, true);
					break;
			}
		}
		
		public function onKeyUp(event:KeyboardEvent):void {
			switch(event.keyCode) {
				case KEY_UP:
					Commander.sendOrder(OrderConst.KEY_UP_RELEASE);
					break;
				case KEY_DOWN:
					Commander.sendOrder(OrderConst.KEY_DOWN_RELEASE);
					break;
				case KEY_LEFT:
					Commander.sendOrder(OrderConst.KEY_LEFT_RELEASE);
					break;
				case KEY_RIGHT:
					Commander.sendOrder(OrderConst.KEY_RIGHT_RELEASE);
					break;
				case KEY_J:
					Commander.sendOrder(OrderConst.BARREL_TURN_LEFT, false);
					break;
				case KEY_L:
					Commander.sendOrder(OrderConst.BARREL_TURN_RIGHT, false);
					break;
			}
		}
			
	}

}