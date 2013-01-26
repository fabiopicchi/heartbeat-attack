package  
{
	/**
	 * ...
	 * @author 
	 */
	public class Note 
	{
		public var time : int;
		public var id : int;
		public var value : String
		private var _effect : IEffect;
		
		public static const A : String = "UP";
		public static const B : String = "DOWN";
		public static const C : String = "LEFT";
		public static const D : String = "RIGHT";
		
		public function Note(time : int, value : int, id : int) 
		{
			this.time = time;
			this.id = id;
			switch (value)
			case 0:
			this.value = A;
			break;
			case 1:
			this.value = B;
			break;
			case 2:
			this.value = C;
			break;
			case 3:
			this.value = D;
			break;
		}
		
		public function get effect():IEffect 
		{
			return _effect;
		}
		
		public function set effect(value:IEffect):void 
		{
			_effect = value;
		}
		
	}
}