package  
{
	/**
	 * ...
	 * @author 
	 */
	public class Assets 
	{
		[Embed(source = '../resources/metronomo bpm 60.mp3')] public static const METRONOMO:Class;
		[Embed(source = '../resources/fase1.xml', mimeType = 'application/octet-stream')] public static const FASE_1:Class;
		
		
		public function Assets() 
		{
			
		}
		
	}

}