package  
{
	/**
	 * ...
	 * @author 
	 */
	public class StoryTwist implements IEvent
	{
		private var _story : StageHeader;
		private var _time : int = 0;
		
		public function StoryTwist(time : int, story : StageHeader) 
		{
			_story = story;
			_time = time;
		}
		
		/* INTERFACE IEvent */
		
		public function trigger(instant : Number):void 
		{
			_story.distress();
		}
		
		public function get time():int 
		{
			return _time;
		}
		
	}

}