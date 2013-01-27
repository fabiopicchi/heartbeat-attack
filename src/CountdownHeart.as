package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author 
	 */
	public class CountdownHeart extends Entity 
	{
		private var _sprHeart : Spritemap;
		private var _counter : Spritemap;
		
		public function CountdownHeart() 
		{
			_sprHeart = new Spritemap(Assets.HEART, 190, 248);
			_sprHeart.add("pulse", [0, 1, 2, 0], 15, false);
			
			_counter = new Spritemap(Assets.COUNTER, 251, 252);
			_counter.add("3", [0]);
			_counter.add("2", [1]);
			_counter.add("1", [2]);
			_counter.add("GO", [3]);
			
			this.width = _counter.width;
			this.height = _counter.height;
			
			_sprHeart.x = (_counter.width / 2) - (_sprHeart.width / 2);
			_sprHeart.y = (_counter.height / 2) - (_sprHeart.height / 2);
			
			_counter.play("3");
			
			addGraphic(_sprHeart);
			addGraphic(_counter);
		}
		
		public function count() : void
		{
			_sprHeart.play("pulse", true);
			
			switch (_counter.currentAnim)
			{
				case "3":
					_counter.play("2");
				break;
				case "2":
					_counter.play("1");
				break;
				case "1":
					_counter.play("GO");
				break;
			}
		}
		
	}

}