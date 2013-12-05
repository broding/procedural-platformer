package pcg.tilegenerators
{
	import pcg.Edge;

	public class CorridorTileGenerator implements TileGenerator
	{
		private var _edges:Edge;
		
		public function CorridorTileGenerator(edges:Edge)
		{
			_edges = edges;	 
		}
		
		public function getTile(x:int, y:int, width:int, height:int):int
		{
			if(x == int(width / 2) && y == int(height / 2))
				return 0;
				
			if(x == int(width / 2) || y == int(height / 2))
			{
				if(
					(x > int(width / 2) && _edges.right) ||
					(x < int(width / 2) && _edges.left) ||
					(y < int(height / 2) && _edges.up) ||
					(y > int(height / 2) && _edges.down))
				{
					return 0;
				}
			}
			else
			{
				return 1;
			}
			
			return 1;
		}
	}
}