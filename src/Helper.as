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
		private var _sprHelper : Spritemap;
		private var _sprSuccess : Spritemap;
		private var _sprFail : Spritemap;
		
		public var xSuccess : Number;
		public var ySuccess : Number;
		public var xFail : Number;
		public var yFail : Number;
		
		private var _code : String;
		private var _animationLock : Boolean = false;
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
					_sprHelper = new Spritemap(Assets.TERRY, 154, 151, idle);
					_sprHelper.add("idle", [0]);
					_sprHelper.add("pulse", [9], 4, false);
					_sprHelper.add("right", [1, 2, 3, 4, 5, 6, 7], 15, false);
					_sprHelper.add("wrong", [8], 3, false);
					xSuccess = 274;
					ySuccess = 294;
					xFail = 278;
					yFail = 199;
					break;
				case "UR":
					this.x = 452;
					this.y = 178;
					_sprHelper = new Spritemap(Assets.LARRY, 126, 130, idle);
					_sprHelper.add("idle", [0]);
					_sprHelper.add("pulse", [9], 4, false);
					_sprHelper.add("right", [1, 2, 3, 4, 5, 6, 7], 15, false);
					_sprHelper.add("wrong", [8], 3, false);
					xSuccess = 519;
					ySuccess = 297;
					xFail = 516;
					yFail = 199;
					break;
				case "DL":
					this.x = 222;
					this.y = 393;
					_sprHelper = new Spritemap(Assets.GARRY, 138, 106, idle);
					_sprHelper.add("idle", [0]);
					_sprHelper.add("pulse", [8], 4, false);
					_sprHelper.add("right", [1, 2, 3, 4, 5, 6], 15, false);
					_sprHelper.add("wrong", [7], 3, false);
					xSuccess = 274;
					ySuccess = 494;
					xFail = 278;
					yFail = 397;
					break;
				case "DR":
					this.x = 457;
					this.y = 381;
					_sprHelper = new Spritemap(Assets.SHANIQUA, 165, 118, idle);
					_sprHelper.add("idle", [0]);
					_sprHelper.add("pulse", [10], 4, false);
					_sprHelper.add("right", [1, 2, 3, 4, 5, 6, 7, 8], 15, false);
					_sprHelper.add("wrong", [9], 3, false);
					xSuccess = 516;
					ySuccess = 397;
					xFail = 519;
					yFail = 494;
					break;
			}
			
			_sprSuccess = new Spritemap(Assets.SUCCESS, 85, 66);
			_sprSuccess.add("anim", [1, 2, 3, 4, 5, 6, 7, 0], 15, false);
			
			_sprFail = new Spritemap(Assets.FAIL, 67, 69);
			_sprFail.add("anim", [1, 2, 3, 4, 5, 6, 7, 0], 15, false);
			
			graphic = _sprHelper;
			addGraphic(_sprSuccess);
			addGraphic(_sprFail);
		}
		
		public function get code():String 
		{
			return _code;
		}
		
		public function idle () : void
		{
			if (_sprHelper.currentAnim == "right" || _sprHelper.currentAnim == "wrong")
			{
				_animationLock = false;
			}
			_sprHelper.play("idle");
		}
		
		public function correct () : void
		{
			_animationLock = true;
			_sprHelper.play("right", true);
			_sprSuccess.play("anim", true);
		}
		
		public function wrong () : void
		{
			_animationLock = true;
			_sprHelper.play("wrong");
			_sprFail.play("anim", true);
		}
		
		public function pulse () : void
		{
			if (!_animationLock)
			{
				_sprHelper.play("pulse");
			}
		}
	}

}