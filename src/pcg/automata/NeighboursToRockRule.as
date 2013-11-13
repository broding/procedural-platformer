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
			
			if (map.getTile(x - 1, y - 1) == Level.ROCK) rockNeighbours++;
			if (map.getTile(x, y - 1) == Level.ROCK) rockNeighbours++;
			if (map.getTile(x + 1, y - 1) == Level.ROCK) rockNeighbours++;
			
			
			if (map.getTile(x - 1, y) == Level.ROCK) rockNeighbours++;
			if (map.getTile(x + 1, y) == Level.ROCK) rockNeighbours++;
			
			if (map.getTile(x - 1, y + 1) == Level.ROCK) rockNeighbours++;
			if (map.getTile(x, y + 1) == Level.ROCK) rockNeighbours++;
			if (map.getTile(x + 1, y + 1) == Level.ROCK) rockNeighbours++;
			
			if (rockNeighbours >= this._neighboursNeeded)
				return Level.ROCK;
			else
				return Level.EMPTY;
		}
	}

}