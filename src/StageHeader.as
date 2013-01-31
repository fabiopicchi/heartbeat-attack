package  
{
	import flash.display.Graphics;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import Assets;
	
	/**
	 * ...
	 * @author 
	 */
	public class StageHeader extends Entity 
	{
		public var idleAr : Array;
		public var distressedAr : Array;
		public var clumsyAr : Array;
		public var endAr : Array;
		public var graphicAr : Array;
		
		public var index : int = 0;
		public var frames : int = 0;
		public var level : int;
		
		public var end : Boolean = false;
		
		public var frameRate : Number;
		
		public function StageHeader(level : int, frameRate : Number = 10) 
		{
			var xOffset : Number;
			var yOffset : Number;
			
			this.frameRate = frameRate;
			this.level = level;
			
			idleAr = new Array();
			distressedAr = new Array ();
			clumsyAr = new Array();
			endAr = new Array ();
			
			switch (level)
			{
				case 1: //Sleeper
					xOffset = 0;
					yOffset = 11;
					
					idleAr.push(new Image(Assets.SLEEPER_IDLE01));
					idleAr.push(new Image(Assets.SLEEPER_IDLE02));
					idleAr.push(new Image(Assets.SLEEPER_IDLE03));
					idleAr.push(new Image(Assets.SLEEPER_IDLE04));
					idleAr.push(new Image(Assets.SLEEPER_IDLE05));
					idleAr.push(new Image(Assets.SLEEPER_IDLE06));
					idleAr.push(new Image(Assets.SLEEPER_IDLE07));
					
					distressedAr.push(new Image(Assets.SLEEPER_DISTRESS01));
					distressedAr.push(new Image(Assets.SLEEPER_DISTRESS02));
					distressedAr.push(new Image(Assets.SLEEPER_DISTRESS03));
					distressedAr.push(new Image(Assets.SLEEPER_DISTRESS04));
					distressedAr.push(new Image(Assets.SLEEPER_DISTRESS05));
					distressedAr.push(new Image(Assets.SLEEPER_DISTRESS06));
					
					clumsyAr = idleAr;
					
					endAr.push(new Image(Assets.SLEEPER_END01));
					endAr.push(new Image(Assets.SLEEPER_END02));
					endAr.push(new Image(Assets.SLEEPER_END03));
					endAr.push(new Image(Assets.SLEEPER_END04));
					endAr.push(new Image(Assets.SLEEPER_END05));
					endAr.push(new Image(Assets.SLEEPER_END04));
				break;
				
				case 2: //Slacker
					xOffset = 120;
					yOffset = 11;
					
					idleAr.push(new Image(Assets.SLACKER_IDLE01));
					idleAr.push(new Image(Assets.SLACKER_IDLE02));
					idleAr.push(new Image(Assets.SLACKER_IDLE03));
					idleAr.push(new Image(Assets.SLACKER_IDLE04));
					idleAr.push(new Image(Assets.SLACKER_IDLE05));
					
					distressedAr.push(new Image(Assets.SLACKER_DISTRESS01));
					distressedAr.push(new Image(Assets.SLACKER_DISTRESS02));
					
					clumsyAr.push(new Image(Assets.SLACKER_CLUMSY01));
					clumsyAr.push(new Image(Assets.SLACKER_CLUMSY02));
					clumsyAr.push(new Image(Assets.SLACKER_CLUMSY03));
					clumsyAr.push(new Image(Assets.SLACKER_CLUMSY04));
					clumsyAr.push(new Image(Assets.SLACKER_CLUMSY05));
					clumsyAr.push(new Image(Assets.SLACKER_CLUMSY06));
					
					endAr.push(new Image(Assets.SLACKER_END01));
					endAr.push(new Image(Assets.SLACKER_END02));
					endAr.push(new Image(Assets.SLACKER_END03));
					endAr.push(new Image(Assets.SLACKER_END04));
					endAr.push(new Image(Assets.SLACKER_END05));
					endAr.push(new Image(Assets.SLACKER_END06));
				break;
				
				case 3: //Lover
					xOffset = 58;
					yOffset = 11;
					
					idleAr.push(new Image(Assets.LOVER_IDLE01));
					idleAr.push(new Image(Assets.LOVER_IDLE02));
					idleAr.push(new Image(Assets.LOVER_IDLE03));
					idleAr.push(new Image(Assets.LOVER_IDLE04));
					idleAr.push(new Image(Assets.LOVER_IDLE05));
					idleAr.push(new Image(Assets.LOVER_IDLE06));
					
					distressedAr.push(new Image(Assets.LOVER_DISTRESS01));
					distressedAr.push(new Image(Assets.LOVER_DISTRESS02));
					distressedAr.push(new Image(Assets.LOVER_DISTRESS03));
					distressedAr.push(new Image(Assets.LOVER_DISTRESS04));
					
					clumsyAr.push(new Image(Assets.LOVER_CLUMSY01));
					clumsyAr.push(new Image(Assets.LOVER_CLUMSY02));
					clumsyAr.push(new Image(Assets.LOVER_CLUMSY03));
					clumsyAr.push(new Image(Assets.LOVER_CLUMSY04));
					
					endAr.push(new Image(Assets.LOVER_END01));
					endAr.push(new Image(Assets.LOVER_END02));
					endAr.push(new Image(Assets.LOVER_END03));
					endAr.push(new Image(Assets.LOVER_END04));
				break;
			}
			
			graphicAr = idleAr;
			
			graphic = graphicAr[index];
			
			super(xOffset, yOffset);
		}
		
		override public function update():void 
		{
			if (!end)
			{
				if (frames >= frameRate)
				{
					index++;
					frames = 0;
				}
				if (index >= graphicAr.length)
				{
					index = 0;
				}
				graphic = graphicAr[index];
			}
			else
			{
				switch (level)
				{
					case 1: //Sleeper
						if (frames >= frameRate && index < graphicAr.length - 1 && index != 4)
						{
							index++;
							frames = 0;
						}
						else if (index == 4 && frames >= 50)
						{
							index++;
							frames = 0
						}
						graphic = graphicAr[index];
					break;
						
					case 2: //Slacker
						if (frames >= frameRate && index < graphicAr.length)
						{
							index++;
							frames = 0;
							if (index == graphicAr.length)
							{
								index = 4;
							}
						}
						graphic = graphicAr[index];
					break;
						
					case 3: //Lover
						if (frames >= frameRate)
						{
							index++;
							frames = 0;
						}
						if (index >= graphicAr.length)
						{
							index = 0;
						}
						graphic = graphicAr[index];
					break;
				}
			}
			
			frames++;
			
			super.update();
		}
		
		public function idle():void
		{
			frames = 0;
			index = 0;
			graphicAr = idleAr;
		}
		
		public function distress():void
		{
			frames = 0;
			index = 0;
			graphicAr = distressedAr;
		}
		
		public function clumsy():void
		{
			frames = 0;
			index = 0;
			graphicAr = clumsyAr;
		}
		
		public function endAnimation():void
		{
			frames = 0;
			index = 0;
			graphicAr = endAr;
			end = true;
		}
		
	}

}