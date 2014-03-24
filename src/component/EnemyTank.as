package component 
{
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author alex
	 */
	public class EnemyTank extends BaseTank 
	{
		
		public function EnemyTank(vId:String, textureAtlas:TextureAtlas) 
		{
			super(vId, textureAtlas);
		}
		
		override protected function init():void 
		{
			super.init();
			thruster.pivotX = 100;
			thruster.pivotY = 100;
			body.pivotX = 74;
			body.pivotY = 85;
			weapon.pivotX = 64;
			weapon.pivotY = 185;
			this.scaleX = 0.5;
			this.scaleY = 0.5;
			this._speed = 20;
			this._turnSpeed = 10;
		}
		
	}

}