package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import Assets;
	
	/**
	 * ...
	 * @author 
	 */
	public class Helper extends Entity 
	{
		public var sprHelper : Spritemap;
		public var sprSuccess : Spritemap;
		public var sprFail : Spritemap;
		
		public var xSuccess : Number;
		public var ySuccess : Number;
		public var xFail : Number;
		public var yFail : Number;
		
		private var _code : String;
		public static const UR : String = "UR";
		public static const UL : String = "UL";
		public static const DR : String = "DR";
		public static const DL : String = "DL";
		
		public function Helper(code : String) 
		{
			this._code = code;
			
			switch (_code)
			{
				case "UL":
					this.x = 205;
					this.y = 164;
					sprHelper = new Spritemap(Assets.TERRY, 154, 151, idle);
					sprHelper.add("idle", [0]);
					sprHelper.add("pulse", [9], 4, false);
					sprHelper.add("right", [1, 2, 3, 4, 5, 6, 7], 15, false);
					sprHelper.add("wrong", [8], 3, false);
					xSuccess = ;
					ySuccess = ;
					xFail = ;
					yFail = ;
					break;
				case "UR":
					this.x = 452;
					this.y = 178;
					sprHelper = new Spritemap(Assets.LARRY, 126, 130, idle);
					sprHelper.add("idle", [0]);
					sprHelper.add("pulse", [9], 4, false);
					sprHelper.add("right", [1, 2, 3, 4, 5, 6, 7], 15, false);
					sprHelper.add("wrong", [8], 3, false);
					xSuccess = ;
					ySuccess = ;
					xFail = ;
					yFail = ;
					break;
				case "DL":
					this.x = 222;
					this.y = 393;
					sprHelper = new Spritemap(Assets.GARRY, 138, 106, idle);
					sprHelper.add("idle", [0]);
					sprHelper.add("pulse", [8], 4, false);
					sprHelper.add("right", [1, 2, 3, 4, 5, 6], 15, false);
					sprHelper.add("wrong", [7], 3, false);
					xSuccess = ;
					ySuccess = ;
					xFail = ;
					yFail = ;
					break;
				case "DR":
					this.x = 457;
					this.y = 381;
					sprHelper = new Spritemap(Assets.SHANIQUA, 165, 118, idle);
					sprHelper.add("idle", [0]);
					sprHelper.add("pulse", [10], 4, false);
					sprHelper.add("right", [1, 2, 3, 4, 5, 6, 7, 8], 15, false);
					sprHelper.add("wrong", [9], 3, false);
					xSuccess = ;
					ySuccess = ;
					xFail = ;
					yFail = ;
					break;
			}
			
			graphic = sprHelper;
		}
		
		public function get code():String 
		{
			return _code;
		}
		
		public function idle () : void
		{
			sprHelper.play("idle");
		}
		
		public function correct () : void
		{
			sprHelper.play("right", true);
		}
		
		public function wrong () : void
		{
			sprHelper.play("wrong");
		}
		
		public function pulse () : void
		{
			sprHelper.play("pulse");
		}
	}

}