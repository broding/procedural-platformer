package pcg.tilegenerators 
{
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class SimpleTileGenerator implements TileGenerator
	{
		public function getTile(x:int, y:int, width:int, height:int):int
		{
			return Game.random.nextDoubleRange(0,1) * 2;
		}
	}

}