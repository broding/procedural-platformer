package pcg
{
	import org.flixel.FlxSprite;

	public class Ladder extends FlxSprite
	{
		[Embed(source = "../../assets/ladder.png")] private var _ladderImage:Class;
		[Embed(source = "../../assets/laddertop.png")] private var _ladderTopImage:Class;
		
		public function Ladder(top:Boolean = false)
		{
			this.loadGraphic(top ? _ladderTopImage : _ladderImage, false, false, 14, 16);
			
			this.offset.x = top ? 0 : -1;
		}
	}
}