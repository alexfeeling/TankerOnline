package animation 
{
	
	/**
	 * ...
	 * @author alex
	 */
	public interface IAnimation 
	{
		
		function isPause():Boolean
		function isPlayEnd():Boolean;
		function gotoNextFrame(passedTime:Number):void;
		
	}
	
}