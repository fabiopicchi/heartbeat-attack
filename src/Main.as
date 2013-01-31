package 
{
	import com.greensock.easing.Linear;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.utils.getQualifiedClassName;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Chambers
	 */
	
	[SWF(width = "800", height = "600")]
	[Frame(factoryClass = "Preloader")]
	public class Main extends Engine 
	{
		public static var soundChannel : Sfx;
		
		public function Main():void 
		{
			super (800, 600);
		}
		
		override public function init():void 
		{
			super.init();
			
			Input.define("UL", Key.A);
			Input.define("UR", Key.K);
			Input.define("DL", Key.Z);
			Input.define("DR", Key.M);
			
			Input.define("UP", Key.UP, Key.LEFT);
			Input.define("DOWN", Key.DOWN, Key.RIGHT);
			Input.define("ENTER", Key.ENTER);
			Input.define("ESC", Key.ESCAPE, Key.P);
			
			FP.world = new MenuScreen;
			
			
		}
		
		private static var bTransition : Boolean = false;
		private static var whiteScreen : Sprite;
		public static function screenTransition (time : Number, color : uint = 0xffffff, callbackFoward : Function = null, callbackBackward : Function = null, bForce : Boolean = false) : void
		{
			if (whiteScreen == null)
			{
				whiteScreen = new Sprite();
				whiteScreen.alpha = 0;
			}
			if (!bTransition || bForce)
			{
				if (bForce)
				{
					TweenLite.killTweensOf(whiteScreen);
				}
				whiteScreen.graphics.clear();
				whiteScreen.graphics.beginFill(color);
				whiteScreen.graphics.drawRect(0, 0, FP.engine.width, FP.engine.height);
				FP.stage.addChild(whiteScreen);
				TweenLite.to (whiteScreen, (time / 2) * (1 - whiteScreen.alpha), { alpha : 1, ease : Linear.easeInOut, onComplete : function () : void {
					if (callbackFoward != null) callbackFoward();
					TweenLite.to (whiteScreen, time / 2, { alpha : 0, ease : Linear.easeInOut, onComplete : function () :void {
						if (callbackBackward != null) callbackBackward();
						FP.stage.removeChild(whiteScreen);
						bTransition = false;
					}});
				}});
			}
			bTransition = true;
		}
		
	}
	
}