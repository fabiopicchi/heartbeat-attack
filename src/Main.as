package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Chambers
	 */
	public class Main extends Engine 
	{
		
		public function Main():void 
		{
			super (800, 600);
		}
		
		override public function init():void 
		{
			super.init();
			Input.define("UP", Key.UP);
			Input.define("DOWN", Key.DOWN);
			Input.define("ENTER", Key.ENTER);
			Input.define("ESC", Key.ESCAPE);
			FP.world = new MenuScreen ();
		}
		
	}
	
}