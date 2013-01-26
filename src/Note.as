package  
{
	/**
	 * ...
	 * @author 
	 */
	public class Note 
	{
		private var _time : int;
		public var id : int;
		private var _helper : Helper;
		
		public function Note(time : int, helper : Helper) 
		{
			this.id = id;
			this._time = time;
			this._helper = helper;
		}
		
		public function get helper():Helper 
		{
			return _helper;
		}
		
		public function get time():int 
		{
			return _time;
		}
		
	}
}