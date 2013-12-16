package pcg 
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxParticle;
	import org.flixel.FlxRect;
	import org.flixel.FlxState;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;
	
	import pcg.levelgenerator.RandomLevelGenerator;

	/**
	 * ...
	 * @author Bas Roding
	 */
	public class GameState extends FlxState implements GameEventListener
	{
		private var _gameEventListeners:Array;
		
		private var _director:Director;
		private var _player:Player;
		private var _bullets:FlxGroup;
		private var _enemies:FlxGroup;
		private var _level:Level;
		private var _emitter:FlxEmitter;
		
		public function GameState() 
		{
			FlxG.visualDebug = false;
			
			_bullets = new FlxGroup();
			_enemies = new FlxGroup();
		}
		
		override public function create():void
		{
			super.create();
			
			FlxG.worldBounds = new FlxRect(0, 0, Area.WIDTH * 16 * 5, 20 * 16 * 5);
			Game.emitEventCallback = emitGameEvent;
			_gameEventListeners = new Array(); 
			
			_emitter = new FlxEmitter(0, 0, 100);
			_emitter.gravity = 500;
			for(var i:int = 0; i < 100; i ++)
			{
				var particle:FlxParticle = new FlxParticle();
				particle.makeGraphic(Math.random() * 2 + 3, Math.random() * 2 + 3, 0xffffffff - Math.random() * 40);
				_emitter.add(particle);
			}
			
			initLevel();
		}
		
		private function initLevel():void
		{	
			if(_level != null)
			{
				remove(_level.background);
				remove(_level.collideMap);
				remove(_level.decorationMaps);
				remove(_level.ladders);
				remove(_player);
				remove(_player.bombs);
				remove(_enemies);
				remove(_level.fluidManager);
				this._gameEventListeners.length = 0;
			}
			
			_player = new Player();
			_player.x = 300;
			_player.y = 80;
			
			_level = new Level(new RandomLevelGenerator());
			
			add(_level.background);
			add(_level.collideMap);
			add(_level.fluidManager);
			add(_level.decorationMaps);
			add(_emitter);
			add(_level.ladders);
			add(_enemies);
			add(_player);
			add(_player.bombs);
			add(_bullets);
			
			_director = new Director(_player);
			
			Game.player = _player;
			Game.director = _director;
			
			addGameEventListener(_level);
			addGameEventListener(_player);
		}
		
		override public function update():void 
		{
			super.update();
			
			_director.update();
			
			FlxG.collide(_player, _level.collideMap);
			FlxG.collide(_enemies, _level.collideMap);
			FlxG.collide(_player.bombs, _level.collideMap);
			FlxG.collide(_emitter, _level.collideMap);
			FlxG.collide(_bullets, _level.collideMap, bulletTilemapCollide);
			FlxG.overlap(_bullets, _enemies, bulletEnemyCollide);
			FlxG.overlap(_player, _enemies, playerEnemyCollide);
			
			if(FlxG.camera.zoom == 2 || FlxG.camera.zoom == 1)
			{
				FlxG.camera.follow(_player);
			}
			
			if(FlxG.keys.justPressed("SPACE"))
			{
				initLevel();
			}
			
			Game.emitBatchedGameEvents();
			
		}
		
		private function playerEnemyCollide(player:Player, enemy:Enemy):void
		{
			if(!enemy.alive || player.flickering)
				return;
			
			player.hit(enemy);
		}
		
		private function bulletTilemapCollide(bullet:Bullet, tilemap:FlxTilemap):void
		{
			bullet.kill();
			_bullets.remove(bullet);
			
			_emitter.x = bullet.x + (bullet.facing == FlxObject.RIGHT ? bullet.width : 0);
			_emitter.y = bullet.y;
			_emitter.start(true, 0.1, 0, 10);
		}
		
		private function bulletEnemyCollide(bullet:Bullet, enemy:Enemy):void
		{
			if(!enemy.alive)
				return;
			
			bullet.kill();
			_bullets.remove(bullet);
			
			enemy.hit(bullet);
			
			_emitter.x = bullet.x + (bullet.facing == FlxObject.RIGHT ? bullet.width : 0);
			_emitter.y = bullet.y;
			_emitter.start(true, 0.1, 0, 2);
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
					_emitter.start(true, 1, 0, 2);
					break;
				
				case GameEvent.BULLET_FIRED:
					_bullets.add(event.bullet);
					break;
				
				case GameEvent.ENEMY_SPAWNED:
					_enemies.add(event.enemy);
					break;
				
				case GameEvent.ENEMY_KILLED:
					_enemies.remove(event.enemy);
					break;
			}
			
			for(var i:int = 0; i < this._gameEventListeners.length; i++)
			{
				_gameEventListeners[i].receiveEvent(event);
			}
		}
		
	}

}