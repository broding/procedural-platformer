package pcg.painter 
{
	import org.flixel.FlxTilemap;
	
	import pcg.Area;
	import pcg.Game;

	/**
	 * ...
	 * @author Bas Roding
	 */
	public class HangingGrassPaint implements Paint
	{
		private var _chance:uint;
		
		public function HangingGrassPaint(chance:uint = 30)
		{
			this._chance = chance;
		}
		
		public function applyPaint(x:int, y:int, map:FlxTilemap, originalTile:uint):int 
		{
			if (Area.isSolidTile(map.getTile(x, y - 1)) && !Area.isSolidTile(map.getTile(x, y + 1)) && !Area.isSolidTile(map.getTile(x, y)) && Game.random.nextDoubleRange(0,1) * 100 <= _chance)
				return Area.HANGING_GRASS;
			else
				return originalTile;
		}
		
	}

}