package pcg
{
	import org.flixel.FlxSprite;

	public class Ladder extends FlxSprite
	{
		[Embed(source = "../../assets/ladder.png")] private var _ladderImage:Class;
		
		public function Ladder()
		{
			this.loadGraphic(_ladderImage, false, false, 14, 16);
			this.offset.x = 1;
		}
	}
}