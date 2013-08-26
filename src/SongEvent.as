package  
{
	/**
	 * ...
	 * @author ...
	 */
	public class SongEvent 
	{
		public static const NOTE_ENTRY : String = "noteEntry";
		public static const NOTE : String = "note";
		public static const STORY_START : String = "storyStart";
		public static const STORY_TWIST : String = "storyTwist";
		public static const STORY_RECOVER : String = "storyRecover";
		public static const STORY_ENDING : String = "storyEnding";
		
		private var _type:String;
		private var _beat:int;
		private var _args:Object;
		public var checked:Boolean = false;
		
		public function SongEvent(type:String, beat:int, args:Object = null) 
		{
			_type = type;
			_beat = beat;
			_args = args;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function get args():Object 
		{
			return _args;
		}
		
		public function get beat():int 
		{
			return _beat;
		}
		
		static public function compare (a : SongEvent, b : SongEvent) : int
		{
			if (a.beat > b.beat)
				return 1;
			else if (a.beat < b.beat)
				return - 1;
			else
				return 0;
		}
		
	}

}