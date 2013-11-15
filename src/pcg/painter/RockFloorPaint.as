package pcg.painter 
{
	import pcg.ArrayMap;
	import pcg.Level;
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class RockFloorPaint implements Paint
	{
		public function applyPaint(x:int, y:int, map:ArrayMap, originalTile:uint):int 
		{
			if (Level.isSolidTile(map.getTile(x, y + 1)) && !Level.isSolidTile(map.getTile(x, y)))
				return Math.random() > 0.5 ? Level.ROCK_FLOOR : Level.ROCK_FLOOR2;
			else
				return originalTile;
		}
	}

}