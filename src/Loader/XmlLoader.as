package Loader
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Fabio e Helo e Pedro
	 */
	public class XmlLoader
	{
		private var xmlFile:XML;
		
		public var noteList:Array = [];
		public var eventList:Array = [];
		
		public var itemDelay:int = 1;
		
		public function XmlLoader(xmlObject:String)
		{
			xmlFile = new XML(xmlObject);
		}
		
		public function getBPM():uint
		{
			return xmlFile.@bmp;
		}
		
		public function load():void
		{
			var lapse:uint = xmlFile.@lapse;
			var firstGuy:uint;
			var secondGuy:uint;
			var noteId:uint = 0;
			var eventId:uint = 0;
			
			for each (var obj:XML in xmlFile.child("items").child("item"))
			{
				firstGuy = 1 + obj.@threadmill * 2;
				secondGuy = firstGuy - 1;
				
				eventList.push({beat: int(obj.@beat) - itemDelay, type: obj.@type, id: eventId++});
				
				if (obj.@type == 4) // item "neutro"
				{
					noteList.push( { beat: obj.@beat, helper: firstGuy, id: noteId++ } )
					noteList.push({beat: int(obj.@beat) + lapse, helper: secondGuy, id: noteId++})
				}
				
				else // item colorido
				{
					noteList.push( { beat: (obj.@type % 2 == 0) ? (int(obj.@beat) + lapse) : int(obj.@beat), helper: obj.@type, id: noteId++ } );
				}
				
			}
			
			for each (var ev:XML in xmlFile.child("story_events").child("story_event"))
			{
				eventList.push({beat: ev.@beat, type: ev.@type, id: eventId++});
			}
			
			noteList.sortOn("beat", [Array.NUMERIC]);
		}
	
	}
}