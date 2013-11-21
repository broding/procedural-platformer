package pcg
{
	public class Game
	{
		public static var emitEventCallback:Function;
		
		public static function emitGameEvent(event:GameEvent):void
		{
			emitEventCallback(event);
		}
	}
}