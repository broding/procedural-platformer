package pcg
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.plugin.FlxSpriteDeluxe;

	public class Enemy extends FlxSpriteDeluxe
	{		
		private static const WALK_SPEED:uint = 119;
		private static const JUMP_POWER:uint = 240;
		private static const RUN_SPEED:uint = 130;
		
		[Embed(source = "../../assets/zombie.png")] private var _playerImage:Class;
		[Embed(source = "../../assets/muzzle.png")] private var _muzzleImage:Class;
		
		private var _type:EnemyType;
		
		private var _ai:EnemyAI;
		
		private var _healthBar:Healthbar;
		private var _damageTexts:FlxGroup;
		
		private var _jumping:Boolean = false;
		private var _jumpedAgo:Number = 0;
		private var _weapon:Weapon;
		private var _justLandedTimer:Number;
		
		public var id:int;
		public static var incremeter:int = 0;
		
		public function Enemy(enemyType:EnemyType = null)
		{
			id = incremeter++;
			
			if(enemyType == null)
				enemyType = new EnemyType();
			
			this._ai = new EnemyAI(this);
			this._ai.target = Game.player;
			this._type = enemyType;
			this.loadGraphic(_playerImage, true, true, 16, 16);
			this.addAnimation("idle", [0], 10);
			this.addAnimation("walk", [0, 1, 0, 2], 7);
			this.addAnimation("jump", [3], 3, false);
			this.addAnimation("jump_falling", [4, 5], 5);
			this.addAnimation("jump_end", [6, 0], 5, false);
			this.addAnimation("shooting", [7, 0], 5);
			this.addAnimation("dead_falling", [8], 5, false);
			this.addAnimation("dead", [9], 5, false);
			this.width = 10;
			this.offset.x = 3;
			
			this.health = enemyType.health;
			
			_healthBar = new Healthbar(this);
			
			_damageTexts = new FlxGroup();
			for(var i:int = 0; i < 10; i++)
			{
				var text:DamageText = new DamageText();
				_damageTexts.add(text);
				add(text);
			}
			
			add(_healthBar);
			
			this.addAnimationCallback(function(Name:String, Frame:uint, FrameIndex:uint):void
			{
				trace("animation: " + Name);
			});
		}
		
		override public function update():void 
		{
			super.update();
			
			_ai.update();
			checkAnimation();

			_justLandedTimer = Math.max(0, _justLandedTimer -= FlxG.elapsed);
			
			if (this.justTouched(FLOOR))
			{
				_jumping = false;
				play("jump_end", true);
				_justLandedTimer = 0.2;
				
				if(!alive)
				{
					this.velocity.x = 0;
					this.velocity.y = 0;
					this.play("dead");
				}
			}
			
			checkAnimation();
			
			velocity.y += 13;
		}
		
		private function checkAnimation():void
		{
			if(alive)
			{
				if (!_jumping && velocity.x == 0 && _justLandedTimer == 0)
					play("idle");
				else if (!_jumping && velocity.x != 0 && _justLandedTimer == 0)
					play("walk");
				
				if(_jumping && velocity.y > 0)
					play("jump_falling");
			}
			
			if (velocity.x > 0)
				facing = RIGHT;
			else if (velocity.x < 0)
				facing = LEFT;
		}
		
		internal function walk():void
		{
			velocity.x = _type.speed * (facing == LEFT ? -1 : 1);
		}
		
		internal function turnAround():void
		{
			facing = facing == FlxObject.LEFT ? FlxObject.RIGHT : FlxObject.LEFT;
		}
		
		public function jump():void
		{
			
		}
		
		public function hit(bullet:Bullet):void
		{
			flash(0xffffff, 0.05);
			
			var critical:Boolean = (Math.random() * 101) < bullet.weapon.stats.accuracy;
			var damage:uint = bullet.weapon.stats.damage + (critical ? bullet.weapon.stats.damage / 100 * bullet.weapon.stats.headshotDamage : 0);
			health -= damage;
			
			if(_type.healthbarNeeded)
				_healthBar.show();
			
			var damageText:DamageText = _damageTexts.getFirstDead() as DamageText;
			damageText.activate(damage, critical);
			
			if(health <= 0)
			{
				this.velocity.x = bullet.facing == LEFT ? -1 : 1;
				kill();
			}
		}
		
		override public function kill():void
		{
			remove(_healthBar);
			
			this.alive = false;
			
			this.velocity.x *= 20;
			this.velocity.y = -120;
			this.play("dead_falling");
			
			var event:GameEvent = new GameEvent(GameEvent.ENEMY_SPAWNED);
			event.enemy = this;
			Game.emitGameEvent(event);
		}

		public function get type():EnemyType
		{
			return _type;
		}

	}
}