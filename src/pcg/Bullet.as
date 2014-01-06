package pcg
{
	import org.flixel.FlxSprite;

	public class Bullet extends FlxSprite
	{
		[Embed(source = "../../assets/bullet_big.png")] private var _bigImage:Class;
		
		private var _weapon:Weapon;
		
		public function Bullet(weapon:Weapon)
		{
			_weapon = weapon;
			
			loadGraphic(_bigImage, false, true);
			
			width = 8;
			height = 8;
			
			offset.make(2, 0);
			
			kill();
		}

		public function get weapon():Weapon
		{
			return _weapon;
		}

	}
}