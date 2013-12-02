package pcg.arearules 
{
	import pcg.Area;
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class NeighboursToRockRule implements AreaRule
	{
		private var _neighboursNeeded:Number;
		private var _itterations:uint;
		
		public function NeighboursToRockRule(itterations:uint = 1, neighboursNeeded:Number = 5)
		{
			this._itterations = itterations;
			this._neighboursNeeded = neighboursNeeded;
		}
		
		public function applyRule(x:int, y:int, map:Area):uint
		{
			var rockNeighbours:Number = 0;
			
			var diagonalScore:Number = 1.3;
			var rightScore:Number = 0.9;
			
			if (Area.isSolidTile(map.getTile(x - 1, y - 1))) rockNeighbours += diagonalScore;
			if (Area.isSolidTile(map.getTile(x, y - 1))) rockNeighbours += rightScore;
			if (Area.isSolidTile(map.getTile(x + 1, y - 1))) rockNeighbours += diagonalScore;
			
			
			if (Area.isSolidTile(map.getTile(x - 1, y))) rockNeighbours += rightScore;
			if (Area.isSolidTile(map.getTile(x + 1, y))) rockNeighbours += rightScore;
			
			if (Area.isSolidTile(map.getTile(x - 1, y + 1))) rockNeighbours += diagonalScore;
			if (Area.isSolidTile(map.getTile(x, y + 1))) rockNeighbours += rightScore;
			if (Area.isSolidTile(map.getTile(x + 1, y + 1))) rockNeighbours += diagonalScore;
			
			if (rockNeighbours > this._neighboursNeeded)
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