package component 
{
	import com.alex.animation.IAnimation;
	import flash.geom.Rectangle;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author alex
	 */
	public class BaseComponent extends Sprite implements IComponent, IAnimation
	{
		
		private var _id:String = null;
		private var _mapX:Number = 0;
		private var _mapY:Number = 0;
		
		public var gridX:int = 0;
		public var gridY:int = 0;
		
		public var oldMapX:Number = 0;
		public var oldMapY:Number = 0;
		
		public var moveDir:int = 0;
		
		public var solid:Boolean = true;
		
		public var leftCpn4RightBd:BaseComponent;
		public var rightCpn4LeftBd:BaseComponent;
		public var upCpn4DownBd:BaseComponent;
		public var downCpn4UpBd:BaseComponent;
		
		public function BaseComponent() 
		{
			
		}
		
		public function getBoundRect():Rectangle {
			return bounds;
		}
		
		/* INTERFACE component.IComponent */
		
		public function get id():String 
		{
			return _id;
		}
		
		public function set id(vId:String):void 
		{
			_id = vId;
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
			
		}
		
		public function get mapX():Number 
		{
			return _mapX;
		}
		
		public function set mapX(value:Number):void 
		{
			_mapX = value;
		}
		
		public function get mapY():Number 
		{
			return _mapY;
		}
		
		public function set mapY(value:Number):void 
		{
			_mapY = value;
		}
		
		public function refreshXY():void {
			this.x = _mapX - world.controllingTank.mapX;
			this.y = _mapY - world.controllingTank.mapY;
		}
		
		public function get world():World 
		{
			return World.instance;
		}
		
		public function hitedBy(bul:BaseComponent):void {
			trace("be hited by " + bul.id);
		}
		
	}

}