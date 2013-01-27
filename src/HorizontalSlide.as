package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author 
	 */
	public class HorizontalSlide extends Entity
	{
		public var vx : int = 0;
		public var vy : int = 0;
		
		public function HorizontalSlide(type : String, xStart : Number) 
		{
			if (type == Helper.DL)
			{
				y = 300;
				addGraphic(Assets.getHelperAsset(type));
			}
			else if (type == Helper.DR)
			{
				y = 300;
				addGraphic(Assets.getHelperAsset(type));
			}
			else if (type == Helper.UR)
			{
				y = 100;
				addGraphic(Assets.getHelperAsset(type));
			}
			else if (type == Helper.UL)
			{
				y = 100;
				addGraphic(Assets.getHelperAsset(type));
			}
			else if (type == "URUL")
			{
				y = 100;
				addGraphic(Image.createRect(20, 20));
			}
			else if (type == "DRDL")
			{
				y = 300;
				addGraphic(Image.createRect(20, 20));
			}
			
			x = xStart - 10;
			vx = -Level.noteSpeed;
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
	}

}