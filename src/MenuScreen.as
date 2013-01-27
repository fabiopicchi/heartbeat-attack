package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author 
	 */
	public class MenuScreen extends World 
	{
		private var _menu : Menu;
		private var creditsScreen : Entity = new Entity(0, 0, new Image(Assets.CREDITS));;
		private var _splash1 : SkippableScreen;
		private var _splash2 : SkippableScreen;
		
		public function MenuScreen() 
		{
			if (Main.soundChannel) Main.soundChannel.stop();
			Main.soundChannel = new Sfx (Assets.MENU);
			
			_splash1 = new SkippableScreen (new Image (Assets.FLASHPUNK), function() : void
			{
				remove (_splash1);
				add (_splash2);
				Main.soundChannel.loop();
			}, 3);
			
			_splash2 = new SkippableScreen (new Image (Assets.CATAVENTO), function() : void
			{
				remove (_splash2);
				_menu.disabled = false;
			}, 3);
			
			var e : Entity;
			e = new Entity(0, 0, new Image(Assets.MAINMENU_BG));
			
			add(e);
			
			_menu = new Menu (new Image(Assets.ARROW), 533, 415, function () : void
			{
				Main.screenTransition(2, 0x000000, function () : void
				{
					FP.world = new HowToPlayScreen;
				});
			});
			_menu.addOption(533, 518, function () : void
			{
				add(creditsScreen);
				_menu.disabled = true;
			});
			add (_menu);
			add (_splash1);
			_menu.disabled = true;
			
		}
		
		override public function update():void 
		{
			if (Input.pressed("ENTER") && _menu.selected == 1 && _menu.disabled) {
				remove(creditsScreen);
				_menu.disabled = false;
			}
			
			super.update();
		}
		
	}

}