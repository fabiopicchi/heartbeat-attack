package  
{
	import Loader.XmlLoader;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
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
		public static var channel1 : Sfx;
		public static var channel2 : Sfx;
		public static var channelBase : Sfx;
		
		public static const PER_SECOND : Number = 0.016666666666667;
		public static const HELPER_RX : int = 524;
		public static const HELPER_LX : int = 271;
		public var missInterval : Number = 0.4;
		public var rightInterval : Number = 0.15;
		public static var bpm : int;
		public static var valsPerBeat : int;
		public static var noteSpeed : int;
		public var arNotes : Array = [];
		public var arEvents : Array = [];
		private var textBox : Entity;
		private var textField : Text = new Text ("", 20, 20);
		public var timer : Number = 0;
		private var shade : Entity;
		
		public var helperUR : Helper;
		public var helperUL : Helper;
		public var helperDR : Helper;
		public var helperDL : Helper;
		
		public var upperTreadmill_1 : Treadmill;
		public var upperTreadmill_2 : Treadmill;
		public var lowerTreadmill_1 : Treadmill;
		public var lowerTreadmill_2 : Treadmill;
		
		public var heart : CountdownHeart;
		
		public var start : Number = 4;
		public var bInsert : Boolean = false;
		public var bStart : Boolean = false;
		public var bPaused : Boolean = false;
		public var pLock : Boolean = false;
		private var _menu : Menu;
		
		
		public function Level() 
		{
			loadStage();
			
			var e : Entity
			var level : int = 1;
			switch (level)
			{
				case 1:
					e = new Entity(0, 0, new Image(Assets.BACKGROUND_SLEEPER));
					break;
				case 2:
					e = new Entity(0, 0, new Image(Assets.BACKGROUND_BROWSER));
					break;
				case 3:
					e = new Entity(0, 0, new Image(Assets.BACKGROUND_LOVER));
					break;
			}
			add(e);
			
			e = new StageHeader(level);
			add(e);
			
			e = new Entity(0, 0, new Image(Assets.BACKGROUND_OVER));
			add(e);
			
			e = new Entity(0, 223, new Image(Assets.BACKGROUND));
			add(e);
			
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
				FP.world = new Level;
			});
			_menu.addOption(150, 400, function () : void
			{
				FP.world = new MenuScreen;
			});
			_menu.disabled = true;
			
			//channel1 = new Sfx(Assets.DREAMY_1);
			//channel2 = new Sfx(Assets.DREAMY_2);
			//channelBase = new Sfx(Assets.DREAMY_BASE);
			
			channel1 = new Sfx(Assets.TESTE_1);
			channel2 = new Sfx(Assets.TESTE_2);
			channelBase = new Sfx(Assets.TESTE_BASE);
			
			textBox = new Entity ();
			
			textBox.width = 20;
			textBox.height = 20;
			textBox.x = (FP.engine.width - textBox.width) / 2;
			textBox.y = (FP.engine.height - textBox.height) / 2;
			
			shade = new Entity();
			shade.addGraphic (Image.createRect (FP.engine.width, FP.engine.height, 0x000000, 0.7));
			
			textBox.addGraphic(textField);
			
			heart = new CountdownHeart();
			heart.x = (FP.engine.width / 2) - (heart.halfWidth);
			heart.y = (FP.engine.height / 2) - (heart.halfHeight);
			
			add (textBox);
			
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
					trace ("RETURN");
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
			
			arNotes = [];
			xmlLoader = new XmlLoader(new Assets.FASE_1);
			xmlLoader.load();
			
			bpm = xmlLoader.bpm;
			valsPerBeat = xmlLoader.npb;
			noteSpeed = (HELPER_RX - HELPER_LX) / (xmlLoader.lapse / (bpm * PER_SECOND * valsPerBeat));
			
			var i : int = 0;
			var length : int = xmlLoader.noteList.length;
			var n : Note;
			
			for (i = 0; i < length; i++)
			{
				n = new Note (xmlLoader.noteList[i].beat, getHelper (xmlLoader.noteList[i].helper));
				arNotes.push(n);
				//trace (n.time);
			}
			
			i = 0;
			length = xmlLoader.eventList.length;
			
			for (i = 0; i < length; i++)
			{
				if (xmlLoader.eventList[i].name && xmlLoader.eventList[i].name.indexOf("note_") >= 0)
				{
					var arCode : Array = xmlLoader.eventList[i].name.split("_");
					var evt : AddHorizontalSlide = new AddHorizontalSlide (xmlLoader.eventList[i].beat, arCode[1], HELPER_RX + (2 * xmlLoader.lapse / (bpm * PER_SECOND * valsPerBeat)) * noteSpeed);
					arEvents.push(evt);
				}
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
				bStart = true;
				bInsert = true;
				channel1.play();
				channel2.play();
				channelBase.play();
			}
			
			
			
			if (Input.pressed("ESC"))
			{
				if (!bPaused)
				{
					channel1.stop();
					channel2.stop();
					channelBase.stop();
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
			
			var instant : Number = channel1.position * bpm * PER_SECOND * valsPerBeat;
			
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
					arEvents[j].trigger();
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
						//NADA
					}
					else if (!Input.pressed(n.helper.code) && instant >= n.time + missInterval * valsPerBeat)
					{
						textField.text = "PASS " + n.time;
						n.helper.wrong();
						arRemoved.push (n);
						timer = 0;
					}
					else 
					{
						if (isInsideInterval(instant, Math.max (0, n.time - rightInterval * valsPerBeat), n.time + rightInterval * valsPerBeat))
						{
							textField.text = "RIGHT " + n.time;
							n.helper.correct();
							arRemoved.push (n);
							timer = 0;
						}
						else
						{
							textField.text = "MISS " + n.time;
							n.helper.wrong();
							arRemoved.push (n);
							timer = 0;
						}
					}
				}
			}
			
			for each (var note : Note in arRemoved)
			{
				arNotes.splice(arNotes.indexOf(note), 1);
			}
			
			if (timer > 0.5)
			{
				textField.text = "";
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