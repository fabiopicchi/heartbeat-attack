package 
{
	import net.flashpunk.FP;
	import net.flashpunk.Engine;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Engine 
	{
		public function Main ()
		{
			super (640, 480);
		}
		
		override public function init():void 
		{
			super.init();
			Input.define ("UP", Key.UP);
			Input.define ("DOWN", Key.DOWN);
			FP.world = new Level();
		}
	}
	
}