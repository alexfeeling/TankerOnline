package texture 
{
	import flash.utils.Dictionary;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author alexfeeling
	 */
	public class TextureManager 
	{
			
		private var _allTextureAtlas:Dictionary;
		
		public function TextureManager() 
		{
			if (_instance) throw "singleton error";
			_allTextureAtlas = new Dictionary();
		}
		
		private static var _instance:TextureManager;
		private static function get instance():TextureManager {
			if (!_instance) {
				_instance = new TextureManager();
			}
			return _instance;
		}
		
		public static function add(name:String, textureAltas:TextureAtlas):void {
			if (name && textureAltas)
				instance._allTextureAtlas[name] = textureAltas;
		}
		
		public static function getTexture(name:String):TextureAtlas {
			return instance._allTextureAtlas[name] as TextureAtlas;
		}
		
	}

}