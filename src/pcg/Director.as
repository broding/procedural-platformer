package pcg
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxU;

	public class Director
	{
		private var _player:Player;
		private var _enemySpawners:FlxGroup;
		private var _updateTimer:Number;
		
		public function Director(player:Player)
		{
			_enemySpawners = new FlxGroup();
			_player = player;
			_updateTimer = 1;
		}
		
		public function update():void
		{
			_updateTimer -= FlxG.elapsed;
			
			if(_updateTimer <= 0)
			{
				for each(var spawner:EnemySpawner in _enemySpawners.members)
				{
					var cameraTarget:FlxObject = FlxG.camera.target;
					
					if(cameraTarget != null)
					{
						var distance:Number = FlxU.getDistance(new FlxPoint(spawner.x, spawner.y), new FlxPoint(cameraTarget.x, cameraTarget.y));
						if(distance < 100)
							spawner.spawn();
					}
					
				}
				
				_updateTimer = 1;
			}
			
			_enemySpawners.update();
		
		}
		
		public function addEnemySpawner(spawner:EnemySpawner):void
		{
			_enemySpawners.add(spawner);
		}
	}
}