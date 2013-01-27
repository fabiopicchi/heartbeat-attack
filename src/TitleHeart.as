package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author 
	 */
	public class TitleHeart extends Entity 
	{
		private var _animation : Spritemap
		
		public function TitleHeart()
		{
			x = 256;
			y = 205;
			_animation = new Spritemap(Assets.TITLEHEART_SPRITESHEET, 214, 259);
			_animation.add("pulse", [0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 15);
			addGraphic(_animation);
		}
		
		override public function update():void 
		{
			super.update();
			_animation.play("pulse");
		}
	}

}