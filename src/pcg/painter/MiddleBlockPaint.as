package pcg.painter 
{
	import pcg.ArrayMap;
	import pcg.Level;
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class MiddleBlockPaint implements Paint
	{
		public function applyPaint(x:int, y:int, map:ArrayMap, originalTile:uint):int
		{
			if (Level.isSolidTile(map.getTile(x, y - 1)) && Level.isSolidTile(map.getTile(x, y + 1)) && Level.isSolidTile(map.getTile(x, y)))
				return Level.MIDDLE_ROCK;
			else
				return originalTile;
		}
	}

}