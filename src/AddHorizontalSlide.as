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
			//trace (_type);
		}
		
		/* INTERFACE IEvent */
		public function trigger():void 
		{
			FP.world.add (new HorizontalSlide(_type, _xStart));
		}
		
		public function get time():int 
		{
			return _time;
		}
	}
}