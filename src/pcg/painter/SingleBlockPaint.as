package pcg.painter 
{
	import pcg.ArrayMap;
	import pcg.Area;
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class SingleBlockPaint implements Paint
	{
		
		public function applyPaint(x:int, y:int, map:ArrayMap, originalTile:uint):int
		{
			if (!Area.isSolidTile(map.getTile(x, y - 1)) && !Area.isSolidTile(map.getTile(x, y + 1)) && Area.isSolidTile(map.getTile(x, y)))
				return Area.SINGLE_ROCK
			else
				return originalTile;
		}
		
	}

}