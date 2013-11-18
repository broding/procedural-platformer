package pcg.painter 
{
	import pcg.ArrayMap;
	import pcg.Area;
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class MiddleBlockPaint implements Paint
	{
		public function applyPaint(x:int, y:int, map:ArrayMap, originalTile:uint):int
		{
			if (Area.isSolidTile(map.getTile(x, y - 1)) && Area.isSolidTile(map.getTile(x, y + 1)) && Area.isSolidTile(map.getTile(x, y)))
				return Area.MIDDLE_ROCK;
			else
				return originalTile;
		}
	}

}