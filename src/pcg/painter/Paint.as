package pcg.painter 
{
	import org.flixel.FlxTilemap;

	/**
	 * ...
	 * @author Bas Roding
	 */
	public interface Paint 
	{
		function applyPaint(x:int, y:int, map:FlxTilemap, originalTile:uint):int
	}

}