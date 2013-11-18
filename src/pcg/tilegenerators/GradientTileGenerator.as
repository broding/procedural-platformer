package pcg.tilegenerators 
{
	/**
	 * ...
	 * @author Richard Turenhout
	 */
	public class GradientTileGenerator implements TileGenerator
	{
		
		public function getTile(x:int, y:int, width:int, height:int):int 
		{
			return (y / height) + (Math.random());
		}
		
	}

}