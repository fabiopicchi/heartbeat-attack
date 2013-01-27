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
		
		public function MenuScreen() 
		{
			_menu = new Menu (Image.createRect(20, 20), 150, 300, function () : void
			{
				FP.world = new Level;
			});
			_menu.addOption(150, 400, function () : void
			{
				trace ("credits");
			});
			add (_menu);
		}
		
		override public function update():void 
		{
			super.update();
		}
		
	}

}