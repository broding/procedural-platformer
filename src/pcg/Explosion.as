package pcg
{
	import org.flixel.FlxParticle;

	public class Explosion extends FlxParticle
	{
		[Embed(source = "../../assets/explosion.png")] private var _explodeImage:Class;
		
		public function Explosion()
		{
			loadGraphic(_explodeImage, true, false, 55, 55);
			addAnimation("explode", [12, 13, 14, 15, 16, 17, 18], Game.random.nextIntRange(10, 20), false);
		}
		
		override public function revive():void
		{
			super.revive();
			
			play("explode");
		}
	}
}