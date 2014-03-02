package map 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author alexfeeling
	 */
	public class BMDDisplay extends BitmapData 
	{
		
		
		public function BMDDisplay(display:DisplayObject) 
		{
			super(display.width, display.height, true, 0x0);
			this.draw(display);
		}
		
	}

}