package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author 
	 */
	public class Treadmill extends Entity 
	{
		public var speed : Number;
		private var treadmillWidth : Number;
		
		public function Treadmill(x : Number, y : Number, speed : Number) 
		{
			this.x = x;
			this.y = y;
			this.speed = speed;
			
			var segmentImage1 : Image = new Image(Assets.TREADMILL);
			addGraphic(segmentImage1);
			
			treadmillWidth = segmentImage1.width;
			
			var segmentImage2 : Image = new Image(Assets.TREADMILL);
			segmentImage2.x = treadmillWidth;
			addGraphic(segmentImage2);
		}
		
		override public function update():void 
		{
			this.x -= speed * FP.elapsed;
			if (this.x <= - treadmillWidth)
			{
				this.x += treadmillWidth;
			}
			super.update();
		}
	}

}