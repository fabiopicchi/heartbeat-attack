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
				sprItem = Assets.getItemAsset(type);
				y = 518 - sprItem.height;
			}
			else if (type == Helper.DR)
			{
				sprItem = Assets.getItemAsset(type);
				y = 518 - sprItem.height;
			}
			else if (type == Helper.UR)
			{
				sprItem = Assets.getItemAsset(type);
				y = 332 - sprItem.height;
			}
			else if (type == Helper.UL)
			{
				sprItem = Assets.getItemAsset(type);
				y = 332 - sprItem.height;
			}
			else if (type == "URUL")
			{
				sprItem = Assets.getItemAsset(type);
				y = 332 - sprItem.height;
			}
			else if (type == "DRDL")
			{
				sprItem = Assets.getItemAsset(type);
				y = 518 - sprItem.height;
			}
			
			graphic = sprItem;
			sprItem.add("loop", [0, 1, 0, 2], 10);
			
			x = xStart - sprItem.width / 2;
			vx = -Level.noteSpeed;
		}
		
		override public function update():void 
		{
			super.update();
			
			sprItem.play("loop");
			
			x += vx * FP.elapsed;
			y += vy * FP.elapsed;
			
			if (x + sprItem.width < 0 || y + sprItem.width < 0)
			{
				FP.world.remove(this);
			}
		}
	}

}