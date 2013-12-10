package pcg
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;

	public class Weapon
	{
		private var _bullets:FlxGroup;
		private var _fireTimer:Number;
		private var _justShot:Boolean;
		
		public function Weapon()
		{
			_bullets = new FlxGroup();
			_fireTimer = 0;
			
			for(var i:int = 0; i < 50; i++)
				_bullets.add(new Bullet());
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
				event.bullet.velocity.x = 400 * (direction == FlxObject.LEFT ? -1 : 1);
				event.bullet.facing = direction;
				event.bullet.revive();
				Game.emitGameEvent(event);

				FlxG.shake(0.01, 0.08);
				
				_fireTimer = 0.13;
				_justShot = true;
				
				return true;
			}
			
			return false;
		}

		public function get justShot():Boolean
		{
			return _justShot;
		}

	}
}