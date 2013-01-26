package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author 
	 */
	public class MyStage extends World 
	{	
		
		public function MyStage(level : int) 
		{
			var e : Entity
			
			switch (level)
			{
				case 1:
					e = new Entity(0, 0, new Image(Assets.BACKGROUND_SLEEPER));
					break;
				case 2:
					e = new Entity(0, 0, new Image(Assets.BACKGROUND_BROWSER));
					break;
				case 3:
					e = new Entity(0, 0, new Image(Assets.BACKGROUND_LOVER));
					break;
			}
			add(e);
			
			add(new StageHeader(level));
			
			e = new Entity(0, 0, new Image(Assets.BACKGROUND_OVER));
			add(e);
			
			e = new Entity(0, 223, new Image(Assets.BACKGROUND));
			add(e);
		}
		
	}

}