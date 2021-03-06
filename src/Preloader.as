package
{
	import flash.display.*;
	import flash.text.*;
	import flash.events.*;
	import flash.utils.clearInterval;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import net.flashpunk.graphics.Image;
 
	public class Preloader extends Sprite
	{
		private static const mainClassName: String = "Main";
		
		private var loader : MovieClip;
		
		private var progressBar: Shape;
		private var text: TextField;
		
		private static const BG_COLOR:uint = 0x000000;
		private static const FG_COLOR:uint = 0xFFFFFF;
		
		private var px:int;
		private var py:int;
		private var w:int;
		private var h:int;
		private var sw:int;
		private var sh:int;
		
		public function Preloader ()
		{			
			sw = stage.stageWidth;
			sh = stage.stageHeight;
			
			loader = new Loading();
			addChild(loader);
			
			w = 670;
			h = 21;
			px = 65;
			py = 507;
			
			text = new TextField();
			text.autoSize = "left";
			text.text = "0%";
			text.x = (sw - text.width) * 0.5;
			text.y = py - (h - text.height) / 2;
			
			progressBar = new Shape();
			addChild(progressBar);
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
 
		public function onEnterFrame (e:Event): void
		{
			if (hasLoaded())
			{
				startup();
			} 
			else
			{
				var p:Number = (loaderInfo.bytesLoaded / loaderInfo.bytesTotal);
				
				progressBar.graphics.clear();
				progressBar.graphics.beginFill(0xff571f);
				progressBar.graphics.drawRect(px, py, p * w, h);
				progressBar.graphics.endFill();
			}
		}
		
		private function hasLoaded (): Boolean {
			return (loaderInfo.bytesLoaded >= loaderInfo.bytesTotal);
		}
		
		private function startup (): void {
			stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			var mainClass:Class = getDefinitionByName(mainClassName) as Class;
			stage.addChild(new mainClass as DisplayObject);
			
			parent.removeChild(this);
		}
	}
}