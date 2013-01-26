package  
{
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author 
	 */
	public class TestEffect implements IEffect
	{
		private var _note : Note;
		public var boneco : Entity;
		public var item : Entity;
		
		public function TestEffect(boneco : Entity, item : Entity, note : Note) 
		{
			_note = note;
			this.boneco = boneco;
			this.item = item;
		}
		
		/* INTERFACE IEffect */
		
		public function right():void 
		{
			
		}
		
		public function wrong():void 
		{
			
		}
		
		/* INTERFACE IEffect */
		
		public function set animation(value:void):void 
		{
			_animation = value;
		}
		
		public function get note():Note 
		{
			return _note;
		}
		
	}

}