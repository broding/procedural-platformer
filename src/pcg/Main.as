package pcg
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.flixel.FlxGame;
	
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class Main extends FlxGame 
	{
		public function Main():void 
		{
			super(720, 480 - 32, GameState, 2);
		}
		
	}
	
}