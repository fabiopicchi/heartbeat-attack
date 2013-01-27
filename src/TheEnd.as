package  
{
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author 
	 */
	public class TheEnd extends World 
	{
		private var _menu : Menu;
		
		public function TheEnd() 
		{
			_menu = new Menu(null, 0, 0, backToMenu);
		}
		
		private function backToMenu():void 
		{
			FP.world = new MenuScreen();
		}
	}

}