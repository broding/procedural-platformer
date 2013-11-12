package pcg.tilegenerators 
{
	
	/**
	 * ...
	 * @author Bas Roding
	 */
	public interface TileGenerator 
	{
		function getTile(x:int, y:int, width:int, height:int):int
	}
	
}