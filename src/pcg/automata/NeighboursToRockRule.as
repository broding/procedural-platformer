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
			
			if (rockNeighbours >= 5)
				return Level.ROCK;
			else
				return Level.EMPTY;
		}
	}

}