package pcg.automata 
{
	import pcg.ArrayMap;
	import pcg.Area;
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class NeighboursToRockRule implements Rule
	{
		private var _neighboursNeeded:int;
		
		public function NeighboursToRockRule(neighboursNeeded:int = 5)
		{
			this._neighboursNeeded = neighboursNeeded;
		}
		
		public function applyRule(x:int, y:int, map:ArrayMap):int
		{
			var rockNeighbours:int = 0;
			
			if (Area.isSolidTile(map.getTile(x - 1, y - 1))) rockNeighbours++;
			if (Area.isSolidTile(map.getTile(x, y - 1))) rockNeighbours++;
			if (Area.isSolidTile(map.getTile(x + 1, y - 1))) rockNeighbours++;
			
			
			if (Area.isSolidTile(map.getTile(x - 1, y))) rockNeighbours++;
			if (Area.isSolidTile(map.getTile(x + 1, y))) rockNeighbours++;
			
			if (Area.isSolidTile(map.getTile(x - 1, y + 1))) rockNeighbours++;
			if (Area.isSolidTile(map.getTile(x, y + 1))) rockNeighbours++;
			if (Area.isSolidTile(map.getTile(x + 1, y + 1))) rockNeighbours++;
			
			if (rockNeighbours >= this._neighboursNeeded)
				return Area.MIDDLE_ROCK
			else
				return Area.EMPTY;
		}
	}

}