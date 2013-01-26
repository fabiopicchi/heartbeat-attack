package  
{
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author 
	 */
	public class AddHorizontalSlide implements IEvent
	{
		
		public function AddHorizontalSlide() 
		{
			
		}
		
		/* INTERFACE IEvent */
		
		public function trigger():void 
		{
			FP.world.add (new HorizontalSlide());
		}
		
	}

}