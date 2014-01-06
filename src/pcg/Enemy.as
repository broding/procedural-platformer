package pcg
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.plugin.FlxSpriteDeluxe;
	
	import pcg.ai.EnemyAI;
	import pcg.ai.WalkAI;

	public class Enemy extends FlxSpriteDeluxe
	{		
		private static const WALK_SPEED:uint = 119;
		private static const JUMP_POWER:uint = 240;
		private static const RUN_SPEED:uint = 130;
		
		[Embed(source = "../../assets/zombie.png")] private var _playerImage:Class;
		[Embed(source = "../../assets/muzzle.png")] private var _muzzleImage:Class;
		[Embed(source="../../assets/soundz/hurt.mp3")] private var _hurtSound:Class;
		
		private var _type:EnemyType;
		
		protected var _ai:EnemyAI;
		
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
			
			this._ai = new WalkAI(this);
			this._ai.setTarget(Game.player);
			this._type = enemyType;
			this.loadGraphic(_playerImage, true, true, 16, 16);
			this.addAnimation("idle", [0], 10);
			//this.addAnimation("walk", [0, 1, 0, 2], 7);
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
		
		public function walk():void
		{
			velocity.x = _type.speed * (facing == LEFT ? -1 : 1);
		}
		
		public function turnAround():void
		{
			facing = facing == FlxObject.LEFT ? FlxObject.RIGHT : FlxObject.LEFT;
		}
		
		public function jump():void
		{
			if (!_jumping) // if already jumping..
			{
				play("jump");
				this.velocity.y = -JUMP_POWER;
				_jumping = true;
			}
		}
		
		public function hit(bullet:Bullet):void
		{
			flash(0xffffff, 0.09);
			
			var critical:Boolean = (Game.random.nextDoubleRange(0,1) * 101) < bullet.weapon.stats.accuracy;
			var damage:uint = bullet.weapon.stats.damage + (critical ? bullet.weapon.stats.damage / 100 * bullet.weapon.stats.headshotDamage : 0);
			health -= damage;
			
			if(_type.healthbarNeeded)
				_healthBar.show();
			
			var damageText:DamageText = _damageTexts.getFirstDead() as DamageText;
			damageText.activate(damage, critical);
			
			FlxG.play(_hurtSound);
			
			if(health <= 0)
			{
				this.velocity.x = bullet.facing == LEFT ? -1 : 1;
				kill();
			}
		}
		
		override public function kill():void
		{
			super.kill();
			
			remove(_healthBar);
			
			var event:GameEvent = new GameEvent(GameEvent.ENEMY_KILLED);
			event.enemy = this;
			Game.emitGameEvent(event);
		}
		
		override public function destroy():void
		{
			_ai.destroy();
			
			super.destroy();
		}

		public function get type():EnemyType
		{
			return _type;
		}

	}
}