package component 
{
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author alex
	 */
	public interface IComponent 
	{
		
		function get id():String;
		function set id(vId:String):void;
		
		function get mapX():Number;
		function set mapX(value:Number):void;
		
		function get mapY():Number;
		function set mapY(value:Number):void;
		
		function get world():World;
		
	}
	
}