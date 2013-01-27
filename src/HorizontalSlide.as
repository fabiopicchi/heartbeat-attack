package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author 
	 */
	public class HorizontalSlide extends Entity
	{
		public var vx : int = 0;
		public var vy : int = 0;
		public var sprItem : Spritemap;
		
		public function HorizontalSlide(type : String, xStart : Number) 
		{
			if (type == Helper.DL)
			{
				y = 483;
				sprItem = Assets.getItemAsset(type);
			}
			else if (type == Helper.DR)
			{
				y = 483;
				sprItem = Assets.getItemAsset(type);
			}
			else if (type == Helper.UR)
			{
				y = 287;
				sprItem = Assets.getItemAsset(type);
			}
			else if (type == Helper.UL)
			{
				y = 287;
				sprItem = Assets.getItemAsset(type);
			}
			else if (type == "URUL")
			{
				y = 287;
				sprItem = Assets.getItemAsset(type);
			}
			else if (type == "DRDL")
			{
				y = 483;
				sprItem = Assets.getItemAsset(type);
			}
			
			graphic = sprItem;
			sprItem.add("loop", [0, 1, 0, 2], 10);
			
			x = xStart - 10;
			vx = -Level.noteSpeed;
		}
		
		override public function update():void 
		{
			
			//if (degubTimer >= ((2*4)/(Level.bpm * Level.PER_SECOND * Level.valsPerBeat)))
			//{
				//return;
			//}
			//degubTimer += FP.elapsed;
			
			super.update();
			
			sprItem.play("loop");
			
			x += vx * FP.elapsed;
			y += vy * FP.elapsed;
			
			if (x + 20 < 0 || y + 20 < 0)
			{
				FP.world.remove(this);
			}
		}
	}

}