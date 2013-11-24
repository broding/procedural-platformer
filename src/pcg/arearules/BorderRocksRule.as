package pcg.arearules
{
	import pcg.Area;
	import pcg.Area;

	public class BorderRocksRule implements AreaRule
	{	
		public function applyRule(x:int, y:int, map:pcg.Area):uint
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