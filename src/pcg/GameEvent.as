package pcg
{
	import org.flixel.FlxPoint;

	public class GameEvent
	{
		public static const EXPLOSION:int = 0;
		public static const BULLET_FIRED:int = 1;
		public static const ENEMY_SPAWNED:int = 2;
		public static const ENEMY_KILLED:int = 3;
		
		public var position:FlxPoint;
		public var radius:uint;
		public var bullet:Bullet;
		public var enemy:Enemy;
		
		private var _type:int;
	
		public function GameEvent(type:int)
		{
			_type = type;
		}

		public function get type():int
		{
			return _type;
		}

	}
}