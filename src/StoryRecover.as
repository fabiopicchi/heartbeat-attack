package  
{
	/**
	 * ...
	 * @author 
	 */
	public class StoryRecover implements IEvent
	{
		private var _story : StageHeader;
		private var _time : int = 0;
		
		public function StoryRecover(time : int, story : StageHeader) 
		{
			_story = story;
			_time = time;
		}
		
		/* INTERFACE IEvent */
		
		public function trigger():void 
		{
			trace ("CLUMSY");
			_story.clumsy();
		}
		
		public function get time():int 
		{
			return _time;
		}
		
	}

}