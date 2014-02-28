package component 
{
	import animation.IAnimation;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author alex
	 */
	public class BaseComponent extends Sprite implements IComponent, IAnimation
	{
		
		private var _id:String = null;
		private var _mapX:Number = 0;
		private var _mapY:Number = 0;
		//private var _world:World;
		
		public function BaseComponent() 
		{
			
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
		
		//public function get display():DisplayObject 
		//{
			//return this;
		//}
		
		public function get world():World 
		{
			return World.instance;
		}
		
	}

}