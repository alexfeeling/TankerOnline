package com.alex.animation 
{
	
	/**
	 * ...
	 * @author alex
	 */
	public interface IAnimation 
	{

		function get id():String;
		function isPause():Boolean
		function isPlayEnd():Boolean;
		function updateTime(passedTime:Number):void;
		
	}
	
}