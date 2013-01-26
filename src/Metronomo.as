package  
{
	/**
	 * ...
	 * @author 
	 */
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	
	public class Metronomo extends World
	{
		public static var channel1 : Sfx;
		public static const PER_SECOND : Number = 0.016666666666667;
		public var missInterval : Number = 0.4;
		public var rightInterval : Number = 0.2;
		public var bpm : int = 60;
		public var valsPerBeat : int = 2;
		public var arNotesInput : Array = [];
		private var textBox : Entity;
		private var textField : Text = new Text ("", 20, 20);
		public var timer : int = 0;
		
		public function Metronomo() 
		{
			channel1 = new Sfx(Assets.METRONOMO);
			channel1.loop();
			textBox = new Entity ();
			
			textBox.width = 20;
			textBox.height = 20;
			textBox.x = (FP.engine.width - textBox.width) / 2;
			textBox.y = (FP.engine.height - textBox.height) / 2;
			
			textBox.addGraphic(textField);
			
			add (textBox);
			
			for (var i : int = 0; i < 12 * valsPerBeat; i++)
			{
				if (i % 2 == 0)
				{
					arNotesInput.push(new Note (i, Note.A));
				}
				else
				{
					arNotesInput.push(new Note (i, Note.B));
				}
			}
			
			channel1.complete = function ()
			{
				arNotesInput = [];
				for (var i : int = 0; i < 12 * valsPerBeat; i++)
				{
					if (i % 2 == 0)
					{
						arNotesInput.push(new Note (i, Note.A));
					}
					else
					{
						arNotesInput.push(new Note (i, Note.B));
					}
				}
				trace (arNotesInput.length);
			}
		}
		
		override public function update():void 
		{
			super.update();
			timer += FP.elapsed;
			
			var arNotesRemoved : Array = [];
			var instant : Number = channel1.position * bpm * PER_SECOND * valsPerBeat;
			
			for (var i : int = 0; i < arNotesInput.length; i++)
			{
				var n : Note = arNotesInput[i];
				if (instant < Math.max(0, n.time - missInterval))
					break;
				else
				{
					if ((!Input.pressed(n.value) && instant < Math.min(channel1.length * valsPerBeat, n.time + missInterval * valsPerBeat)) 
							|| (Input.pressed(n.value) && !isInsideInterval(instant, Math.max (0, n.time - missInterval * valsPerBeat), Math.min(channel1.length * valsPerBeat, n.time + missInterval * valsPerBeat))))
					{
						//if ((Input.pressed(n.value) && !isInsideInterval(instant, Math.max (0, n.time - missInterval), Math.min(channel1.length, n.time + missInterval))))
						//{
							//trace ("MAR");
							//trace (instant);
							//trace (Math.max (0, n.time - missInterval));
							//trace (Math.min(channel1.length, n.time + missInterval));
						//}
						continue;
					}
					else if (!Input.pressed(n.value) && instant >= Math.min(channel1.length * valsPerBeat, n.time + missInterval * valsPerBeat))
					{
						textField.text = "PASS " + n.time;
						arNotesRemoved.push (n);
						timer = 0;
					}
					else if (Input.pressed(n.value) && isInsideInterval(instant, Math.max (0, n.time - missInterval * valsPerBeat), Math.min(channel1.length * valsPerBeat, n.time + missInterval * valsPerBeat)))
					{
						if (isInsideInterval(instant, Math.max (0, n.time - rightInterval * valsPerBeat), Math.min(channel1.length * valsPerBeat, n.time + rightInterval * valsPerBeat)))
						{
							textField.text = "RIGHT " + n.time;
							arNotesRemoved.push (n);
							timer = 0;
						}
						else
						{
							trace ("MISS");
							textField.text = "MISS " + n.time;
							arNotesRemoved.push (n);
							timer = 0;
						}
					}
				}
			}
			
			for each (var note : Note in arNotesRemoved)
			{
				arNotesInput.splice(arNotesInput.indexOf(note), 1);
			}
			
			//if (Input.pressed("UP"))
			//{
				//var n : Number = channel1.position * bpm * PER_SECOND * valsPerBeat;
				//for each (var note : int in arNotes)
				//{
					//if (n > note - (0.2) && n < note + (0.2))
					//{
						//textField.text = "PERFECT";
					//}
				//}
			//}
			//\
			
			if (timer > 0.5)
			{
				textField.text = "";
			}
			
			
		}
		
		public function isInsideInterval (value : Number, min : Number, max : Number) : Boolean
		{
			return (value > min && value < max);
		}
	}
}