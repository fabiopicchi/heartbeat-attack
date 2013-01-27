package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author 
	 */
	public class Heart extends Entity 
	{
		private var _animation : Spritemap
		
		public function Heart(x : Number, y : Number) 
		{
			this.x = x;
			this.y = y;
			_animation = new Spritemap(Assets.HEART, 190, 248);
			_animation.add("pulse", [0, 1, 2, 0, 0, 0, 0, 0], 15);
			_animation.play("pulse");
		}
		
	}

}