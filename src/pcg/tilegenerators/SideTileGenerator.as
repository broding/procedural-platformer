package pcg.tilegenerators
{
	import pcg.Edge;
	import pcg.Game;

	public class SideTileGenerator implements TileGenerator
	{
		private var _edges:Edge;
		
		public function SideTileGenerator(edges:Edge)
		{
			_edges = edges;	 
		}
		
		public function getTile(x:int, y:int, width:int, height:int):int
		{
			var lerpX:Number = lerp(0, width, x);
			var lerpY:Number = lerp(0, height, y);
			
			if(x <= width / 2 && _edges.left)
				lerpX = 0;
			else if(x >= width / 2 && _edges.right)
				lerpX = 0;
			
			if(y <= height / 2 && _edges.up)
				lerpY = 0;
			else if(y >= height / 2 && _edges.down)
				lerpY = 0;
			
			return Game.random.nextDoubleRange(0,1) * lerpX * 6 + Game.random.nextDoubleRange(0,1) * 6 * lerpY;
		}
		
		
		private function lerp(min:uint, max:uint, value:uint):Number
		{
			return Math.abs(((value - (max - min) / 2) * 2) / (max - min));
		}
	}
}