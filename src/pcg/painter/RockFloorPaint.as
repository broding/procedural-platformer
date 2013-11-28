package pcg.painter 
{
	import org.flixel.FlxTilemap;
	
	import pcg.Area;

	/**
	 * ...
	 * @author Bas Roding
	 */
	public class RockFloorPaint implements Paint
	{
		public function applyPaint(x:int, y:int, map:FlxTilemap, originalTile:uint):int 
		{
			if (Area.isSolidTile(map.getTile(x, y + 1)) && !Area.isSolidTile(map.getTile(x, y)))
				return Math.random() > 0.5 ? Area.ROCK_FLOOR : Area.ROCK_FLOOR2;
			else
				return originalTile;
		}
	}

}