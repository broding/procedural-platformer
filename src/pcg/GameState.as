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
		
		private var _player:Player;
		private var _bullets:FlxGroup;
		private var _enemies:FlxGroup;
		private var _level:Level;
		private var _bulletParticles:FlxEmitter;
		
		public function GameState(level:Level) 
		{
			FlxG.visualDebug = false;
			
			_level = level;
			_bullets = new FlxGroup();
			_enemies = new FlxGroup();
		}
		
		override public function create():void
		{
			super.create();
			
			FlxG.worldBounds = new FlxRect(0, 0, Area.WIDTH * 16 * 5, 20 * 16 * 5);
			Game.emitEventCallback = emitGameEvent;
			_gameEventListeners = new Array(); 
			
			_bulletParticles = new FlxEmitter(0, 0, 100);
			_bulletParticles.gravity = 500;
			for(var i:int = 0; i < 100; i ++)
			{
				var particle:FlxParticle = new FlxParticle();
				particle.makeGraphic(Math.random() * 2 + 3, Math.random() * 2 + 3, 0xffffffff - Math.random() * 40);
				_bulletParticles.add(particle);
			}
			
			_player = new Player();
			_player.x = 300;
			_player.y = 80;
			
			Game.director.player = _player;
			Game.player = _player;
			
			addGameEventListener(_level);
			addGameEventListener(_player);
			
			add(_level.background);
			add(_level.collideMap);
			add(_level.decorationMap);
			add(_level.fluidManager);
			add(_bulletParticles);
			add(_level.ladders);
			add(_enemies);
			add(_player);
			add(_player.bombs);
			add(_bullets);
		}
		
		override public function update():void 
		{
			super.update();
			
			Game.director.update();
			
			FlxG.collide(_player, _level.collideMap);
			FlxG.collide(_enemies, _level.collideMap);
			FlxG.collide(_player.bombs, _level.collideMap);
			FlxG.collide(_bulletParticles, _level.collideMap);
			FlxG.collide(_bullets, _level.collideMap, bulletTilemapCollide);
			FlxG.overlap(_bullets, _enemies, bulletEnemyCollide);
			FlxG.overlap(_player, _enemies, playerEnemyCollide);
			
			if(FlxG.camera.zoom == 2 || FlxG.camera.zoom == 1)
			{
				FlxG.camera.follow(_player);
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
			
			_bulletParticles.x = bullet.x + (bullet.facing == FlxObject.RIGHT ? bullet.width : 0);
			_bulletParticles.y = bullet.y;
			_bulletParticles.start(true, 0.1, 0, 10);
		}
		
		private function bulletEnemyCollide(bullet:Bullet, enemy:Enemy):void
		{
			if(!enemy.alive)
				return;
			
			bullet.kill();
			_bullets.remove(bullet);
			
			enemy.hit(bullet);
			
			_bulletParticles.x = bullet.x + (bullet.facing == FlxObject.RIGHT ? bullet.width : 0);
			_bulletParticles.y = bullet.y;
			_bulletParticles.start(true, 0.1, 0, 2);
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
					_bulletParticles.x = event.position.x;
					_bulletParticles.y = event.position.y;
					_bulletParticles.start(true, 1, 0, 2);
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