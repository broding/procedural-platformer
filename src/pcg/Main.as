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
			super(2320, 2240, GameState, 0.3, 60, 60);
			//super(320 * 2, 240 * 2, GameState, 1, 60, 60);
		}
		
	}
	
}