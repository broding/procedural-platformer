package pcg.painter 
{
	import org.flixel.FlxTilemap;
	
	import pcg.Area;

	/**
	 * ...
	 * @author Bas Roding
	 */
	public class TopBlockPaint implements Paint
	{
		
		public function applyPaint(x:int, y:int, map:FlxTilemap, originalTile:uint):int
		{
			if (!Area.isSolidTile(map.getTile(x, y - 1)) && Area.isSolidTile(map.getTile(x, y + 1)) && Area.isSolidTile(map.getTile(x, y)))
				return Area.TOP_ROCK;
			else
				return originalTile;
		}
		
	}

}