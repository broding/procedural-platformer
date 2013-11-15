package pcg.painter 
{
	import pcg.ArrayMap;
	import pcg.Level;
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
		
		public function applyPaint(x:int, y:int, map:ArrayMap, originalTile:uint):int 
		{
			if (Level.isSolidTile(map.getTile(x, y - 1)) && !Level.isSolidTile(map.getTile(x, y + 1)) && !Level.isSolidTile(map.getTile(x, y)) && Math.random() * 100 <= _chance)
				return Level.HANGING_GRASS;
			else
				return originalTile;
		}
		
	}

}