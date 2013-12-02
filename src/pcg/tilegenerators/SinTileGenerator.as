package pcg.tilegenerators
{
	import pcg.Area;

	public class SinTileGenerator implements TileGenerator
	{	
		public function getTile(x:int, y:int, width:int, height:int):int
		{
			var xRandom:Number = 1 + Math.random() * 3;
			var yRandom:Number = 1 + Math.random() * 3;
			
			var value:Number = Math.sin(x * xRandom) + Math.sin(y * yRandom);
			
			return value > 0.09 ? Area.BOTTOM_ROCK : Area.EMPTY;
		}
		
		public const lerp:Function = function( amount:Number , start:Number, end:Number ):Number 
		{
			if ( start == end ) 
			{
				return start ;
			}
			return ( ( 1 - amount ) * start ) + ( amount * end ) ;
		};
		
	}
}