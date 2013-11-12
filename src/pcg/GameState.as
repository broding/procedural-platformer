package pcg 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class GameState extends FlxState
	{
		
		public function GameState() 
		{
			var level:Level = new Level();
			
			add(level);
		}
		
	}

}