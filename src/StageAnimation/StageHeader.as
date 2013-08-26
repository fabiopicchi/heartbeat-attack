package StageAnimation
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
		private var _startAr : Array;
		private var _twistAr : Array;
		private var _recoverAr : Array;
		private var _endingAr : Array;
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
			
			_startAr = new Array();
			_twistAr = new Array ();
			_recoverAr = new Array();
			_endingAr = new Array ();
			
			switch (level)
			{
				case 1: //Sleeper
					xOffset = 0;
					yOffset = 11;
					
					_startAr.push(new Image(Assets.SLEEPER_IDLE01));
					_startAr.push(new Image(Assets.SLEEPER_IDLE02));
					_startAr.push(new Image(Assets.SLEEPER_IDLE03));
					_startAr.push(new Image(Assets.SLEEPER_IDLE04));
					_startAr.push(new Image(Assets.SLEEPER_IDLE05));
					_startAr.push(new Image(Assets.SLEEPER_IDLE06));
					_startAr.push(new Image(Assets.SLEEPER_IDLE07));
					
					_twistAr.push(new Image(Assets.SLEEPER_DISTRESS01));
					_twistAr.push(new Image(Assets.SLEEPER_DISTRESS02));
					_twistAr.push(new Image(Assets.SLEEPER_DISTRESS03));
					_twistAr.push(new Image(Assets.SLEEPER_DISTRESS04));
					_twistAr.push(new Image(Assets.SLEEPER_DISTRESS05));
					_twistAr.push(new Image(Assets.SLEEPER_DISTRESS06));
					
					_recoverAr = _startAr;
					
					_endingAr.push(new Image(Assets.SLEEPER_END01));
					_endingAr.push(new Image(Assets.SLEEPER_END02));
					_endingAr.push(new Image(Assets.SLEEPER_END03));
					_endingAr.push(new Image(Assets.SLEEPER_END04));
					_endingAr.push(new Image(Assets.SLEEPER_END05));
					_endingAr.push(new Image(Assets.SLEEPER_END04));
				break;
				
				case 2: //Slacker
					xOffset = 120;
					yOffset = 11;
					
					_startAr.push(new Image(Assets.SLACKER_IDLE01));
					_startAr.push(new Image(Assets.SLACKER_IDLE02));
					_startAr.push(new Image(Assets.SLACKER_IDLE03));
					_startAr.push(new Image(Assets.SLACKER_IDLE04));
					_startAr.push(new Image(Assets.SLACKER_IDLE05));
					
					_twistAr.push(new Image(Assets.SLACKER_DISTRESS01));
					_twistAr.push(new Image(Assets.SLACKER_DISTRESS02));
					
					_recoverAr.push(new Image(Assets.SLACKER_CLUMSY01));
					_recoverAr.push(new Image(Assets.SLACKER_CLUMSY02));
					_recoverAr.push(new Image(Assets.SLACKER_CLUMSY03));
					_recoverAr.push(new Image(Assets.SLACKER_CLUMSY04));
					_recoverAr.push(new Image(Assets.SLACKER_CLUMSY05));
					_recoverAr.push(new Image(Assets.SLACKER_CLUMSY06));
					
					_endingAr.push(new Image(Assets.SLACKER_END01));
					_endingAr.push(new Image(Assets.SLACKER_END02));
					_endingAr.push(new Image(Assets.SLACKER_END03));
					_endingAr.push(new Image(Assets.SLACKER_END04));
					_endingAr.push(new Image(Assets.SLACKER_END05));
					_endingAr.push(new Image(Assets.SLACKER_END06));
				break;
				
				case 3: //Lover
					xOffset = 58;
					yOffset = 11;
					
					_startAr.push(new Image(Assets.LOVER_IDLE01));
					_startAr.push(new Image(Assets.LOVER_IDLE02));
					_startAr.push(new Image(Assets.LOVER_IDLE03));
					_startAr.push(new Image(Assets.LOVER_IDLE04));
					_startAr.push(new Image(Assets.LOVER_IDLE05));
					_startAr.push(new Image(Assets.LOVER_IDLE06));
					
					_twistAr.push(new Image(Assets.LOVER_DISTRESS01));
					_twistAr.push(new Image(Assets.LOVER_DISTRESS02));
					_twistAr.push(new Image(Assets.LOVER_DISTRESS03));
					_twistAr.push(new Image(Assets.LOVER_DISTRESS04));
					
					_recoverAr.push(new Image(Assets.LOVER_CLUMSY01));
					_recoverAr.push(new Image(Assets.LOVER_CLUMSY02));
					_recoverAr.push(new Image(Assets.LOVER_CLUMSY03));
					_recoverAr.push(new Image(Assets.LOVER_CLUMSY04));
					
					_endingAr.push(new Image(Assets.LOVER_END01));
					_endingAr.push(new Image(Assets.LOVER_END02));
					_endingAr.push(new Image(Assets.LOVER_END03));
					_endingAr.push(new Image(Assets.LOVER_END04));
				break;
			}
			
			graphicAr = _startAr;
			
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
		
		public function start():void
		{
			frames = 0;
			index = 0;
			graphicAr = _startAr;
		}
		
		public function twist():void
		{
			frames = 0;
			index = 0;
			graphicAr = _twistAr;
		}
		
		public function recover():void
		{
			frames = 0;
			index = 0;
			graphicAr = _recoverAr;
		}
		
		public function ending():void
		{
			frames = 0;
			index = 0;
			graphicAr = _endingAr;
			end = true;
		}
		
	}

}