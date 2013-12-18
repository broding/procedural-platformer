package pcg.painter 
{
	import org.flixel.FlxRect;
	import org.flixel.FlxTilemap;
	import org.flixel.system.FlxTile;
	
	import pcg.Area;
	import pcg.tilegenerators.EmptyTileGenerator;

	/**
	 * ...
	 * @author Bas Roding
	 */
	public class Painter 
	{
		private var paints:Vector.<Paint>;
		
		public function Painter() 
		{
			paints = new Vector.<Paint>();
		}
		
		public function addPaint(paint:Paint):void
		{
			paints.push(paint);
		}
		
		public function clearPaints():void
		{
			paints = null;
			paints = new Vector.<Paint>();
		}
		
		public function paint(decorationMap:FlxTilemap, collideMap:FlxTilemap):void
		{	
			trace(collideMap.widthInTiles);
			trace(collideMap.heightInTiles);
			
			for (var j:int = 0; j < paints.length; j++)
			{
				for (var x:int = 0; x < collideMap.widthInTiles; x++)
				{
					for (var y:int = 0; y < collideMap.heightInTiles; y++)
					{
						var paint:int = paints[j].applyPaint(x, y, collideMap, decorationMap.getTile(x, y));
						decorationMap.setTile(x, y, paint);
					}
				}
			}
		}
		
		public function repaint(original:Area, rect:FlxRect):Area
		{
			for (var j:int = 0; j < paints.length; j++)
			{
				for (var x:int = rect.x; x < rect.width; x++)
				{
					for (var y:int = rect.y; y < rect.height; y++)
					{
						original.setTile(paints[j].applyPaint(x, y, original, original.getTile(x, y)), x, y);
					}
				}
			}
			
			return original;
		}
		
	}

}