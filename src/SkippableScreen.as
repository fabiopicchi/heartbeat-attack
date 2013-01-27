package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author 
	 */
	public class SkippableScreen extends Entity 
	{
		private var _time : Number;
		private var _callback : Function;
		private var _instance : SkippableScreen;
		
		public function SkippableScreen(graphic : Graphic, callBack : Function, time : Number = 0) 
		{
			addGraphic (graphic);
			_time = time;
			_callback = callBack;
			_instance = this;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (_time > 0) _time -= FP.elapsed;
			
			if (_time < 0 || Input.pressed("ESC") || Input.pressed("ENTER"))
			{
				Main.screenTransition(2, 0x000000, function () : void
				{
					_callback();
				});
			}
		}
		
	}

}