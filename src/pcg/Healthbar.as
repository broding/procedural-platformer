package pcg
{
	import org.flixel.plugin.photonstorm.FlxBar;
	import org.flixel.plugin.photonstorm.FlxDelay;

	public class Healthbar extends FlxBar
	{
		private var _killDelay:FlxDelay;
		
		public function Healthbar(enemy:Enemy)
		{
			super(0, 0, 1, 12, 4, enemy, "health", 0, enemy.type.health);
			this.offsetToParent.make(5 - 6, -7);
			this.createFilledBar(0x11000000, 0xFFAA0000, true, 0xFFFFAAAA);
			
			_killDelay = new FlxDelay(2000);
			_killDelay.callback = kill;
			
			kill();
			
		}
		
		public function show():void
		{
			revive();
			
			_killDelay.reset(2000);
			_killDelay.start();
		}
	}
}