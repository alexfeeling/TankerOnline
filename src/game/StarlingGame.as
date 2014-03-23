package game 
{
	import flash.display.Bitmap;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author alexfeeling
	 */
	public class StarlingGame extends Sprite 
	{
		
		[Embed(source="../../bin/assets/hero.png")]
		public static const HERO_PNG1:Class;
		[Embed(source = "../../bin/assets/hero.xml", mimeType="application/octet-stream" )]
		public static const HERO_XML1:Class;
		
		[Embed(source="../../bin/assets/hero2.png")]
		public static const HERO_PNG2:Class;
		[Embed(source = "../../bin/assets/hero2.xml", mimeType="application/octet-stream" )]
		public static const HERO_XML2:Class;
		
		[Embed(source="../../bin/assets/hero3.png")]
		public static const HERO_PNG3:Class;
		[Embed(source = "../../bin/assets/hero3.xml", mimeType="application/octet-stream" )]
		public static const HERO_XML3:Class;
		
		[Embed(source="../../bin/assets/hero4.png")]
		public static const HERO_PNG4:Class;
		[Embed(source = "../../bin/assets/hero4.xml", mimeType="application/octet-stream" )]
		public static const HERO_XML4:Class;
		
		[Embed(source="../../bin/assets/hero5.png")]
		public static const HERO_PNG5:Class;
		[Embed(source = "../../bin/assets/hero5.xml", mimeType="application/octet-stream" )]
		public static const HERO_XML5:Class;
		
		[Embed(source="../../bin/assets/hero6.png")]
		public static const HERO_PNG6:Class;
		[Embed(source = "../../bin/assets/hero6.xml", mimeType="application/octet-stream" )]
		public static const HERO_XML6:Class;
		
		[Embed(source="../../bin/assets/hero7.png")]
		public static const HERO_PNG7:Class;
		[Embed(source = "../../bin/assets/hero7.xml", mimeType="application/octet-stream" )]
		public static const HERO_XML7:Class;
		
		[Embed(source="../../bin/assets/hero8.png")]
		public static const HERO_PNG8:Class;
		[Embed(source = "../../bin/assets/hero8.xml", mimeType="application/octet-stream" )]
		public static const HERO_XML8:Class;
		
		[Embed(source="../../bin/assets/hero9.png")]
		public static const HERO_PNG9:Class;
		[Embed(source = "../../bin/assets/hero9.xml", mimeType="application/octet-stream" )]
		public static const HERO_XML9:Class;
		
		[Embed(source="../../bin/assets/hero10.png")]
		public static const HERO_PNG10:Class;
		[Embed(source = "../../bin/assets/hero10.xml", mimeType="application/octet-stream" )]
		public static const HERO_XML10:Class;
		
		public function StarlingGame() 
		{
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var heroBitmap:Bitmap = new HERO_PNG1();
			var heroXML:XML = XML(new HERO_XML1());
			var heroTexture:Texture = Texture.fromBitmap(heroBitmap);
			
			var textureAtlas:TextureAtlas = new TextureAtlas(heroTexture, heroXML);
			
			for (var j:int = 0; j < 5; j++) {
				for (var i:int = 0; i < 2; i++) {
					var frames:Vector.<Texture> = textureAtlas.getTextures(i<1?"202":"201");
					var heroMovie:MovieClip = new MovieClip(frames);
					heroMovie.x = stage.stageWidth * Math.random();
					heroMovie.y = stage.height * Math.random();
					this.addChild(heroMovie);
					Starling.juggler.add(heroMovie);
					heroMovie.loop = true;
					heroMovie.play();
				}
				
				heroBitmap = new HERO_PNG2();
				heroXML = XML(new HERO_XML2());
				heroTexture = Texture.fromBitmap(heroBitmap);
				textureAtlas = new TextureAtlas(heroTexture, heroXML);
				for (i = 0; i < 2; i++) {
					frames = textureAtlas.getTextures(i<1?"302":"301");
					heroMovie = new MovieClip(frames);
					heroMovie.x = stage.stageWidth * Math.random();
					heroMovie.y = stage.height * Math.random();
					this.addChild(heroMovie);
					Starling.juggler.add(heroMovie);
					heroMovie.loop = true;
					heroMovie.play();
				}
				
				
				heroBitmap = new HERO_PNG3();
				heroXML = XML(new HERO_XML3());
				heroTexture = Texture.fromBitmap(heroBitmap);
				textureAtlas = new TextureAtlas(heroTexture, heroXML);
				for (i = 0; i < 2; i++) {
					frames = textureAtlas.getTextures(i<1?"302":"301");
					heroMovie = new MovieClip(frames);
					heroMovie.x = stage.stageWidth * Math.random();
					heroMovie.y = stage.height * Math.random();
					this.addChild(heroMovie);
					Starling.juggler.add(heroMovie);
					heroMovie.loop = true;
					heroMovie.play();
				}
				
				heroBitmap = new HERO_PNG4();
				heroXML = XML(new HERO_XML4());
				heroTexture = Texture.fromBitmap(heroBitmap);
				textureAtlas = new TextureAtlas(heroTexture, heroXML);
				for (i = 0; i < 2; i++) {
					frames = textureAtlas.getTextures(i<1?"602":"601");
					heroMovie = new MovieClip(frames);
					heroMovie.x = stage.stageWidth * Math.random();
					heroMovie.y = stage.height * Math.random();
					this.addChild(heroMovie);
					Starling.juggler.add(heroMovie);
					heroMovie.loop = true;
					heroMovie.play();
				}
				
				heroBitmap = new HERO_PNG5();
				heroXML = XML(new HERO_XML5());
				heroTexture = Texture.fromBitmap(heroBitmap);
				textureAtlas = new TextureAtlas(heroTexture, heroXML);
				for (i = 0; i < 2; i++) {
					frames = textureAtlas.getTextures(i<1?"602":"601");
					heroMovie = new MovieClip(frames);
					heroMovie.x = stage.stageWidth * Math.random();
					heroMovie.y = stage.height * Math.random();
					this.addChild(heroMovie);
					Starling.juggler.add(heroMovie);
					heroMovie.loop = true;
					heroMovie.play();
				}
				
				heroBitmap = new HERO_PNG6();
				heroXML = XML(new HERO_XML6());
				heroTexture = Texture.fromBitmap(heroBitmap);
				textureAtlas = new TextureAtlas(heroTexture, heroXML);
				for (i = 0; i < 2; i++) {
					frames = textureAtlas.getTextures(i<1?"802":"801");
					heroMovie = new MovieClip(frames);
					heroMovie.x = stage.stageWidth * Math.random();
					heroMovie.y = stage.height * Math.random();
					this.addChild(heroMovie);
					Starling.juggler.add(heroMovie);
					heroMovie.loop = true;
					heroMovie.play();
				}
				
				heroBitmap = new HERO_PNG7();
				heroXML = XML(new HERO_XML7());
				heroTexture = Texture.fromBitmap(heroBitmap);
				textureAtlas = new TextureAtlas(heroTexture, heroXML);
				for (i = 0; i < 2; i++) {
					frames = textureAtlas.getTextures(i < 1?"802":"801");
					heroMovie = new MovieClip(frames);
					heroMovie.x = stage.stageWidth * Math.random();
					heroMovie.34refdvc 43refdvc y = stage.height * Math.random();
					this.addChild(heroMovie);
					Starling.juggler.add(heroMovie);
					heroMovie.loop = true;
					heroMovie.play();
				}
				
				heroBitmap = new HERO_PNG8();
				heroXML = XML(new HERO_XML8());
				heroTexture = Texture.fromBitmap(heroBitmap);
				textureAtlas = new TextureAtlas(heroTexture, heroXML);
				for (i = 0; i < 2; i++) {
					frames = textureAtlas.getTextures(i<1?"902":"901");
					heroMovie = new MovieClip(frames);
					heroMovie.x = stage.stageWidth * Math.random();
					heroMovie.y = stage.height * Math.random();
					this.addChild(heroMovie);
					Starling.juggler.add(heroMovie);
					heroMovie.loop = true;
					heroMovie.play();
				}
				
				heroBitmap = new HERO_PNG9();
				heroXML = XML(new HERO_XML9());
				heroTexture = Texture.fromBitmap(heroBitmap);
				textureAtlas = new TextureAtlas(heroTexture, heroXML);
				for (i = 0; i < 2; i++) {
					frames = textureAtlas.getTextures(i<1?"902":"901");
					heroMovie = new MovieClip(frames);
					heroMovie.x = stage.stageWidth * Math.random();
					heroMovie.y = stage.height * Math.random();
					this.addChild(heroMovie);
					Starling.juggler.add(heroMovie);
					heroMovie.loop = true;
					heroMovie.play();
				}
				
				heroBitmap = new HERO_PNG10();
				heroXML = XML(new HERO_XML10());
				heroTexture = Texture.fromBitmap(heroBitmap);
				textureAtlas = new TextureAtlas(heroTexture, heroXML);
				for (i = 0; i < 2; i++) {
					frames = textureAtlas.getTextures(i<1?"202":"201");
					heroMovie = new MovieClip(frames);
					heroMovie.x = stage.stageWidth * Math.random();
					heroMovie.y = stage.height * Math.random();
					this.addChild(heroMovie);
					Starling.juggler.add(heroMovie);
					heroMovie.loop = true;
					heroMovie.play();
				}
			}
		}
		
	}

}