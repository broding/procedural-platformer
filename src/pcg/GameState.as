package pcg 
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxParticle;
	import org.flixel.FlxPoint;
	import org.flixel.FlxState;

	/**
	 * ...
	 * @author Bas Roding
	 */
	public class GameState extends FlxState implements GameEventListener
	{
		private var _gameEventListeners:Array;
		
		private var _player:Player;
		private var _level:Level;
		private var _emitter:FlxEmitter;
		
		public function GameState() 
		{
			Game.emitEventCallback = emitGameEvent;
			_gameEventListeners = new Array();
			
			_emitter = new FlxEmitter(0, 0, 100);
			_emitter.gravity = 500;
			for(var i:int = 0; i < 100; i ++)
			{
				var particle:FlxParticle = new FlxParticle();
				particle.makeGraphic(Math.random() * 2 + 3, Math.random() * 2 + 3, 0xff632f1d);
				_emitter.add(particle);
			}
			add(_emitter);
			
			initLevel();
		}
		
		private function initLevel():void
		{
			if(_level != null)
			{
				remove(_level.collideMaps);
				remove(_level.decorationMaps);
				remove(_player);
				remove(_player.bombs);
				this._gameEventListeners.length = 0;
			}
			
			_player = new Player();
			_level = new Level();
			
			var spawnpoint:FlxPoint = _level.getBeginArea().getPlayerSpawnPoint(3);
			_player.x = spawnpoint.x;
			_player.y = spawnpoint.y;
			
			add(_level.collideMaps);
			add(_level.decorationMaps);
			add(_level.getBeginArea().fluidManager);
			add(_player);
			add(_player.bombs);
			
			addGameEventListener(_level);
			addGameEventListener(_player);
		}
		
		override public function update():void 
		{
			super.update();
			
			FlxG.collide(_player, _level.collideMaps);
			FlxG.collide(_player.bombs, _level.collideMaps);
			FlxG.collide(_emitter, _level.collideMaps);
			
			if(FlxG.keys.justPressed("SPACE"))
			{
				initLevel();
			}
			
		}
		
		private function addGameEventListener(listener:GameEventListener):void
		{
			_gameEventListeners.push(listener);
		}
		
		public function emitGameEvent(event:GameEvent):void
		{
			receiveEvent(event);
		}
		
		public function receiveEvent(event:GameEvent):void
		{
			switch(event.type)
			{
				case GameEvent.EXPLOSION:
					_emitter.x = event.position.x;
					_emitter.y = event.position.y;
					_emitter.start(true, 2, 0, 20);
					break;
			}
			
			for(var i:int = 0; i < this._gameEventListeners.length; i++)
			{
				_gameEventListeners[i].receiveEvent(event);
			}
		}
		
	}

}