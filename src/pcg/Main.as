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
			//super(2320, 2240, LoadState, 0.3, 60, 60);
			super(320, 240, LoadState, 2, 60, 60);
			
			this.forceDebugger = true;
		}
		
	}
	
}