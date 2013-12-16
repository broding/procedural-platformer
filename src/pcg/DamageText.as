package pcg
{
	import org.flixel.FlxG;
	import org.flixel.FlxText;

	public class DamageText extends FlxText
	{
		private var _timeAlive:Number;
		
		public function DamageText()
		{
			super(0, 0, 50, "0");
			
			kill();
		}
		
		public function activate(damage:uint, critical:Boolean):void
		{
			revive();
			
			this.text = damage.toString();
			this.alpha = 1;
			this.offsetToParent.y = -5;
			
			_timeAlive = 0;
		}
		
		override public function update():void
		{
			super.update();
			
			offsetToParent.y -= 40 * FlxG.elapsed;
			
			_timeAlive += FlxG.elapsed;
			
			this.alpha = 0.8 - _timeAlive;
			
			if(this.alpha <= 0)
				kill();
		}
	}
}