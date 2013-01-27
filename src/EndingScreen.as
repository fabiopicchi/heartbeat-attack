package  
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import Assets;
	
	/**
	 * ...
	 * @author 
	 */
	public class EndingScreen extends World 
	{
		private var _menu : Menu;
		private var _level : int;
		
		private var _background : Image;
		private var _resultImage : Image;
		private var _resultScene : Image;
		private var _heart : Heart;
		
		public function EndingScreen(level : int, result : int) 
		{
			_level = level;
			
			if (result == 0) //FAIL
			{
				_menu = new Menu(new Image (Assets.ARROW), 403, 518, resetLevel);
				_menu.addOption(137, 518, backToMenu);
				_background = new Image(Assets.BACKGROUND_GAMEOVER);
				addGraphic(_background);
				Main.soundChannel = new Sfx (Assets.WRONG);
				Main.soundChannel.play();
			}
			else
			{
				_menu = new Menu(new Image (Assets.ARROW), 564, 512, next);
				_menu.addOption(294, 512, backToMenu);
				Main.soundChannel = new Sfx (Assets.RIGHT);
				Main.soundChannel.play();
				_background = new Image(Assets.BACKGROUND_ENDGAME);
				addGraphic(_background);
				_heart = new Heart(30, 334);
				if (result == 1) //WELL
				{
					_resultImage = new Image(Assets.GAMEEND_WELL);
					_resultImage.x = 467;
					_resultImage.y = 357;
					addGraphic(_resultImage);
					switch (level)
					{
						case 1:
							_resultScene = new Image(Assets.SLEEPER_END_OK);
							_resultScene.x = 189;
							_resultScene.y = 50;
						break;
						case 2:
							_resultScene = new Image(Assets.SLACKER_END_OK);
							_resultScene.x = 189;
							_resultScene.y = 50;
						break;
						case 3:
							_resultScene = new Image(Assets.LOVER_END_OK);
							_resultScene.x = 425;
							_resultScene.y = 50;
						break;
					}
					addGraphic(_resultScene);
				}
				else //GREAT
				{
					_resultImage = new Image(Assets.GAMEEND_GREAT);
					_resultImage.x = 403;
					_resultImage.y = 350;
					addGraphic(_resultImage);
					switch (level)
					{
						case 1:
							_resultScene = new Image(Assets.SLEEPER_END_GREAT);
							_resultScene.x = 246;
							_resultScene.y = 50;
						break;
						case 2:
							_resultScene = new Image(Assets.SLACKER_END_GREAT);
							_resultScene.x = 246;
							_resultScene.y = 50;
						break;
						case 3:
							_resultScene = new Image(Assets.LOVER_END_GREAT);
							_resultScene.x = 218;
							_resultScene.y = 50;
						break;
					}
					addGraphic(_resultScene);
				}
				add(_heart);
			}
			add (_menu);
		}
		
		private function next():void 
		{
			if (_level == 1 || _level == 2)
			{
				FP.world = new Level(_level + 1);
			}
			else if (_level == 3)
			{
				//TELA DE ENDING
				FP.world = new TheEnd();
			}
		}
		
		private function backToMenu():void 
		{
			FP.world = new MenuScreen();
		}
		
		private function resetLevel():void 
		{
			FP.world = new Level(_level);
		}
		
	}

}