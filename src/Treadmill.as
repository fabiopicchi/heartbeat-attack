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
		
		public function Treadmill(x : Number, y : Number, speed : Number) 
		{
			this.x = x;
			this.y = y;
			this.speed = speed;
			graphic = new Image(Assets.TREADMILL);
		}
		
		override public function update():void 
		{
			this.x -= speed * FP.elapsed;
			if (this.x <= - (this.graphic as Image).width)
			{
				this.x += 2 * (this.graphic as Image).width;
			}
			super.update();
		}
		
		public function get tWidth():Number
		{
			return (this.graphic as Image).width;
		}
		
	}

}