package map 
{
	import animation.AnimationManager;
	import animation.IAnimation;
	import component.RedTank;
	import component.World;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author alexfeeling
	 */
	public class WorldMap extends Bitmap implements IAnimation
	{
		
		private var _allMapBlock:Dictionary;
		
		private var _stageRect:Rectangle;
		
		private var redTank:RedTank;
		
		public function WorldMap() 
		{
			_allMapBlock = new Dictionary();
			
			_stageRect = new Rectangle(0, 0, World.STAGE_WIDTH, World.STAGE_HEIGHT);
			
			this.bitmapData = new BitmapData(World.STAGE_WIDTH, World.STAGE_HEIGHT, true, 0x0);
			
			this.bitmapData.fillRect(_stageRect, 0x0);
			redTank = new RedTank("ddd");
			redTank.rotation = 30;
			var redBmd:BitmapData= new BitmapData(redTank.width, redTank.height, true, 0x0);
			var m:Matrix = new Matrix();
			//m.rotate(45);
			m.translate(50, 50);
			redBmd.draw(redTank,m);
			_displayList = new Vector.<BitmapData>();
			_displayList.push(redBmd);
			AnimationManager.getInstance().addToAnimation(this);
			//this.cacheAsBitmap = true;
			//render();
		}
		
		private var _displayList:Vector.<BitmapData>;
		private var m:Matrix = new Matrix();
		public function render():void {
			for (var i:int = 0; i < 50; i++) {
				m.setTo(1, 0, 0, 1, 0, 0);
				m.translate( -50, -50);
				m.rotate(Math.random() * 360);
				m.translate(Math.random() * World.STAGE_WIDTH, Math.random() * World.STAGE_HEIGHT);
				this.bitmapData.draw(_displayList[0], m);
				//this.bitmapData.copyPixels(_displayList[0], new Rectangle(0, 0, 100, 100), 
				//new Point(Math.random() * World.STAGE_WIDTH, Math.random() * World.STAGE_HEIGHT), 
				//null, null, true);
			}
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
			this.bitmapData.lock();
			this.bitmapData.fillRect(_stageRect, 0x0);
			render();
			this.bitmapData.unlock();
		}
		
	}

}