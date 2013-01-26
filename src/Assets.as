package  
{
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author 
	 */
	public class Assets 
	{
		[Embed(source = '../resources/metronomo bpm 60.mp3')] public static const METRONOMO:Class;
		
		
		public static function getHelperAsset (code : String) : Graphic
		{
			switch (code)
			{
				case "UP":
					return Image.createRect(20, 20, 0xFFFFFF);
					break;
				case "DOWN":
					return Image.createRect(20, 20, 0xFF0000);
					break;
				case "LEFT":
					return Image.createRect(20, 20, 0x00FF00);
					break;
				case "RIGHT":
					return Image.createRect(20, 20, 0x0000FF);
					break;
			}
			return null;
		}
		
		public function Assets() 
		{
			
		}
		
	}

}