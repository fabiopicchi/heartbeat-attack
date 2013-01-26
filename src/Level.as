package  
{
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
		public static var channel1 : Sfx;
		public static const PER_SECOND : Number = 0.016666666666667;
		public var missInterval : Number = 0.4;
		public var rightInterval : Number = 0.2;
		public var bpm : int = 60;
		public var valsPerBeat : int = 2;
		public var arNotesInput : Array = [];
		private var textBox : Entity;
		private var textField : Text = new Text ("", 20, 20);
		public var timer : Number = 0;
		public var boxA : Entity;
		public var boxB : Entity;
		public var start : Number = 4;
		public var bInsert : Boolean = false;
		public var bStart : Boolean = false;
		
		public function Level() 
		{
			channel1 = new Sfx(Assets.METRONOMO);
			textBox = new Entity ();
			
			textBox.width = 20;
			textBox.height = 20;
			textBox.x = (FP.engine.width - textBox.width) / 2;
			textBox.y = (FP.engine.height - textBox.height) / 2;
			
			textBox.addGraphic(textField);
			
			add (textBox);
			
			boxA = new Entity ();
			boxA.addGraphic(Image.createRect(20, 20, 0xFF0000));
			boxA.x = 0.75 * FP.engine.width - 10;
			boxA.y = 100;
			add (boxA);
			
			boxB = new Entity ();
			boxB.addGraphic(Image.createRect(20, 20, 0x00FF00));
			boxB.x = 0.25 * FP.engine.width - 10;
			boxB.y = 100;
			add (boxB);
			
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
			}
		}
		
		override public function update():void 
		{
			if (start > 0)
			{
				start -= FP.elapsed;
				return;
			}
			else if (!bStart)
			{
				bStart = true;
				bInsert = true;
				add (new HorizontalSlide());
				channel1.loop();
			}
			
			super.update();
			timer += FP.elapsed;
			
			var arNotesRemoved : Array = [];
			var instant : Number = channel1.position * bpm * PER_SECOND * valsPerBeat;
			
			if (instant % 2 > 1 && bInsert)
			{
				bInsert = false;
			}
			
			if (instant % 2 > 0 && instant % 2 < 1 && !bInsert)
			{
				bInsert = true;
				add (new HorizontalSlide());
			}
			
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
						continue;
					}
					else if (!Input.pressed(n.value) && instant >= Math.min(channel1.length * valsPerBeat, n.time + missInterval * valsPerBeat))
					{
						textField.text = "PASS " + n.time;
						arNotesRemoved.push (n);
						timer = 0;
					}
					else 
					{
						if (isInsideInterval(instant, Math.max (0, n.time - rightInterval * valsPerBeat), Math.min(channel1.length * valsPerBeat, n.time + rightInterval * valsPerBeat)))
						{
							textField.text = "RIGHT " + n.time;
							arNotesRemoved.push (n);
							timer = 0;
						}
						else
						{
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