package  
{
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
	/**
	 * ...
	 * @author 
	 */
	public class Level extends World 
	{
		public var xmlLoader:XmlLoader;
		
		public static const PER_SECOND : Number = 0.016666666666667;
		public static const HELPER_RX : int = 519;
		public static const HELPER_LX : int = 286;
		public var missInterval : Number = 0.7;
		public var rightInterval : Number = 0.3;
		public static var bpm : int;
		public static var valsPerBeat : int;
		public static var noteSpeed : int;
		public var arNotes : Array = [];
		public var arEvents : Array = [];
		public var timer : Number = 0;
		private var shade : Entity;
		private var _level : int;
		
		public var helperUR : Helper;
		public var helperUL : Helper;
		public var helperDR : Helper;
		public var helperDL : Helper;
		
		public var upperTreadmill_1 : Treadmill;
		public var upperTreadmill_2 : Treadmill;
		public var lowerTreadmill_1 : Treadmill;
		public var lowerTreadmill_2 : Treadmill;
		
		public var hp : HeartContainer;
		
		public var heart : CountdownHeart;
		
		public var start : Number = 4;
		public var bInsert : Boolean = false;
		public var bStart : Boolean = false;
		public var bPaused : Boolean = false;
		public var pLock : Boolean = false;
		private var _menu : Menu;
		private var _score : int;
		private var _story : StageHeader;
		
		private static const RIGHT : int = 1;
		private static const WRONG : int = 2;
		private static const TOP : int = 14;
		private var balance : int = TOP;
		private var _totalNotes : Number;
		private var _notesRight : Number;
		
		public function Level(level : int) 
		{
			Main.soundChannel.stop();
			_level = level;
			loadStage();
			
			hp = new HeartContainer();
			
			upperTreadmill_1 = new Treadmill(0, 287, noteSpeed);
			upperTreadmill_2 = new Treadmill(upperTreadmill_1.tWidth, 287, noteSpeed);
			lowerTreadmill_1 = new Treadmill(-200, 483, noteSpeed);
			lowerTreadmill_2 = new Treadmill(-200 + lowerTreadmill_1.tWidth, 483, noteSpeed);
			add(upperTreadmill_1);
			add(upperTreadmill_2);
			add(lowerTreadmill_1);
			add(lowerTreadmill_2);
			
			_menu = new Menu (Image.createRect(20, 20), 150, 300, function () : void
			{
				Main.screenTransition(2, 0x000000, function () : void
				{
					FP.world = new Level(_level);
				});
			});
			_menu.addOption(150, 400, function () : void
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
					FP.world = new EndingScreen( _level, ((_notesRight / _totalNotes) < 0.90 ? 1 : 2));
				});
			}
			
			shade = new Entity();
			shade.addGraphic (Image.createRect (FP.engine.width, FP.engine.height, 0x000000, 0.7));
			
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
			
			arNotes = [];
			xmlLoader.load();
			
			bpm = xmlLoader.bpm;
			valsPerBeat = xmlLoader.npb;
			noteSpeed = (HELPER_RX - HELPER_LX) / (xmlLoader.lapse / (bpm * PER_SECOND * valsPerBeat));
			
			var i : int = 0;
			var length : int = xmlLoader.noteList.length;
			var n : Note;
			_totalNotes = length;
			_notesRight = 0;
			
			for (i = 0; i < length; i++)
			{
				n = new Note (xmlLoader.noteList[i].beat, getHelper (xmlLoader.noteList[i].helper));
				arNotes.push(n);
			}
			
			i = 0;
			length = xmlLoader.eventList.length;
			
			for (i = 0; i < length; i++)
			{
				var evt : IEvent;
				if (xmlLoader.eventList[i].name && xmlLoader.eventList[i].name.indexOf("note_") >= 0)
				{
					var arCode : Array = xmlLoader.eventList[i].name.split("_");
					if (arCode[1] == "UL" || arCode[1] == "DL")
						evt = new AddHorizontalSlide (xmlLoader.eventList[i].beat, arCode[1], HELPER_LX + (3 * xmlLoader.lapse / (bpm * PER_SECOND * valsPerBeat)) * noteSpeed);
					else
						evt = new AddHorizontalSlide (xmlLoader.eventList[i].beat, arCode[1], HELPER_RX + (2 * xmlLoader.lapse / (bpm * PER_SECOND * valsPerBeat)) * noteSpeed);
				}
				else if (xmlLoader.eventList[i].name == "storyStart")
				{
					evt = new StoryStart (xmlLoader.eventList[i].beat, _story);
				}
				else if (xmlLoader.eventList[i].name == "storyTwist")
				{
					evt = new StoryTwist (xmlLoader.eventList[i].beat, _story);
				}
				else if (xmlLoader.eventList[i].name == "storyRecover")
				{
					evt = new StoryRecover (xmlLoader.eventList[i].beat, _story);
				}
				else if (xmlLoader.eventList[i].name == "storyEnding")
				{
					evt = new StoryEnding (xmlLoader.eventList[i].beat, _story);
				}
				arEvents.push(evt);
			}
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
				add(hp);
				bStart = true;
				bInsert = true;
				Main.soundChannel.play();
			}
			
			
			
			if (Input.pressed("ESC"))
			{
				if (!bPaused)
				{
					Main.soundChannel.stop();
					_menu.disabled = false;
					add (shade);
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
			timer += FP.elapsed;
			
			var arRemoved : Array = [];
			var instant : Number = Main.soundChannel.position * bpm * PER_SECOND * valsPerBeat;
			
			if (instant % 1 >= 0 && instant % 1 <= 0.5 && !pLock)
			{
				helperUL.pulse();
				helperUR.pulse();
				helperDL.pulse();
				helperDR.pulse();
				pLock = true;
			}
			else if (instant % 1 > 0.5)
			{
				pLock = false;
			}
			for (var j : int = 0; j < arEvents.length; j++)
			{
				if (instant > arEvents[j].time && arEvents[j].time >= 0)
				{
					arEvents[j].trigger(instant);
					arRemoved.push(arEvents[j]);
				}
			}
			
			for each (var evt : IEvent in arRemoved)
			{
				arEvents.splice(arEvents.indexOf(evt), 1);
			}
			arRemoved = [];
			for (var i : int = 0; i < arNotes.length; i++)
			{
				var n : Note = arNotes[i];
				if (instant < Math.max(0, n.time - missInterval * valsPerBeat))
					break;
				else
				{
					if ((!Input.pressed(n.helper.code) && instant < n.time + missInterval * valsPerBeat) 
							|| (Input.pressed(n.helper.code) && !isInsideInterval(instant, Math.max (0, n.time - missInterval * valsPerBeat), n.time + missInterval * valsPerBeat)))
					{
						//NOTHING
					}
					else if (!Input.pressed(n.helper.code) && instant >= n.time + missInterval * valsPerBeat)
					{
						balance = Math.max (0, balance - WRONG);
						n.helper.wrong();
						arRemoved.push (n);
						timer = 0;
					}
					else 
					{
						if (isInsideInterval(instant, Math.max (0, n.time - rightInterval * valsPerBeat), n.time + rightInterval * valsPerBeat))
						{
							balance = Math.min (TOP, balance + RIGHT);
							_notesRight++;
							n.helper.correct();
							arRemoved.push (n);
							timer = 0;
						}
						else
						{
							balance = Math.max (0, balance - WRONG);
							n.helper.wrong();
							arRemoved.push (n);
							timer = 0;
						}
					}
				}
			}
			
			var lifePercentage : Number = balance / TOP;
			if (lifePercentage <= 1 && lifePercentage >= .75)
			{
				hp.good();
			}
			else if (lifePercentage < .75 && lifePercentage >= .50)
			{
				hp.ok();
			}
			else if (lifePercentage < .50 && lifePercentage >= .25)
			{
				hp.bad();
			}
			else if (lifePercentage < .25)
			{
				hp.danger();
			}
			
			if (balance == 0)
			{
				Main.soundChannel.stop();
				Main.screenTransition(2, 0x000000, function () : void
				{
					FP.world = new EndingScreen (_level, 0);
				});
			}
			
			for each (var note : Note in arRemoved)
			{
				arNotes.splice(arNotes.indexOf(note), 1);
			}
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