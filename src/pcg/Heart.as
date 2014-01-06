package pcg
{
	import org.flixel.FlxSprite;

	public class Heart extends FlxSprite
	{
		public function Heart()
		{
			makeGraphic(10, 10, 0xffff0000);
		}
		
		public function emptyHeart():void
		{
			
			makeGraphic(10, 10, 0xff000000);
		}
		
		public function fillHeart():void
		{
			makeGraphic(10, 10, 0xffff0000);
		}
	}
}