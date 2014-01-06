package pcg.ai
{
	import org.flixel.FlxObject;
	import org.flixel.plugin.photonstorm.FlxDelay;
	
	import pcg.Enemy;
	import pcg.Game;

	public class JumpAI implements EnemyAI
	{
		private var _enemy:Enemy;
		private var _target:FlxObject;
		private var _jumpTimer:FlxDelay;
		private var _previousX:uint;
		
		public function destroy():void
		{
			_jumpTimer.reset(0);
			_jumpTimer.callback = null;
			_jumpTimer = null;
		}
		
		public function JumpAI(enemy:Enemy)
		{
			_enemy = enemy;
			_jumpTimer = new FlxDelay(Game.random.nextIntRange(1800, 2500));
			_jumpTimer.callback = jump;
			_jumpTimer.start();
			_previousX = 0;
		}
		
		public function setTarget(object:FlxObject):void
		{
			_target = object;
		}
		
		public function update():void
		{
			if(_target == null || !_enemy.alive)
			{
				_jumpTimer.callback = null;
				return;
			}
			
			if(_enemy.touching != FlxObject.FLOOR)
				_enemy.walk();
			else
				_enemy.velocity.x = 0;
		}
		
		private function jump():void
		{	
			if(_previousX == _enemy.x)
				_enemy.turnAround();
			
			_enemy.jump();
			_jumpTimer.start();
			
			_previousX = _enemy.x;
		}
		
	}
}