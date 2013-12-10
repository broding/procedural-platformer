package pcg
{
	import org.flixel.FlxSprite;

	public class Bullet extends FlxSprite
	{
		[Embed(source = "../../assets/bullet_big.png")] private var _bigImage:Class;
		
		public function Bullet()
		{
			loadGraphic(_bigImage, false, true);
			
			kill();
		}
	}
}