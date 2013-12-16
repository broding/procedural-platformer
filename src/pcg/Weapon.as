package pcg
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;

	public class Weapon
	{
		private var _bullets:FlxGroup;
		
		private var _base:WeaponBase;
		private var _attachements:Vector.<WeaponAttachment>;
		private var _stats:WeaponStats;
		
		private var _fireTimer:Number;
		private var _justShot:Boolean;
		
		public function Weapon()
		{
			_base = new WeaponBase();
			_bullets = new FlxGroup();
			_fireTimer = 0;
			_attachements = new Vector.<WeaponAttachment>();
			
			for(var i:int = 0; i < 50; i++)
				_bullets.add(new Bullet(this));
			
			_attachements.push(new WeaponAttachment(50));
			
			calculateStats();
		}
		
		private function calculateStats():void
		{
			_stats = _base.copy();
			
			for each(var attachment:WeaponAttachment in _attachements)
				_stats.add(attachment);
		}
		
		public function update():void
		{
			if(_fireTimer > 0)
				_fireTimer -= FlxG.elapsed;
			
			_justShot = false;
		}
		
		public function fire(playerX:int, playerY:int, direction:uint):Boolean
		{	
			if(_fireTimer <= 0)
			{
				var event:GameEvent = new GameEvent(GameEvent.BULLET_FIRED);
				event.bullet = _bullets.getFirstDead() as Bullet;
				event.bullet.x = playerX;
				event.bullet.y = playerY + 6;
				event.bullet.velocity.x = _stats.bulletSpeed * (direction == FlxObject.LEFT ? -1 : 1);
				event.bullet.facing = direction;
				event.bullet.revive();
				Game.emitGameEvent(event);

				FlxG.shake(0.01, 0.08);
				
				_fireTimer = 1 / _stats.fireRate;
				_justShot = true;
				
				return true;
			}
			
			return false;
		}

		public function get justShot():Boolean
		{
			return _justShot;
		}

		public function get stats():WeaponStats
		{
			return _stats;
		}


	}
}