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
		
		public var noteList:Array = []; //{beat, helper, id}
		public var eventList:Array = []; //{beat, name, id}
		
		public function XmlLoader(xmlObject:String)
		{
			xmlFile = new XML(xmlObject);
		}
		
		public function get bpm():uint
		{
			return xmlFile.@bpm;
		}
		
		public function get npb():uint
		{
			return xmlFile.@npb;
		}
		
		public function get lapse():uint
		{
			return xmlFile.@lapse;
		}
		
		public function load():void
		{
			var lapse:uint = xmlFile.@lapse;
			var firstGuy:uint;
			var secondGuy:uint;
			var noteId:uint = 0;
			var eventId:uint = 0;
			var eventName:String;
			
			for each (var obj:XML in xmlFile.child("items").child("item"))
			{
				firstGuy = 1 + obj.@threadmill * 2;
				secondGuy = firstGuy - 1;
				if (obj.@type == 0)
					eventName = "note_UL";
				else if (obj.@type == 1)
					eventName = "note_UR";
				else if (obj.@type == 2)
					eventName = "note_DL";
				else if (obj.@type == 3)
					eventName = "note_DR";
				else if (obj.@type == 4)
				{
					if (obj.@threadmill == 0)
						eventName = "note_URUL";
					else
						eventName = "note_DRDL";
				}
				
				eventList.push({beat: int(obj.@beat) - ((obj.@type == 0 || obj.@type == 2) ? (3 * lapse) : (2 * lapse)) , name: eventName, id: eventId++});
				
				if (obj.@type == 4) // item "neutro"
				{
					noteList.push({beat: obj.@beat, helper: firstGuy, id: noteId++})
					noteList.push({beat: int(obj.@beat) + lapse, helper: secondGuy, id: noteId++})
				}
				
				else // item colorido
				{
					noteList.push({beat: obj.@beat, helper: obj.@type, id: noteId++});
				}
				
			}
			
			for each (var ev:XML in xmlFile.child("story_events").child("story_event"))
			{
				eventList.push({beat: ev.@beat, type: ev.@type, threadmill: int(-1), id: eventId++});
			}
			
			noteList.sortOn("beat", [Array.NUMERIC]);
		}
	
	}
}