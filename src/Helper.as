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
		public static const UR : String = "UR";
		public static const UL : String = "UL";
		public static const DR : String = "DR";
		public static const DL : String = "DL";
		
		public function Helper(code : String) 
		{
			this._code = code;
			
			addGraphic (Assets.getHelperAsset (_code));
			switch (_code)
			{
				case "UL":
					this.x = 205;
					this.y = 164;
					break;
				case "UR":
					this.x = 452;
					this.y = 178;
					break;
				case "DL":
					this.x = 202;
					this.y = 392;
					break;
				case "DR":
					this.x = 466;
					this.y = 384;
					break;
			}
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