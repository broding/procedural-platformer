package pcg.painter 
{
	import org.flixel.FlxRect;
	
	import pcg.ArrayMap;
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
		
		public function paint(referenceMap:ArrayMap, cleanMap:Boolean = false):ArrayMap
		{
			var map:ArrayMap = cleanMap ? new ArrayMap(new EmptyTileGenerator(), referenceMap.width, referenceMap.height) : referenceMap;
			
			for (var j:int = 0; j < paints.length; j++)
			{
				for (var x:int = 0; x < referenceMap.width; x++)
				{
					for (var y:int = 0; y < referenceMap.height; y++)
					{
						map.setTile(paints[j].applyPaint(x, y, referenceMap, map.getTile(x, y)), x, y);
					}
				}
			}
			
			return map;
		}
		
		public function repaint(original:ArrayMap, rect:FlxRect):ArrayMap
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