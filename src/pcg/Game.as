package pcg
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxTilemap;

	public class Game
	{	
		private static var _listeners:Vector.<GameEventListener>;
		private static var _events:Vector.<GameEvent>;
		
		private static var _tilemap:FlxTilemap;
		private static var _director:Director;
		private static var _player:Player;
		private static var _ladders:FlxGroup;
		private static var _lights:FlxGroup;
		
		private static var _random:PseudoRandom;
		
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
				for each(var listener:GameEventListener in _listeners)
				{
					listener.receiveEvent(event);	
				}
			}
			
			_events.length = 0;
		}

		public static function get director():Director
		{	
			if(_director == null)
				_director = new Director();
			
			return _director;
		}
		
		public static function addListener(listener:GameEventListener):void
		{
			if(_listeners == null)
				_listeners = new Vector.<GameEventListener>();
			
			_listeners.push(listener);
		}
		
		public static function removeListener(listener:GameEventListener):void
		{
			_listeners.splice(_listeners.indexOf(listener), 1);
		}

		public static function get player():Player
		{
			return _player;
		}

		public static function set player(value:Player):void
		{	
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

		public static function get random():PseudoRandom
		{
			if(_random == null)
			{
				_random = new PseudoRandom();
				
				var seedString:String = "d";
				
				for(var i:int = 0; i < seedString.length; i++)
					_random.seed += seedString.charCodeAt(i);
				
				 _random.seed = Math.random() * 500000;
				
				trace(_random.seed);
			}
			
			return _random;
		}

		public static function get lights():FlxGroup
		{
			if(_lights == null)
				_lights = new FlxGroup();
			
			return _lights;
		}
		
		public static function cleanUpAfterLevel():void
		{
			FlxG.sounds.kill();
			
			_lights.destroy();
			_lights = null;
			_events = null;
			_listeners = null;
		}


	}
}