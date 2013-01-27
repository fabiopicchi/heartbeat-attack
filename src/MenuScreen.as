package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
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
		
		public function MenuScreen() 
		{
			var e : Entity
			
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