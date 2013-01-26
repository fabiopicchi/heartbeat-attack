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
			return xmlFile.child("stage").@bmp;
		}
		
		public function load():void
		{
			trace("loading xml");
			
			var lapse:uint = xmlFile.child("stage").@lapse;
			var firstGuy:uint;
			var secondGuy:uint;
			var noteId:uint = 0;
			var animId:uint = 0;
			
			for each (var obj:XML in xmlFile.child("items"))
			{
				firstGuy = 1 + obj.@threadmill * 2;
				secondGuy = firstGuy - 1;
				
				eventList.push(new Animation(obj.@beat - itemDelay, obj.@type, animId++));
				println();
				
				if (obj.@type == 4) // item "neutro"
				{
					noteList.push(new Note(obj.@beat, firstGuy, noteId++));
					noteList.push(new Note(obj.@beat + lapse, secondGuy, noteId++));
				}
				else
				{
					noteList.push(new Note((obj.@type % 2 == 0) ? (obj.@beat + lapse) : (obj.@beat), obj.@type, noteId++));
				}
				
			}
			
			for each (var obj:XML in xmlFile.child("story_events"))
			{
				eventList.push(new Animation(obj.@beat, obj.@type,animId++));
			}
			
			trace(noteList);
			//noteList.sortOn();
		}
		
	}
}