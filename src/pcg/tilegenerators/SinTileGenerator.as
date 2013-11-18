package pcg.tilegenerators
{
	import pcg.Area;

	public class SinTileGenerator implements TileGenerator
	{	
		public function getTile(x:int, y:int, width:int, height:int):int
		{
			var value:Number = Math.sin(x) / 2;
			value += Math.sin(y) / 2;
			
			return value > 0 ? Area.BOTTOM_ROCK : Area.EMPTY;
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