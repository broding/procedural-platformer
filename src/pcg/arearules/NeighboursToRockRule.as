package pcg.arearules 
{
	import pcg.Area;
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class NeighboursToRockRule implements AreaRule
	{
		private var _neighboursNeeded:uint;
		private var _itterations:uint;
		
		public function NeighboursToRockRule(itterations:uint = 1, neighboursNeeded:uint = 5)
		{
			this._itterations = itterations;
			this._neighboursNeeded = neighboursNeeded;
		}
		
		public function applyRule(x:int, y:int, map:Area):uint
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
		
		public function getItterations():uint
		{
			return this._itterations;
		}
	}

}