package  
{
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author 
	 */
	public class AddHorizontalSlide implements IEvent
	{
		private var _time : int = 0;
		
		public function AddHorizontalSlide(time : int) 
		{
			_time = time;
		}
		
		/* INTERFACE IEvent */
		public function trigger():void 
		{
			FP.world.add (new HorizontalSlide());
		}
		
		public function get time():int 
		{
			return _time;
		}
	}
}