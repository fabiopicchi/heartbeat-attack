package  
{
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author 
	 */
	public class Helper extends Entity 
	{
		private var _code : String;
		
		public static const UR : String = "UP";
		public static const UL : String = "DOWN";
		public static const DR : String = "LEFT";
		public static const DL : String = "RIGHT";
		
		public function Helper(code : String) 
		{
			this._code = code
			addGraphic (Assets.getHelperAsset (_code));
		}
		
		public function get code():String 
		{
			return _code;
		}
		
		public function correct () : void
		{
			//trace ("CORRECT " + _code);
		}
		
		public function wrong () : void
		{
			//trace ("WRONG " + _code);
		}
	}

}