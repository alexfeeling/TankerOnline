package 
{
	import com.alex.pattern.Commander;
	import component.ControlledTank;
	import component.World;
	import controll.Controller;
	import flash.desktop.NativeApplication;
	import flash.display.Shape;
	import flash.display3D.VertexBuffer3D;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.sensors.Accelerometer;
	import flash.system.System;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import game.Game;
	import game.StarlingGame;
	import map.WorldMap;
	import net.SocketManager;
	import starling.core.Starling;
	import ui.ControllUI;
	import util.OrderConst;
	import util.Stats;
	
	/**
	 * ...
	 * @author alexfeeling
	 */
	public class Main extends Sprite 
	{
		
		
		public function Main():void 
		{
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// entry point
			
			// new to AIR? please read *carefully* the readme.txt files!
			init();
			//SocketManager.instance.connectToServer();
		}
		
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
			//System.exit(0);
		}
		
		private function init():void {
			World.STAGE_WIDTH = stage.fullScreenWidth;
			World.STAGE_HEIGHT = stage.fullScreenHeight;
			
			new Controller(stage);
			this.addChild(new ControllUI());
			
			//this.addChild(new WorldMap());
			this.addChild(new Stats());
			//this.addChild(new DatagramSocketExample());
			
			var starling:Starling = new Starling(Game, stage, new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight));
			starling.showStatsAt("center");
			starling.start();
			
		}
		
		
		
	}
	
}