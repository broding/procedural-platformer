package pcg.arearules
{
	import pcg.Area;
	import pcg.TileType;

	public class AddEnemySpawnerRule implements AreaRule
	{
		private var _added:Boolean = false;
		private var _x:int;
		private var _y:int;
		
		public function applyRule(x:int, y:int, map:Area):uint
		{
			if(_added)
			{
				if(x == _x && y == _y)
					return TileType.ENEMYSPAWNER;
				else
					return map.getTile(x, y);
			}
			
			_x = Math.floor(Math.random() * map.width);
			_y = Math.floor(Math.random() * map.height);
			
			while(map.getTile(_x,_y) != 0)
			{
				_x = Math.floor(Math.random() * map.width);
				_y = Math.floor(Math.random() * map.height);
			}
			
			_added = true;
			
			map.setTile(TileType.ENEMYSPAWNER.toString(), _x, _y);
			
			return map.getTile(x, y);
		}
		
		public function getItterations():uint
		{
			return 1;
		}
		
		
	}
}