package pcg.painter 
{
	import pcg.Area;
	/**
	 * ...
	 * @author Bas Roding
	 */
	public interface Paint 
	{
		function applyPaint(x:int, y:int, map:Area, originalTile:uint):int
	}

}