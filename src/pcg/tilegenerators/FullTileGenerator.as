package pcg.tilegenerators
{
	import pcg.Area;

	public class FullTileGenerator implements TileGenerator
	{
		public function getTile(x:int, y:int, width:int, height:int):int
		{
			return Area.TOP_ROCK;
		}
	}
}