package game 
{
	import com.alex.animation.AnimationManager;
	import component.World;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import loader.SpriteSheetLoader;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;
	import starling.utils.deg2rad;
	
	/**
	 * ...
	 * @author alexfeeling
	 */
	public class Game extends Sprite 
	{
		
		public var blue_tank_bmd:BitmapData;
		public var blue_tank_xml:XML;
		
		public var world:World;
		
		public function Game() 
		{
			//var loader:Loader = new Loader();
			//loader.name = "blue_tank.png";
			//loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			//loader.load(new URLRequest("/assets/tank.png"));
			//
			//var urlLoader:URLLoader = new URLLoader();
			//urlLoader.addEventListener(Event.COMPLETE, onURLLoadComplete);
			//urlLoader.load(new URLRequest("/assets/tank.xml"));
				
			//new SpriteSheetLoader("tank_1", "tank/tank_source.png", "tank/tank_source.xml");
			var gameLoader:GameLoader = new GameLoader();
			gameLoader.addSpriteSheetLoader("tank_1", "tank/tank_source.png", "tank/tank_source.xml");
			gameLoader.start();
			
			world = new World();
			this.addChild(world);
			
			AnimationManager.startUp(30);
		}
		
		
		
		//private function onLoadComplete(evt:Event):void {
			//var loaderInfo:LoaderInfo = evt.target as LoaderInfo;
			//blue_tank_bmd = (loaderInfo.content as Bitmap).bitmapData;
			//createTank();
		//}
		//
		//private function onURLLoadComplete(evt:Event):void {
			//blue_tank_xml = XML(evt.target.data);
			//createTank();
		//}
		//
		//private function createTank():void {
			//if (blue_tank_bmd && blue_tank_xml) {
				//var textureAtals:TextureAtlas = new TextureAtlas(Texture.fromBitmapData(blue_tank_bmd, true), blue_tank_xml);
				//var trackerTextureList:Vector.<Texture> =  textureAtals.getTextures("tracker");
				//var bodyTexture:Texture = textureAtals.getTexture("body");
				//var tracker:MovieClip = new MovieClip(trackerTextureList);
				//tracker.pivotX = 35;
				//tracker.pivotY = 42;
				//tracker.fps = 8;
				//var body:Image = new Image(bodyTexture);
				//body.pivotX = 25;
				//body.pivotY = 62;
				//var tank:Sprite = new Sprite();
				//tank.addChild(tracker);
				//tank.addChild(body);
				//tank.x = 200;
				//tank.y = 300;
				//tank.rotation = deg2rad(30);
				//tracker.play();
				//tracker.smoothing = TextureSmoothing.BILINEAR;
				//this.addChild(tank);
				//Starling.juggler.add(tracker);
				//
				//
				//var pinkTank:Image = new Image(textureAtals.getTexture("pink_tank"));
				//pinkTank.pivotX = 38;
				//pinkTank.pivotY = 67;
				//pinkTank.x = 400;
				//pinkTank.y = 400;
				//this.addChild(pinkTank);
			//}
		//}
		
	}

}