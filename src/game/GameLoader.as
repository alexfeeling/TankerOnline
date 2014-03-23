package game 
{
	import com.alex.pattern.Commander;
	import com.alex.pattern.IOrderExecutor;
	import loader.SpriteSheetLoader;
	import util.OrderConst;
	/**
	 * ...
	 * @author alexfeeling
	 */
	public class GameLoader implements IOrderExecutor
	{
		
		public function GameLoader() 
		{
			_loaderList = new Vector.<SpriteSheetLoader>();
			Commander.registerExecutor(this);
		}
		
		
		private var _loadCount:int = 0;
		private var _loaderList:Vector.<SpriteSheetLoader>;
		public function addSpriteSheetLoader(tName:String, pngUrl:String, xmlUrl:String):void {
			_loaderList.push(new SpriteSheetLoader(tName, pngUrl, xmlUrl));
			_loadCount++;
		}
		
		public function start():void {
			for (var i:int = 0, len:int = _loaderList.length; i < len; i++) {
				_loaderList[i].start();
			}
		}
		
		/* INTERFACE com.alex.pattern.IOrderExecutor */
		
		public function getExecuteOrderList():Array 
		{
			return [OrderConst.TEXTURE_LOAD_COMPLETE];
		}
		
		public function executeOrder(orderName:String, orderParam:Object = null):void 
		{
			switch(orderName) {
				case OrderConst.TEXTURE_LOAD_COMPLETE:
					_loadCount--;
					if (_loadCount <= 0) {
						_loadCount = 0;
						_loaderList.length = 0;
						_loaderList = null;
						Commander.sendOrder(OrderConst.ALL_LOAD_COMPLETE);
					}
					break;
			}
		}
		
		public function getExecutorId():String 
		{
			return "game_loader";
		}
		
	}

}