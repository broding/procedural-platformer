package pcg.painter 
{
	import pcg.Area;
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
		
		public function applyPaint(x:int, y:int, map:pcg.Area, originalTile:uint):int 
		{
			if (Area.isSolidTile(map.getTile(x, y - 1)) && !Area.isSolidTile(map.getTile(x, y + 1)) && !Area.isSolidTile(map.getTile(x, y)) && Math.random() * 100 <= _chance)
				return Area.HANGING_GRASS;
			else
				return originalTile;
		}
		
	}

}