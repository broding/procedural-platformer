package pcg.painter 
{
	import pcg.ArrayMap;
	/**
	 * ...
	 * @author Bas Roding
	 */
	public interface Paint 
	{
		function applyPaint(x:int, y:int, map:ArrayMap, originalTile:uint):int
	}

}