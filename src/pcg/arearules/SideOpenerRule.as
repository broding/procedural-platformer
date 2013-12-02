package pcg.arearules
{
	import pcg.Area;

	public class SideOpenerRule implements AreaRule
 	{
		public function applyRule(x:int, y:int, map:pcg.Area):uint
		{
			if((x == 0 && !map.edges.left) || (y == 0  && !map.edges.up) || (x == map.width - 1  && !map.edges.right) || (y == map.height - 1 && !map.edges.down))
				return Area.TOP_ROCK;
			else
				return map.getTile(x, y);
		}
		
		public function getItterations():uint
		{
			return 1;
		}
	}
}