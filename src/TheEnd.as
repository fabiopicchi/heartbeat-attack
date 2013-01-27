package  
{
	import flash.display.MovieClip;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author 
	 */
	public class TheEnd extends World 
	{
		private var _menu : Menu;
		private var _screen : MovieClip;
		
		public function TheEnd() 
		{
			Main.soundChannel.stop();
			Main.soundChannel = new Sfx (Assets.MENU);
			Main.soundChannel.play();
			
			_menu = new Menu(new Image (Assets.ARROW), 0, 0, backToMenu);
			add(_menu);
			_menu.visible = false;
			_screen = new EndingAnimation();
			FP.stage.addChild(_screen);
		}
		
		private function backToMenu():void 
		{
			FP.world = new MenuScreen();
			FP.stage.removeChild(_screen);
		}
	}

}