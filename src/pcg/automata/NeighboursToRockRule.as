package pcg.automata 
{
	import pcg.ArrayMap;
	import pcg.Level;
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
			
			if (Level.isSolidTile(map.getTile(x - 1, y - 1))) rockNeighbours++;
			if (Level.isSolidTile(map.getTile(x, y - 1))) rockNeighbours++;
			if (Level.isSolidTile(map.getTile(x + 1, y - 1))) rockNeighbours++;
			
			
			if (Level.isSolidTile(map.getTile(x - 1, y))) rockNeighbours++;
			if (Level.isSolidTile(map.getTile(x + 1, y))) rockNeighbours++;
			
			if (Level.isSolidTile(map.getTile(x - 1, y + 1))) rockNeighbours++;
			if (Level.isSolidTile(map.getTile(x, y + 1))) rockNeighbours++;
			if (Level.isSolidTile(map.getTile(x + 1, y + 1))) rockNeighbours++;
			
			if (rockNeighbours >= this._neighboursNeeded)
				return Level.MIDDLE_ROCK
			else
				return Level.EMPTY;
		}
	}

}