package pcg.automata
{
	import pcg.Area;
	import pcg.ArrayMap;

	public class BorderRocksRule implements Rule
	{	
		public function applyRule(x:int, y:int, map:ArrayMap):uint
		{
			if(x == 0 || y == 0 || x == map.width - 1 || y == map.height - 1)
				return Area.SINGLE_ROCK;
			else
				return map.getTile(x, y);
		}
		
		public function getItterations():uint
		{
			return 1;
		}
		
	}
}