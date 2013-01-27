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
		private var degubTimer : Number = 0;
		
		public function HorizontalSlide(type : String, xStart : Number) 
		{
			if (type == Helper.DL)
			{
				y = 483 + 69 / 2 - 10;
				addGraphic(Assets.getItemAsset(type));
			}
			else if (type == Helper.DR)
			{
				y = 483 + 69 / 2 - 10;
				addGraphic(Assets.getItemAsset(type));
			}
			else if (type == Helper.UR)
			{
				y = 287 + 69 / 2 - 10;
				addGraphic(Assets.getItemAsset(type));
			}
			else if (type == Helper.UL)
			{
				y = 287 + 69 / 2 - 10;
				addGraphic(Assets.getItemAsset(type));
			}
			else if (type == "URUL")
			{
				y = 287 + 69 / 2 - 10;
				addGraphic(Assets.getItemAsset(type));
			}
			else if (type == "DRDL")
			{
				y = 483 + 69 / 2 - 10;
				addGraphic(Assets.getItemAsset(type));
			}
			
			x = xStart - 10;
			vx = -Level.noteSpeed;
		}
		
		override public function update():void 
		{
			
			//if (degubTimer >= 1.33)
			//{
				//return;
			//}
			//degubTimer += FP.elapsed;
			
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