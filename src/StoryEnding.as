package  
{
	/**
	 * ...
	 * @author 
	 */
	public class StoryEnding implements IEvent
	{
		private var _story : StageHeader;
		private var _time : int = 0;
		
		public function StoryEnding(time : int, story : StageHeader) 
		{
			_story = story;
			_time = time;
		}
		
		/* INTERFACE IEvent */
		
		public function trigger():void 
		{
			_story.endAnimation();
		}
		
		public function get time():int 
		{
			return _time;
		}
		
	}

}