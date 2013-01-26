package  
{
	import Loader.XmlLoader;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
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
		public var missInterval : Number = 0.4;
		public var rightInterval : Number = 0.15;
		public var bpm : int = 90;
		public var valsPerBeat : int = 1;
		public var arNotes : Array = [];
		public var arEvents : Array = [];
		private var textBox : Entity;
		private var textField : Text = new Text ("", 20, 20);
		public var timer : Number = 0;
		
		public var helperUR : Helper;
		public var helperUL : Helper;
		public var helperDR : Helper;
		public var helperDL : Helper;
		
		public var start : Number = 4;
		public var bInsert : Boolean = false;
		public var bStart : Boolean = false;
		
		public function Level() 
		{
			channel1 = new Sfx(Assets.TESTE_1);
			channel2 = new Sfx(Assets.TESTE_2);
			channelBase = new Sfx(Assets.TESTE_BASE);
			textBox = new Entity ();
			
			textBox.width = 20;
			textBox.height = 20;
			textBox.x = (FP.engine.width - textBox.width) / 2;
			textBox.y = (FP.engine.height - textBox.height) / 2;
			
			textBox.addGraphic(textField);
			
			add (textBox);
			
			helperDL = new Helper (Helper.DL);
			helperDR = new Helper (Helper.DR);
			helperUR = new Helper (Helper.UR);
			helperUL = new Helper (Helper.UL);
			
			helperDL.y = 300;
			helperDL.x = 300;
			helperDR.y = 300;
			helperDR.x = 600;
			helperUR.y = 100;
			helperUR.x = 300;
			helperUL.y = 100;
			helperUL.x = 600;
			
			add (helperDL);
			add (helperDR);
			add (helperUR);
			add (helperUL);
			
			loadStage();
			
			//trace (channel1.length);
			//trace (channel2.length);
			//trace (channelBase.length);
			
			channel1.complete = function () : void
			{
				loadStage();
				start = 4;
				bStart = false;
			}
			xmlLoader = new XmlLoader(new Assets.FASE_1);
			xmlLoader.load();
		}
		
		private function getHelper (code : String) : Helper
		{
			switch (code)
			{
				case Helper.DL:
					return helperDL;
					break;
				case Helper.DR:
					return helperDR;
					break;
				case Helper.UR:
					return helperUR;
					break;
				case Helper.UL:
					return helperUL;
					break;
			}
			return null;
		}
		
		private function loadStage () : void
		{
			arNotes = [];
			
			for (var i : int = 0; i <= bpm * PER_SECOND * valsPerBeat * channel1.length; i++)
			{
				var n : Note;
				if (i % 2 == 0)
				{
					n = new Note (i, getHelper(Helper.UR));
				}
				else
				{
					arEvents.push(new AddHorizontalSlide(i));
					n = new Note (i, getHelper(Helper.UL));
				}
				arNotes.push(n);
			}
		}
		
		override public function update():void 
		{
			if (start > 0)
			{
				start -= FP.elapsed;
				if (start < 0)
				{
					textField.text = "START";
				}
				else if (start < 1)
				{
					textField.text = "1";
				}
				else if (start < 2)
				{
					textField.text = "2";
				}
				else if (start < 3)
				{
					textField.text = "3";
				}
				return;
			}
			else if (!bStart)
			{
				bStart = true;
				bInsert = true;
				channel1.play();
				channel2.play();
				channelBase.play();
			}
			
			super.update();
			timer += FP.elapsed;
			
			var arRemoved : Array = [];
			var instant : Number = channel1.position * bpm * PER_SECOND * valsPerBeat;
			
			for (var j : int = 0; j < arEvents.length; j++)
			{
				if (instant > arEvents[j].time)
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
			
			if (Input.pressed(Key.UP) || Input.pressed(Key.DOWN))
			{
				//trace (instant);
			}
			
			for (var i : int = 0; i < arNotes.length; i++)
			{
				var n : Note = arNotes[i];
				//if (Input.pressed(Key.UP) || Input.pressed(Key.DOWN))
				//{
					//trace (instant);
					//trace (Math.max (0, n.time - rightInterval * valsPerBeat));
					//trace (Math.min(channel1.length * valsPerBeat * bpm * PER_SECOND, n.time + rightInterval * valsPerBeat));
				//}
				if (instant < Math.max(0, n.time - missInterval * valsPerBeat))
					break;
				else
				{
					if ((!Input.pressed(n.helper.code) && instant < Math.min(channel1.length * valsPerBeat * bpm * PER_SECOND, n.time + missInterval * valsPerBeat)) 
							|| (Input.pressed(n.helper.code) && !isInsideInterval(instant, Math.max (0, n.time - missInterval * valsPerBeat), Math.min(channel1.length * valsPerBeat * bpm * PER_SECOND, n.time + missInterval * valsPerBeat))))
					{
						//if (Input.pressed(n.helper.code))
						//{
							//trace (instant);
							//trace (Math.max (0, n.time - missInterval * valsPerBeat));
							//trace (Math.min(channel1.length * valsPerBeat, n.time + missInterval * valsPerBeat));
							//trace ("CONTINUE " + instant);
						//}
						//NADA
					}
					else if (!Input.pressed(n.helper.code) && instant >= Math.min(channel1.length * valsPerBeat * bpm * PER_SECOND, n.time + missInterval * valsPerBeat))
					{
						//trace ("PASS " + n.time);
						textField.text = "PASS " + n.time;
						n.helper.wrong();
						arRemoved.push (n);
						timer = 0;
					}
					else 
					{
						if (isInsideInterval(instant, Math.max (0, n.time - rightInterval * valsPerBeat), Math.min(channel1.length * valsPerBeat * bpm * PER_SECOND, n.time + rightInterval * valsPerBeat)))
						{
							//trace ("RIGHT " + n.time);
							textField.text = "RIGHT " + n.time;
							n.helper.correct();
							arRemoved.push (n);
							timer = 0;
						}
						else
						{
							//trace ("MISS " + n.time);
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
		
		public function isInsideInterval (value : Number, min : Number, max : Number) : Boolean
		{
			return (value >= min && value <= max);
		}
		
	}

}