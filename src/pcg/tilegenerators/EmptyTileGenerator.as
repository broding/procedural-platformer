package pcg.tilegenerators 
{
	import pcg.Area;
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class EmptyTileGenerator implements TileGenerator
	{
		public function getTile(x:int, y:int, width:int, height:int):int
		{
			return Area.EMPTY;
		}
		
	}

}