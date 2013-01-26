package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author 
	 */
	public class TestEffectA implements IEffect
	{
		private var _animation : Animation;
		public var boneco : Entity;
		public var item : Entity;
		
		
		public function TestEffectA(boneco : Entity) 
		{
			this.boneco = boneco;
		}
		
		/* INTERFACE IEffect */
		
		public function right():void 
		{
			trace ("RIGHT A");
			if (_animation)
			{
				//FP.world.remove(_animation);
				(_animation as HorizontalSlide).vx = 0;
				(_animation as HorizontalSlide).vy = -100;
				//_animation.addGraphic(Image.createRect(20, 20, 0x0000FF));
			}
		}
		
		public function wrong():void 
		{
			trace ("WRONG A");
			if (_animation) 
			{
				//trace (_animation.x);
				FP.world.remove(_animation);
				//_animation.addGraphic(Image.createRect(20, 20, 0xFF00FF));
			}
		}
		
		public function get animation():Animation 
		{
			return _animation;
		}
		
		public function set animation(a : Animation):void 
		{
			//trace ("ADD");
			_animation = a;
		}
	}

}