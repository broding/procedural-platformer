package pcg 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;

	/**
	 * ...
	 * @author Bas Roding
	 */
	public class Player extends FlxSprite implements GameEventListener
	{
		private static const WALK_SPEED:uint = 119;
		private static const JUMP_POWER:uint = 240;
		private static const RUN_SPEED:uint = 130;
		
		[Embed(source = "../../assets/player2.png")] private var _playerImage:Class;
		[Embed(source = "../../assets/muzzle.png")] private var _muzzleImage:Class;
		[Embed(source="../../assets/soundz/jetpack.mp3")] private var _jetpackSoundClass:Class;
		[Embed(source="../../assets/soundz/hurt.mp3")] private var _hurtSound:Class;
		
		private var _healthBar:PlayerHealthBar;
		
		private var _jumping:Boolean = false;
		private var _jumpedAgo:Number = 0;
		private var _climbingLadder:Boolean;
		private var _knocked:Boolean;
		
		private var _bombs:FlxGroup;
		private var _weapon:Weapon;
		
		private var _justLandedTimer:Number;
		
		private var _jetpacking:Boolean;
		private var _jetpackPower:Number;
		private var _jetpackTotalPower:Number;
		private var _jetpackReload:Number;
		
		private var _jetpackSound:FlxSound;
		
		public var dead:Boolean;
		
		public function Player() 
		{
			dead = false;
			health = 3;
			
			_healthBar = new PlayerHealthBar(this);
			_bombs = new FlxGroup();
			_weapon = new Weapon();
			_climbingLadder = false;
			_knocked = false;
			
			_jetpacking = false;
			_jetpackTotalPower = 210;
			_jetpackPower = _jetpackTotalPower;
			_jetpackReload = 350;
			_jetpackSound = new FlxSound();
			_jetpackSound.loadEmbedded(_jetpackSoundClass, true);
			
			this.loadGraphic(_playerImage, true, true, 16, 16);
			this.addAnimation("idle", [0], 10);
			this.addAnimation("walk", [0, 1, 0, 2], 7);
			this.addAnimation("jump", [3], 3, false);
			this.addAnimation("jump_falling", [4, 5], 5);
			this.addAnimation("jump_end", [6, 0], 5, false);
			this.addAnimation("shooting", [7, 0], 5);
			this.addAnimation("knocked", [8], 5, false);
			this.addAnimation("jetpack", [10, 11], 7);
			this.addAnimation("lookup", [12], 7);
			this.width = 10;
			this.offset.x = 3;
		}
		
		override public function update():void 
		{
			super.update();
			
			_weapon.update();
			
			checkAnimation();
			
			if(!_knocked)
			{
				if (FlxG.keys.LEFT) 
					velocity.x = -WALK_SPEED;
				else if (FlxG.keys.RIGHT)
					velocity.x = WALK_SPEED;
				else 
					velocity.x = 0;
				
				if (FlxG.keys.justPressed("B"))
				{
					jetpack();
					//jump();
				}
				
				if(FlxG.keys.B)
					jetpack();
				else
				{
					_jetpackSound.stop();
					_jetpacking = false;
					_jetpackPower += _jetpackReload * FlxG.elapsed;
					_jetpackPower = Math.min(_jetpackTotalPower, _jetpackPower);
				}
				
				FlxG.overlap(this, Game.ladders, function(player:Player, ladder:Ladder):void
				{
					if((FlxG.keys.UP || FlxG.keys.DOWN))
						_climbingLadder = true;
					
					_jumping = false;
					
					player.velocity.y = player.velocity.y / 1.3;
					
					if(FlxG.keys.UP)
						player.velocity.y = -WALK_SPEED;
					else if(FlxG.keys.DOWN)
						player.velocity.y = WALK_SPEED;
				});
				
				if(FlxG.keys.X)
				{
					var upOrDown:uint = 0;
					if(FlxG.keys.UP)
						upOrDown = FlxObject.UP;
					else if(FlxG.keys.DOWN)
						upOrDown = FlxObject.DOWN;
					
					var fired:Boolean = _weapon.fire(x, y, facing, upOrDown);
					
					if(fired && velocity.x == 0 && !_jumping && _justLandedTimer == 0)
						play("shooting");
				}
				
				_justLandedTimer = Math.max(0, _justLandedTimer -= FlxG.elapsed);
				
				if (this.justTouched(FLOOR))
				{
					_jumping = false;
					play("jump_end", true);
					_justLandedTimer = 0.1;
				}
				
				if(!_climbingLadder)
					velocity.y += 13;
			}
			
			
			_climbingLadder = false;
		}
		
		private function jetpack():void
		{
			if(_jetpackPower <= 0)
			{
				_jetpacking = false;
				_jetpackSound.stop();
				return;
			}
			
			_jetpackSound.play();
			
			_jetpacking = true;
			
			_jetpackPower -= 300 * FlxG.elapsed;
			
			velocity.y -= 2000 * FlxG.elapsed;
			
			velocity.y = Math.max(velocity.y, -130);
		}
		
		private function dropBomb():void
		{	
			var bomb:Bomb = new Bomb();
			bomb.x = x;
			bomb.y = y;
			
			_bombs.add(bomb);
		}
		
		private function checkAnimation():void
		{
			if (!_jumping && velocity.x == 0 && _justLandedTimer == 0 && !_jetpacking)
				play("idle");
			else if (!_jumping && velocity.x != 0 && _justLandedTimer == 0 && !_jetpacking)
				play("walk");
			else if(_jetpacking)
				play("jetpack");
			
			if(_jumping && velocity.y > 0 && !_jetpacking)
				play("jump_falling");
			
			if(_knocked)
				play("knocked");
				
			if (velocity.x > 0)
				facing = RIGHT;
			else if (velocity.x < 0)
				facing = LEFT;
		}
		
		private function jump():void
		{	
			if (!_jumping) // if already jumping..
			{
				play("jump");
				this.velocity.y = -JUMP_POWER;
				_jumping = true;
			}
			
		}
		
		public function hit(enemy:Enemy):void
		{	
			health--;
			
			if(health > 0)
			{
				flicker(1);
				flash(0xff0000, 0.2);
				FlxG.shake(0.03, 0.08);
				FlxG.play(_hurtSound);
			}
			else
			{	
				velocity.make((facing == FlxObject.LEFT ? -1 : 1) * 800, -800);
				FlxG.timeScale = 0.3;
				flicker(1);
				FlxG.flash(0xffff0000, 0.3);
				flash(0xff0000, 0.2);
				FlxG.shake(0.05, 0.09);
				FlxG.play(_hurtSound);
				_knocked = true;
				play("knocked");
				
				var event:GameEvent = new GameEvent(GameEvent.PLAYER_KILLED);
				
				Game.emitGameEvent(event);
				
				dead = true;
			}
		}
		
		private function knockBack(direction:uint, force:uint):void
		{
			velocity.make((direction == FlxObject.LEFT ? -1 : 1) * force, -100);
		}

		public function get bombs():FlxGroup
		{
			return _bombs;
		}
		
		public function receiveEvent(event:GameEvent):void
		{
			switch(event.type)
			{
				case GameEvent.EXPLOSION:
					var position:FlxPoint = new FlxPoint(x,y);
					var distance:Number = FlxU.getDistance(position, event.position);
					if(distance < event.radius * 15)
					{
						this.flicker(1);
						velocity = new FlxPoint((position.x - event.position.x) * 20, (position.y - event.position.y) * 20);
					}
			}
		}

		public function get healthBar():PlayerHealthBar
		{
			return _healthBar;
		}

		
	}

}