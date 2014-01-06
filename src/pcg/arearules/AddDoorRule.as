package pcg.arearules
{
	import pcg.Area;
	import pcg.Game;
	import pcg.TileType;
	
	public class AddDoorRule implements AreaRule
	{
		private var _added:Boolean = false;
		private var _tileType:uint;
		private var _x:int;
		private var _y:int;
		
		public function AddDoorRule(spawn:Boolean = true)
		{
			_tileType = spawn ? TileType.SPAWNDOOR : TileType.GOALDOOR;
		}
		
		public function applyRule(x:int, y:int, map:Area):uint
		{
			if(_added)
			{
				if(x == _x && y == _y)
					return _tileType;
				else
					return map.getTile(x, y);
			}
			
			var tries:uint = 0;
			
			_x = Math.floor(Game.random.nextDoubleRange(0,1) * map.width);
			_y = Math.floor(Game.random.nextDoubleRange(0,1) * map.height);
			
			while(!hasFloor(_x, _y, map) || map.getTile(_x, _y) != 0 || tries < 50)
			{
				tries++;
				_x = Math.floor(Game.random.nextDoubleRange(0,1) * map.width);
				_y = Math.floor(Game.random.nextDoubleRange(0,1) * map.height);
			}
			
			_added = true;
			
			map.setTile(_tileType.toString(), _x, _y);
			
			return map.getTile(x, y);
		}
		
		private function hasFloor(x:int, y:int, map:Area):Boolean
		{
			return (
				map.getTile(x - 1, y + 1) != 0 &&
				map.getTile(x, y + 1) != 0 && 
				map.getTile(x + 1, y + 1) != 0 &&
				map.getTile(x - 1, y) == 0 &&
				map.getTile(x,y) == 0 && 
				map.getTile(x + 1, y) == 0);
		}
		
		public function getItterations():uint
		{
			return 1;
		}
		
		
	}
}


