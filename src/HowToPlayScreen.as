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
		private var _skp2 : SkippableScreen;
		
		public function HowToPlayScreen() 
		{
			_skp1 = new SkippableScreen (new Image (Assets.HOW_TO_PLAY), function () : void
			{
				FP.world.remove (_skp1);
				FP.world = new Level;
			});
			
			//_skp2 = new SkippableScreen (new Image (Assets.HOW_TO_PLAY_2), function () : void
			//{
				//FP.world.remove (_skp2);
				//FP.world = new Level;
			//});
			
			add (_skp1);
		}
		
	}

}