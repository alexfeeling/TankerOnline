package loader 
{
	import com.alex.pattern.Commander;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import texture.TextureManager;
	import util.OrderConst;
	/**
	 * ...
	 * @author alexfeeling
	 */
	public class SpriteSheetLoader 
	{
		
		public static const ASSETS_PATH:String = "/assets/";
		
		private var _pngLoader:Loader;
		private var _xmlLoader:URLLoader;
		
		private var _bmd:BitmapData;
		private var _xml:XML;
		
		private var _textureName:String;
		
		private var _pngUrl:String;
		private var _xmlUrl:String;
		
		public function SpriteSheetLoader(textureName:String, pngUrl:String, xmlUrl:String) 
		{
			_textureName = textureName;
			_pngUrl = pngUrl;
			_xmlUrl = xmlUrl;
			_pngLoader = new Loader();
			_pngLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadPngComplete);
			
			_xmlLoader = new URLLoader();
			_xmlLoader.addEventListener(Event.COMPLETE, onLoadXmlComplete);
			
		}
		
		public function start():void {
			_pngLoader.load(new URLRequest(ASSETS_PATH + _pngUrl));
			_xmlLoader.load(new URLRequest(ASSETS_PATH + _xmlUrl));
		}
		
		private function onLoadPngComplete(event:Event):void {
			_bmd = (_pngLoader.content as Bitmap).bitmapData;
			createTexture();
		}
		
		private function onLoadXmlComplete(event:Event):void {
			_xml = XML(event.target.data);
			createTexture();
		}
		
		private function createTexture():void {
			if (_bmd && _xml) {
				TextureManager.add(_textureName, 
					new TextureAtlas(Texture.fromBitmapData(_bmd), _xml));
				Commander.sendOrder(OrderConst.TEXTURE_LOAD_COMPLETE);
			}
		}
		
	}

}