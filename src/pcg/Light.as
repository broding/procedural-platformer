package pcg
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxDelay;

	public class Light extends FlxSprite
	{
		public static const SMALL:int = 0;
		public static const BIG:int = 2;
		public static var darkness:FlxSprite;
		
		[Embed(source = "../../assets/light.png")] private var _lightImage:Class;
		[Embed(source = "../../assets/light.png")] private var _lightBigImage:Class;
		
		public function Light(type:int = SMALL)
		{
			switch(type)
			{
				case SMALL:
					this.loadGraphic(_lightImage);
					break;
				case BIG:
					this.loadGraphic(_lightBigImage);
					break;
			}
			
			this.blend = "multiply";
			this.alpha = 0.45;
		}
		
		override public function draw():void
		{
			var screenXY:FlxPoint = getScreenXY();
			blend = "screen";
			darkness.stamp(this, screenXY.x, screenXY.y);
			blend = "overlay";
			
			super.draw();
		}
		
		override public function flash(color:uint, time:Number):void
		{
			revive();
			
			var delay:FlxDelay = new FlxDelay(time * 1000);
			delay.callback = function():void
			{
				kill();
			};
			
			delay.start();
		}
	}
}