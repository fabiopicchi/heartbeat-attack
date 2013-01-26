package  
{
	/**
	 * ...
	 * @author 
	 */
	public class Note 
	{
		public var time : int;
		public var value : String;
		
		public static const A : String = "UP";
		public static const B : String = "DOWN";
		public static const C : String = "LEFT";
		public static const D : String = "RIGHT";
		
		public function Note(time : int, value : String) 
		{
			this.time = time;
			this.value = value;
		}
	}
}