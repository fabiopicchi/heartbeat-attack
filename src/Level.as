package  
{
	import flash.display.Graphics;
	import Loader.XmlLoader;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import StageAnimation.StageHeader;
	/**
	 * ...
	 * @author 
	 */
	public class Level extends World 
	{
		public var xmlLoader:XmlLoader;
		
		public static const PER_SECOND : Number = 0.016666666666667;
		public static const HELPER_RX : int = 525;
		public static const HELPER_LX : int = 286;
		
		public var missInterval : Number = 0.7;
		public var rightInterval : Number = 0.3;
		
		private var _shade : Entity;
		private var _pauseScreen : Entity;
		private var _level : int;
		
		public var helperUR : Helper;
		public var helperUL : Helper;
		public var helperDR : Helper;
		public var helperDL : Helper;
		
		public var heart : CountdownHeart;
		
		public var start : Number = 4;
		public var bStart : Boolean = false;
		public var bPaused : Boolean = false;
		public var pulseLock : Boolean = false;
		private var _menu : Menu;
		private var _score : int;
		private var _story : StageHeader;
		
		private var _notesRight : Number = 0;
		private var instant:Number;
		
		public function Level(level : int) 
		{
			Main.soundChannel.stop();
			_level = level;
			loadStage();
			
			add(new Treadmill(0, 287, xmlLoader.noteSpeed));
			add(new Treadmill(-200, 483, xmlLoader.noteSpeed));
			
			_menu = new Menu (new Image(Assets.ARROW), 255, 220, function () : void
			{
				Main.screenTransition(2, 0x000000, function () : void
				{
					FP.world = new Level(_level);
				});
			});
			_menu.addOption(255, 325, function () : void
			{
				Main.screenTransition(2, 0x000000, function () : void
				{
					FP.world = new MenuScreen;
				});
			});
			_menu.disabled = true;
			
			Main.soundChannel.complete = function () : void
			{
				Main.soundChannel.stop();
				Main.soundChannel.complete = null;
				Main.screenTransition(2, 0x000000, function () : void
				{
					if ((_notesRight / xmlLoader.numNotes) < 0.50)
						FP.world = new EndingScreen( _level, 0);
					
					else if ((_notesRight / xmlLoader.numNotes) < 0.90)
						FP.world = new EndingScreen( _level, 1);
					
					else
						FP.world = new EndingScreen( _level, 2);
				});
			}
			
			_shade = new Entity();
			_shade.addGraphic (Image.createRect (FP.engine.width, FP.engine.height, 0x000000, 0.7));
			
			_pauseScreen = new Entity();
			_pauseScreen.addGraphic(new Image(Assets.PAUSE_OPTIONS));
			
			heart = new CountdownHeart();
			heart.x = (FP.engine.width / 2) - (heart.halfWidth);
			heart.y = (FP.engine.height / 2) - (heart.halfHeight);
			
			add (helperDL);
			add (helperDR);
			add (helperUR);
			add (helperUL);
			add(heart);
		}
		
		private function getHelper (code : int) : Helper
		{
			switch (code)
			{
				case 0:
					return helperUL;
					break;
				case 1:
					return helperUR;
					break;
				case 2:
					return helperDL;
					break;
				case 3:
					return helperDR;
					break;
				default:
					break;
			}
			return null;
		}
		
		private function loadStage () : void
		{
			helperDL = new Helper (Helper.DL);
			helperDR = new Helper (Helper.DR);
			helperUR = new Helper (Helper.UR);
			helperUL = new Helper (Helper.UL);
			
			var e : Entity
			switch (_level)
			{
				case 1:
					e = new Entity(0, 0, new Image(Assets.BACKGROUND_SLEEPER));
					xmlLoader = new XmlLoader(new Assets.FASE_1);
					Main.soundChannel = new Sfx(Assets.DREAMY);
					break;
				case 2:
					e = new Entity(0, 0, new Image(Assets.BACKGROUND_BROWSER));
					xmlLoader = new XmlLoader(new Assets.FASE_2);
					Main.soundChannel = new Sfx(Assets.NYAN);
					break;
				case 3:
					e = new Entity(0, 0, new Image(Assets.BACKGROUND_LOVER));
					xmlLoader = new XmlLoader(new Assets.FASE_3);
					Main.soundChannel = new Sfx(Assets.SPAGHETTI);
					break;
			}
			add(e);
			
			_story = new StageHeader(_level);
			add(_story);
			
			e = new Entity(0, 0, new Image(Assets.BACKGROUND_OVER));
			add(e);
			
			e = new Entity(0, 223, new Image(Assets.BACKGROUND));
			add(e);
			
			xmlLoader.load();
			_notesRight = 0;
		}
		
		override public function update():void 
		{
			if (start > 0)
			{
				super.update();
				start -= FP.elapsed;
				if (start <= 0 && start > -FP.elapsed)
				{
					heart.count();
				}
				else if (start <= 1 && start > 1 -FP.elapsed)
				{
					heart.count();
				}
				else if (start <= 2 && start > 2 -FP.elapsed)
				{
					heart.count();
				}
				else if (start <= 3 && start > 3 -FP.elapsed)
				{
					heart.count();
				}
				return;
			}
			else if (!bStart)
			{
				remove(heart);
				bStart = true;
				Main.soundChannel.play();
			}
			
			if (Input.pressed("ESC"))
			{
				if (!bPaused)
				{
					Main.soundChannel.stop();
					_menu.disabled = false;
					add (_shade);
					add (_pauseScreen);
					add (_menu);
					bPaused = true;
				}
			}
			
			if (bPaused) 
			{
				_menu.update();
				return;
			}
			
			super.update();
			instant = Main.soundChannel.position * xmlLoader.bpm * xmlLoader.npb * PER_SECOND;
			
			if (instant % 1 >= 0 && instant % 1 <= 0.5 && !pulseLock)
			{
				helperUL.pulse();
				helperUR.pulse();
				helperDL.pulse();
				helperDR.pulse();
				pulseLock = true;
			}
			else if (instant % 1 > 0.5)
			{
				pulseLock = false;
			}
			
			var i : int = 0;
			
			for (i = 0; i < xmlLoader.numEvents; i++)
			{
				if (!xmlLoader.eventList[i].checked && instant > xmlLoader.eventList[i].beat)
					handleEvent(xmlLoader.eventList[i]);
			}
			
			for (i = 0; i < xmlLoader.numNotes; i++)
			{
				var e : SongEvent = xmlLoader.noteList[i];
				if (!e.checked)
				{
					if (instant < Math.max(0, e.beat - missInterval * xmlLoader.npb))
						break;
					else
					{
						var helper : Helper = getHelper(e.args.helper);
						if ((!Input.pressed(helper.code) && instant < e.beat + missInterval * xmlLoader.npb) 
								|| (Input.pressed(helper.code) && !isInsideInterval(instant, Math.max (0, e.beat - missInterval * xmlLoader.npb), e.beat + missInterval * xmlLoader.npb)))
						{
							//NOTHING
						}
						else if (!Input.pressed(helper.code) && instant >= e.beat + missInterval * xmlLoader.npb)
						{
							helper.wrong();
							e.checked = true;
						}
						else 
						{
							if (isInsideInterval(instant, Math.max (0, e.beat - rightInterval * xmlLoader.npb), e.beat + rightInterval * xmlLoader.npb))
							{
								_notesRight++;
								helper.correct();
								e.checked = true;
							}
							else
							{
								helper.wrong();
								e.checked = true;
							}
						}
					}
				}
			}
		}
		
		private function handleEvent(e : SongEvent):void 
		{
			switch (e.type)
			{
				case SongEvent.NOTE_ENTRY:
					add (new HorizontalSlide(e.args.code, e.args.xStart - ((instant - e.beat) / (xmlLoader.bpm * xmlLoader.npb / 60)) * xmlLoader.noteSpeed, xmlLoader.noteSpeed));
					break;
				case SongEvent.STORY_START:
					_story.start();
					break;
				case SongEvent.STORY_TWIST:
					_story.twist();
					break;
				case SongEvent.STORY_RECOVER:
					_story.recover();
					break;
				case SongEvent.STORY_ENDING:
					_story.ending();
					break;
			}
			
			e.checked = true;
		}
		
		override public function render():void 
		{
			super.render();
		}
		
		public function isInsideInterval (value : Number, min : Number, max : Number) : Boolean
		{
			return (value >= min && value <= max);
		}
		
	}

}