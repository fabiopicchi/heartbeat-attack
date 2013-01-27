package  
{
	import flash.desktop.ClipboardTransferMode;
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
		public var upperTreadmill_1 : Treadmill;
		public var upperTreadmill_2 : Treadmill;
		public var lowerTreadmill_1 : Treadmill;
		public var lowerTreadmill_2 : Treadmill;
		
		public function MyStage(level : int, treadmillSpeed : Number) 
		{
			var e : Entity;
			
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
			
			e = new StageHeader(level);
			add(e);
			
			e = new Entity(0, 0, new Image(Assets.BACKGROUND_OVER));
			add(e);
			
			e = new Entity(0, 223, new Image(Assets.BACKGROUND));
			add(e);
			
			upperTreadmill_1 = new Treadmill(0, 287, treadmillSpeed);
			upperTreadmill_2 = new Treadmill(upperTreadmill_1.tWidth, 287, treadmillSpeed);
			lowerTreadmill_1 = new Treadmill(-200, 483, treadmillSpeed);
			lowerTreadmill_2 = new Treadmill(-200 + lowerTreadmill_1.tWidth, 483, treadmillSpeed);
			add(upperTreadmill_1);
			add(upperTreadmill_2);
			add(lowerTreadmill_1);
			add(lowerTreadmill_2);
			
			e = new Helper("UL");
			add(e);
			e = new Helper("UR");
			add(e);
			e = new Helper("DL");
			add(e);
			e = new Helper("DR");
			add(e);
		}
		
	}

}