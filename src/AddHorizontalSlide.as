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
		private var _type : String = "";
		private var _xStart : int = 0;
		
		public function AddHorizontalSlide(time : int, type : String, xStart : Number) 
		{
			_time = time;
			_type = type;
			_xStart = xStart;
		}
		
		/* INTERFACE IEvent */
		public function trigger(instant : Number):void 
		{
			FP.world.add (new HorizontalSlide(_type, _xStart + (instant - _time) * Level.noteSpeed));
		}
		
		public function get time():int 
		{
			return _time;
		}
	}
}