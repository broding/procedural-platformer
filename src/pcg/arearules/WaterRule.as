package pcg.arearules
{
	import pcg.Area;
	import pcg.TileType;

	public class WaterRule implements AreaRule
	{
		private var waterAdded:Boolean = false;
		
		public function applyRule(x:int, y:int, map:Area):uint
		{
			if(waterAdded)
				return map.getTile(x,y);
			
			if(x == int(map.width/2) && y == int(map.height/2))
			{
				waterAdded = true;
				return TileType.WATER;
			}
			
			return map.getTile(x,y);
		}
		
		public function getItterations():uint
		{
			return 1;
		}
		
	}
}