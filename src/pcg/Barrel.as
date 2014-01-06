package pcg
{
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.plugin.photonstorm.FlxDelay;

	public class Barrel extends FlxSprite implements GameEventListener
	{
		[Embed(source = "../../assets/barrel.png")] private var _barrelImage:Class;
		[Embed(source="../../assets/soundz/explosion.mp3")] private var _explosionSound:Class;
		
		public function Barrel()
		{
			health = 3;
			loadGraphic(_barrelImage);
			
			Game.addListener(this);
		}
		
		override public function update():void
		{
			super.update();
			
			velocity.y += 13;
		}
		
		public function explode():void
		{
			var event:GameEvent = new GameEvent(GameEvent.EXPLOSION);
			event.radius = 4;
			event.position = new FlxPoint(x + width / 2, y + height / 2);
			
			Game.emitGameEvent(event);
			
			kill();
			
			FlxG.shake(0.03, 0.1);
			
			FlxG.play(_explosionSound);
			
			//Game.removeListener(this);
		}
		
		public function hit():void
		{
			health -= 1;
			
			this.flash(0xffffff, 0.05);
			
			if(health <= 0)
				startExplosion();
		}
		
		private function startExplosion():void
		{
			if(!alive)
				return;
			
			var delay:FlxDelay = new FlxDelay(450);
			delay.callback = explode;
			delay.start();
			flash(0xffffff, 0.3);
		}
		
		public function receiveEvent(event:GameEvent):void
		{
			switch(event.type)
			{
				case GameEvent.EXPLOSION:
					if(FlxU.getDistance(event.position, new FlxPoint(x, y)) < 100)
					{
						startExplosion();	
					}	
					
					break;
			}
			
		}
		
	}
}