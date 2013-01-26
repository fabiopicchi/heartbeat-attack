package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author 
	 */
	public class HorizontalSlide extends Entity implements IAnimation
	{
		public var vx : int = 0;
		public var vy : int = 0;
		
		public function HorizontalSlide() 
		{
			addGraphic(Image.createRect(20, 20));
			y = 100;
			x = 1.125 * FP.engine.width - 10;
			vx = -320;
		}
		
		override public function update():void 
		{
			super.update();
			x += vx * FP.elapsed;
			y += vy * FP.elapsed;
			
			if (x + 20 < 0 || y + 20 < 0)
			{
				FP.world.remove(this);
			}
		}
		
		/* INTERFACE Animation */
		
		public function animate():void 
		{
			
		}
		
		public function correct(position : String):void 
		{
			switch(position)
			{
				case Note.A:
					vx = 0;
					vy = -100;
					break;
				case Note.B:
					addGraphic(Image.createRect(20, 20, 0xFF00FF));
					break;
			}
		}
		
		public function wrong(position : String):void 
		{
			switch(position)
			{
				case Note.A:
					FP.world.remove(this);
					break;
				case Note.B:
					addGraphic(Image.createRect(20, 20, 0x0000FF));
					break;
			}
		}
		
	}

}