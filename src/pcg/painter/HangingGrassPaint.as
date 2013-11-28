package pcg.painter 
{
	import org.flixel.FlxTilemap;
	
	import pcg.Area;

	/**
	 * ...
	 * @author Bas Roding
	 */
	public class HangingGrassPaint implements Paint
	{
		private var _chance:uint = 30;
		
		public function HangingGrassPaint(chance:uint = 20)
		{
			this._chance = chance;
		}
		
		public function applyPaint(x:int, y:int, map:FlxTilemap, originalTile:uint):int 
		{
			if (Area.isSolidTile(map.getTile(x, y - 1)) && !Area.isSolidTile(map.getTile(x, y + 1)) && !Area.isSolidTile(map.getTile(x, y)) && Math.random() * 100 <= _chance)
				return Area.HANGING_GRASS;
			else
				return originalTile;
		}
		
	}

}