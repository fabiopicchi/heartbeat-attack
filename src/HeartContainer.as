package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author 
	 */
	public class HeartContainer extends Entity 
	{
		private var _sprHeart : Spritemap;
		
		public function HeartContainer() 
		{
			x = 5;
			y = 5;
			
			_sprHeart = new Spritemap(Assets.HP_SPRITESHEET, 94, 96);
			_sprHeart.add("good", [0]);
			_sprHeart.add("ok", [1]);
			_sprHeart.add("bad", [2]);
			_sprHeart.add("danger", [3]);
			graphic = _sprHeart;
		}
		
		public function good() : void
		{
			_sprHeart.play("good");
		}
		
		public function ok() : void
		{
			_sprHeart.play("ok");
		}
		
		public function bad() : void
		{
			_sprHeart.play("bad");
		}
		
		public function danger() : void
		{
			_sprHeart.play("danger");
		}
	}

}