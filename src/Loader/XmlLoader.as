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
		private var _numEvents : int = -1;
		private var _numNotes : int = -1;
		private var _noteSpeed:int;
		
		public var eventList:Vector.<SongEvent>;
		public var noteList:Vector.<SongEvent>;
		
		public function XmlLoader(xmlObject:String)
		{
			xmlFile = new XML(xmlObject);
		}
		
		public function get bpm():uint
		{
			return int(xmlFile.@bpm);
		}
		
		public function get npb():uint
		{
			return int(xmlFile.@npb);
		}
		
		public function get lapse():uint
		{
			return int(xmlFile.@lapse);
		}
		
		public function get numEvents():int
		{
			if (_numEvents == -1)
			{
				var obj:XML;
				var i : int = 0;
				var j : int = 0;
				
				for each (obj in xmlFile.child("items").child("item"))
				{
					i++;
					if (obj.@type == 4) // item "neutro"
					{
						j += 2;
					}
					
					else // item colorido
					{
						j++;
					}	
				}
				
				for each (obj in xmlFile.child("story_events").child("story_event"))
				{
					i++;
				}
				_numEvents = i;
				_numNotes = j;
			}
			return _numEvents;
		}
		
		public function get numNotes():int
		{
			if (_numNotes == -1)
			{
				var obj:XML;
				var i : int = 0;
				
				for each (obj in xmlFile.child("items").child("item"))
				{
					if (obj.@type == 4) // item "neutro"
					{
						i += 2;
					}
					
					else // item colorido
					{
						i++;
					}	
				}
				_numNotes = i;
			}
			return _numNotes;
		}
		
		public function get noteSpeed():int 
		{
			return _noteSpeed;
		}
		
		public function load():void
		{
			eventList = new Vector.<SongEvent> (numEvents, true);
			noteList = new Vector.<SongEvent> (numNotes, true);
			_noteSpeed = (Level.HELPER_RX - Level.HELPER_LX) / (lapse / (bpm * Level.PER_SECOND * npb));
			
			var i : int = 0;
			var j : int = 0;
			var evtArgs : Object;
			var obj:XML;
			
			for each (obj in xmlFile.child("items").child("item"))
			{
				evtArgs = { };
				if (obj.@type == 0)
				{
					evtArgs.code = "UL";
				}
				else if (obj.@type == 1)
				{
					evtArgs.code = "UR";
				}
				else if (obj.@type == 2)
				{
					evtArgs.code = "DL";
				}
				else if (obj.@type == 3)
				{
					evtArgs.code = "DR";
				}
				else if (obj.@type == 4)
				{
					if (obj.@threadmill == 0)
					{
						evtArgs.code = "URUL";
					}
					else
					{
						evtArgs.code = "DRDL";
					}
				}
				
				if (evtArgs.code == "UL" || evtArgs.code == "DL")
				{
					
					evtArgs.xStart = Level.HELPER_LX + (3 * lapse / (bpm * Level.PER_SECOND * npb)) * noteSpeed;
				}
				else
				{
					evtArgs.xStart = Level.HELPER_RX + (2 * lapse / (bpm * Level.PER_SECOND * npb)) * noteSpeed;
				}
				
				eventList[i++] = new SongEvent (SongEvent.NOTE_ENTRY, int(obj.@beat) - ((obj.@type == 0 || obj.@type == 2) ? (3 * lapse) : (2 * lapse)), evtArgs);
				
				if (obj.@type == 4) // item "neutro"
				{
					noteList[j++] = new SongEvent (SongEvent.NOTE, int(obj.@beat), { helper: 1 + int(obj.@threadmill) * 2 });
					noteList[j++] = new SongEvent (SongEvent.NOTE, int(obj.@beat) + lapse, { helper: int(obj.@threadmill) * 2 } );
				}
				
				else // item colorido
				{
					noteList[j++] = new SongEvent (SongEvent.NOTE, int(obj.@beat), { helper: obj.@type } );
					trace (1 + int(obj.@threadmill) * 2 );
				}	
			}
			
			for each (obj in xmlFile.child("story_events").child("story_event"))
			{
				eventList[i++] = new SongEvent (obj.@type, int(obj.@beat));
			}
			
			eventList.sort(SongEvent.compare);
			noteList.sort(SongEvent.compare);
		}
	
	}
}