package pcg
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxTilemap;

	public class Game
	{
		public static var emitEventCallback:Function;
		private static var _events:Vector.<GameEvent>;
		
		private static var _tilemap:FlxTilemap;
		private static var _director:Director;
		private static var _player:Player;
		private static var _ladders:FlxGroup;
		
		public static function emitGameEvent(event:GameEvent):void
		{
			if(_events == null)
				_events = new Vector.<GameEvent>();
			
			_events.push(event);
		}
		
		public static function emitBatchedGameEvents():void
		{
			if(_events == null)
				_events = new Vector.<GameEvent>();
			
			for each(var event:GameEvent in _events)
			{
				emitEventCallback(event);
			}
			
			_events.length = 0;
		}

		public static function get director():Director
		{	
			return _director;
		}
		
		public static function set director(value:Director):void
		{
			_director = value;
		}

		public static function get player():Player
		{
			return _player;
		}

		public static function set player(value:Player):void
		{
			if(_player != null)
				throw new Error("Player already set");
			
			_player = value;
		}

		public static function get tilemap():FlxTilemap
		{
			return _tilemap;
		}

		public static function set tilemap(value:FlxTilemap):void
		{
			_tilemap = value;
		}

		public static function get ladders():FlxGroup
		{
			return _ladders;
		}

		public static function set ladders(value:FlxGroup):void
		{
			_ladders = value;
		}


	}
}