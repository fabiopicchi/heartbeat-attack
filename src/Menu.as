package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author 
	 */
	public class Menu extends Entity 
	{
		private var _selected : int = 0;
		private var _maxOptions: int = 0;
		private var _arX : Array = [];
		private var _arY : Array = [];
		private var _arCallbacks : Array = [];
		private var _disabled : Boolean = false;
		private var _toBeDisabled : Boolean = false;
		
		public function Menu(graphic : Graphic, cursorX : int, cursorY : int, callBack : Function) 
		{
			addGraphic (graphic);
			addOption (cursorX, cursorY, callBack);
			x = cursorX;
			y = cursorY;
		}
		
		public function addOption (cursorX : Number, cursorY : int, callBack : Function) : void
		{
			_arX.push (cursorX);
			_arY.push (cursorY);
			_arCallbacks.push (callBack);
			_maxOptions++;
		}
		
		public function get selected():int 
		{
			return _selected;
		}
		
		public function get disabled():Boolean 
		{
			return _disabled;
		}
		
		public function set disabled(value:Boolean):void 
		{
			visible = !value;
			_toBeDisabled = value;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (!_disabled)
			{
				if (Input.pressed ("UP"))
				{
					if (_selected == 0)
					{
						_selected = _maxOptions - 1;
					}
					else
					{
						_selected--;
					}
				}
				else if (Input.pressed ("DOWN"))
				{
					if (_selected == _maxOptions - 1)
					{
						_selected = 0;
					}
					else
					{
						_selected++;
					}
				}
				
				if (Input.pressed ("ENTER"))
				{
					this.x = _arX[selected];
					this.y = _arY[selected];
					_arCallbacks[selected]();
				}
			}
			
			if (_toBeDisabled != _disabled)
			{
				_disabled = _toBeDisabled;
			}
						
			this.x = _arX[selected] + (this.x - _arX[selected]) * 0.9;
			this.y = _arY[selected] + (this.y - _arY[selected]) * 0.9;
		}
	}
}