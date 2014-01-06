package pcg.ai
{
	import org.flixel.FlxObject;
	
	import pcg.Enemy;
	import pcg.Game;

	public class WalkAI implements EnemyAI
	{
		private var _enemy:Enemy;
		private var _target:FlxObject;
		
		public function WalkAI(enemy:Enemy)
		{
			_enemy = enemy;
		}
		
		public function update():void
		{
			if(_target == null || !_enemy.alive)
				return;
			
			if(_target.y == _enemy.y)
			{
				if(_target.x < _enemy.x)
					_enemy.facing = FlxObject.LEFT;
				else
					_enemy.facing = FlxObject.RIGHT;
			}
			
			if(!hasFloor() || _enemy.isTouching(FlxObject.LEFT) || _enemy.isTouching(FlxObject.RIGHT))
				_enemy.turnAround();
			
			_enemy.walk();
		}
		
		private function hasFloor():Boolean
		{
			if(_enemy.overlapsAt(_enemy.x + (_enemy.facing == FlxObject.LEFT ? -1 : 1) * _enemy.width, _enemy.y + _enemy.height, Game.tilemap))
				return true;
				
			return false;
		}

		public function setTarget(value:FlxObject):void
		{
			_target = value;
		}
		
		public function destroy():void
		{
		}

	}
}