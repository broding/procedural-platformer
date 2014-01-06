package pcg
{
	import org.flixel.FlxSprite;

	public class Torch extends FlxSprite
	{
		public function Torch(x:int, y:int)
		{
			x += 4;
			y += 4;
			
			this.x = x;
			this.y = y;
			
			makeGraphic(8, 8, 0xffffffff);
			var light:Light = new Light(Light.BIG);
			light.x = x - light.width / 2 + 4;
			light.y = y - light.height / 2 + 4;
			
			Game.lights.add(light);
		}
	}
}