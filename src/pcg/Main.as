package pcg
{
	import org.flixel.FlxGame;
	
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class Main extends FlxGame 
	{
		public function Main():void 
		{
			super(1720, 1480 - 32, GameState, 0.5, 60, 60);
		}
		
	}
	
}