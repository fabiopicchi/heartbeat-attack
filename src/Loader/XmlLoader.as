package level
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
		private var outPut:String = '';
		private var itemData:XMLList;
		
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
			var noteList:NoteList;
			//var thread1dir:Boolean = false;
			//var thread2dir:Boolean = false;
			//if (xmlFile.child("stage").@direction1 == "right") thread1dir = true;
			//if (xmlFile.child("stage").@direction2 == "right") thread2dir = true;
			
			var lapse:uint = xmlFile.child("stage").@lapse;
			
			var firstGuy:uint;
			var secondGuy:uint;
			var noteId:uint = 0;
			
			for each (var obj:XML in xmlFile.child("items"))
			{
				firstGuy = 1 + obj.@threadmill * 2;
				secondGuy = firstGuy - 1;
				if (obj.@type == 4)
				{
					//makeNote(obj.@beat, obj.@threadmill, obj.@type);
				}
			}
		}
		
		//list.addNote(new Note(obj.@beat, firstGuy, noteId)); //TODO: perguntar se posso colocar um noteId++ dentro do construtor da nota >_>
		
		public function getStoryEvents():void
		{
			for each (var obj:XML in xmlFile.child("events"))
			{
				//e.addStoryEvent (new StoryEvent (obj.@type, obj.@beat));
			}
		}
	}
}