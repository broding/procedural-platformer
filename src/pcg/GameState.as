package pcg 
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxParticle;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;

	/**
	 * ...
	 * @author Bas Roding
	 */
	public class GameState extends FlxState implements GameEventListener
	{
		[Embed(source = "../../assets/explosion.png")] private var _explodeImage:Class;
		[Embed(source = "../../assets/fonts/small_bold_pixel-7.ttf", fontName = "bold20", embedAsCFF="false", mimeType="application/x-font")]
		private var FontClass1:Class;
		
		[Embed(source = "../../assets/fonts/smallest_pixel-7.ttf", fontName = "normal10", embedAsCFF="false", mimeType="application/x-font")]
		private var FontClass2:Class;
		
		private var _gameEventListeners:Array;

		private var _darkness:FlxSprite;
		
		private var _player:Player;
		private var _bullets:FlxGroup;
		private var _enemies:FlxGroup;
		private var _level:Level;
		private var _bulletParticles:FlxEmitter;
		private var _explosionParticles:FlxEmitter;
		
		private var _startedTransition:Boolean;
		
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
			
			FlxG.flash(0xff000000);
			
			_darkness = new FlxSprite(0,0);
			_darkness.makeGraphic(FlxG.width, FlxG.height, 0x55000000);
			_darkness.scrollFactor.x = _darkness.scrollFactor.y = 0;
			_darkness.blend = "multiply";
			_darkness.alpha = 0;
			Light.darkness = _darkness;
			
			FlxG.worldBounds = new FlxRect(0, 0, Area.WIDTH * 16 * 5, 20 * 16 * 5);
			Game.addListener(this);
			_gameEventListeners = new Array(); 
			
			_bulletParticles = new FlxEmitter(0, 0, 30);
			_bulletParticles.gravity = 500;
			
			_explosionParticles = new FlxEmitter(0,0,30);
			
			for(var i:int = 0; i < 30; i ++)
			{
				var particle:FlxParticle = new FlxParticle();
				particle.makeGraphic(Game.random.nextDoubleRange(0,1) * 2 + 3, Game.random.nextDoubleRange(0,1) * 2 + 3, 0xffffffff - Game.random.nextDoubleRange(0,1) * 40);
				_bulletParticles.add(particle);
				
				particle = new Explosion();
				_explosionParticles.add(particle);
				_explosionParticles.setXSpeed(0, 0);
				_explosionParticles.setYSpeed(0, 0);
				_explosionParticles.setRotation(0, 0);
			}
			
			_player = new Player();
			_player.x = _level.spawnDoor.x + 8;
			_player.y = _level.spawnDoor.y + 8;
			
			Game.director.player = _player;
			Game.player = _player;
			
			addGameEventListener(_level);
			addGameEventListener(_player);
		
			// add level/game stuff
			add(_level.background);
			add(_level.collideMap);
			add(_level.decorationMap);
			add(_level.spawnDoor);
			add(_level.goalDoor);
			add(_level.barrels);
			add(_level.torches);
			add(_bulletParticles);
			add(_explosionParticles);
			add(_level.ladders);
			add(_enemies);
			add(_player);
			add(_player.bombs);
			add(_bullets);
			add(Game.lights);
			add(_darkness);
			
			// add ui
			add(_player.healthBar);
		}
		
		override public function update():void 
		{
			super.update();
			
			Game.director.update();
			
			FlxG.collide(_player, _level.collideMap);
			FlxG.collide(_enemies, _level.collideMap);
			FlxG.collide(_player.bombs, _level.collideMap);
			FlxG.collide(_bulletParticles, _level.collideMap);
			FlxG.collide(_level.barrels, _level.collideMap);
			FlxG.collide(_bullets, _level.collideMap, bulletTilemapCollide);
			
			FlxG.collide(_enemies, _enemies);
			FlxG.overlap(_bullets, _level.barrels, bulletBarrelCollide);
			
			FlxG.overlap(_bullets, _enemies, bulletEnemyCollide);
			FlxG.overlap(_player, _enemies, playerEnemyCollide);
			
			if(FlxG.camera.zoom == 2 || FlxG.camera.zoom == 1)
			{
				FlxG.camera.follow(_player);
			}	
			
			if(_player.overlaps(_level.goalDoor))
			{
				if(!_startedTransition)
				{
					_startedTransition = true;
					FlxG.fade(0xff000000, 1, function():void
					{
						FlxG.switchState(new LoadState());
					});
				}
			}
			
			Game.emitBatchedGameEvents();
			
		}
		
		override public function draw():void 
		{
			_darkness.fill(0xff000000);
			super.draw();
		}
		
		private function playerEnemyCollide(player:Player, enemy:Enemy):void
		{
			if(!enemy.alive || player.flickering || player.dead)
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
		
		private function bulletBarrelCollide(bullet:Bullet, barrel:Barrel):void
		{
			bullet.kill();
			_bullets.remove(bullet);
			
			barrel.hit();

			_bulletParticles.x = bullet.x + (bullet.facing == FlxObject.RIGHT ? bullet.width : 0);
			_bulletParticles.y = bullet.y;
			_bulletParticles.start(true, 0.1, 0, 2);
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
					_explosionParticles.width = event.radius * 10;
					_explosionParticles.height = event.radius * 10;
					_explosionParticles.x = event.position.x - _explosionParticles.width / 2;
					_explosionParticles.y = event.position.y - _explosionParticles.height / 2;
					_explosionParticles.start(true, 0.6, 0, event.radius * 2);
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
				case GameEvent.PLAYER_KILLED:
					var deadScreen:DeadScreen = new DeadScreen();
					add(deadScreen);
					break;
			}
			
			for(var i:int = 0; i < this._gameEventListeners.length; i++)
			{
				_gameEventListeners[i].receiveEvent(event);
			}
		}
		
		override public function destroy():void
		{
			super.destroy();
			Game.cleanUpAfterLevel();
		}
		
	}

}