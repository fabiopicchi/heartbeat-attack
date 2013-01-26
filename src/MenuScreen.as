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
		public var cursor : Entity;
		public var selected : int = 0;
		public static const MAX_OPTIONS : int = 2;
		public static const POSY_0 : int = 300;
		public static const POSY_1 : int  = 400;
		
		public function MenuScreen() 
		{
			cursor = new Entity();
			cursor.addGraphic(Image.createRect(20, 20));
			add (cursor);
			cursor.x = 150;
			cursor.y = POSY_0;
			selected = 0;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed ("UP"))
			{
				if (selected == 0)
				{
					selected = MAX_OPTIONS - 1;
				}
				else
				{
					selected--;
				}
			}
			else if (Input.pressed ("DOWN"))
			{
				if (selected == MAX_OPTIONS - 1)
				{
					selected = 0;
				}
				else
				{
					selected++;
				}
			}
			
			if (Input.pressed ("ENTER"))
			{
				switch (selected)
				{
					case 0:
						FP.world = new Level;
						break;
					case 1:
						trace ("CREDITS");
						break;
				}
			}
			
			switch (selected)
			{
				case 0:
					cursor.y = POSY_0 + (cursor.y - POSY_0) * 0.9;
					break;
				case 1:
					cursor.y = POSY_1 + (cursor.y - POSY_1) * 0.9;
					break;
			}
		}
		
	}

}