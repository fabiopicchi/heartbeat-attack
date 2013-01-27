package
{
	import flash.display.*;
	import flash.text.*;
	import flash.events.*;
	import flash.utils.clearInterval;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import net.flashpunk.graphics.Image;
 
	[SWF(width = "800", height = "600")]
	public class Preloader extends Sprite
	{
		private static const mainClassName: String = getQualifiedClassName(Main);
		
		private var loader : MovieClip;
		
		private var progressBar: Shape;
		
		private var px:int;
		private var py:int;
		private var w:int;
		private var h:int;
		private var sw:int;
		private var sh:int;
		
		public function Preloader ()
		{			
			loader = new Assets.LOADER;
			addChild(loader);
			
			w = 670;
			h = 21;
			px = 69;
			py = 524;
			
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
			//clearInterval (1);
			//removeChild(loader);
			
			var mainClass:Class = getDefinitionByName(mainClassName) as Class;
			stage.addChild(new mainClass as DisplayObject);
			
			parent.removeChild(this);
		}
	}
}