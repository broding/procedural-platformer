package pcg
{
	import org.flixel.FlxSprite;

	public class Door extends FlxSprite
	{
		[Embed(source = "../../assets/door.png")] private var _doorImage:Class;
		
		public function Door()
		{
			loadGraphic(_doorImage);
		}
	}
}