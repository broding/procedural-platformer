package pcg.arearules
{
	import pcg.Area;
	import pcg.Game;
	import pcg.TileType;

	public class AddBarrelRule implements AreaRule
	{
		private var _added:int = 0;
		private var _addedLimit:int = 5;
		private var _x:int;
		private var _y:int;
		
		public function applyRule(x:int, y:int, map:Area):uint
		{
			if(_added > _addedLimit)
			{
				if(x == _x && y == _y)
					return TileType.BARREL;
				else
					return map.getTile(x, y);
			}
			
			_x = Math.floor(Game.random.nextDoubleRange(0,1) * map.width);
			_y = Math.floor(Game.random.nextDoubleRange(0,1) * map.height);
			
			while(map.getTile(_x,_y) != 0)
			{
				_x = Math.floor(Game.random.nextDoubleRange(0,1) * map.width);
				_y = Math.floor(Game.random.nextDoubleRange(0,1) * map.height);
			}
			
			_added++;
			
			map.setTile(TileType.BARREL.toString(), _x, _y);
			
			return map.getTile(x, y);
		}
		
		public function getItterations():uint
		{
			return 1;
		}
	}
}