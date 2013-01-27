package  
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author 
	 */
	public class HowToPlayScreen extends World 
	{
		private var _skp1 : SkippableScreen;
		
		public function HowToPlayScreen() 
		{
			_skp1 = new SkippableScreen (new Image (Assets.HOW_TO_PLAY), function () : void
			{
				FP.world.remove (_skp1);
				FP.world = new Level(1);
			});
			
			add (_skp1);
		}
		
	}

}