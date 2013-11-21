package pcg 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;

	/**
	 * ...
	 * @author Bas Roding
	 */
	public class Player extends FlxSprite implements GameEventListener
	{
		private static const WALK_SPEED:uint = 70;
		private static const JUMP_POWER:uint = 180;
		private static const RUN_SPEED:uint = 130;
		
		[Embed(source = "../../assets/player.png")] private var _playerImage:Class;
		
		private var _jumping:Boolean = false;
		private var _jumpedAgo:Number = 0;
		private var _bombs:FlxGroup;
		
		public function Player() 
		{
			_bombs = new FlxGroup();
			
			this.loadGraphic(_playerImage, true, true, 16, 16);
			this.addAnimation("idle", [0, 1, 2, 3], 10);
			this.addAnimation("walk", [4, 5, 6, 7], 10);
			this.addAnimation("jump", [8, 9], 3, false);
			this.addAnimation("jump_end", [10], 0, false);
			this.addAnimation("duck", [11, 12], 10);
			this.width = 10;
			this.offset.x = 3;
		}
		
		override public function update():void 
		{
			super.update();
			
			checkAnimation();
			
			if(!flickering)
			{
				if (FlxG.keys.LEFT) 
					velocity.x = -WALK_SPEED;
				else if (FlxG.keys.RIGHT)
					velocity.x = WALK_SPEED;
				else 
					velocity.x = 0;
				if (FlxG.keys.B || FlxG.keys.UP)
				{
					jump();
				}
				
				if(FlxG.keys.justPressed("X"))
				{
					dropBomb();
				}
			}
			
			if (this.justTouched(FLOOR))
			{
				_jumping = false;
				play("jump_end");
			}
				
			velocity.y += 10;
		}
		
		private function dropBomb():void
		{	
			var bomb:Bomb = new Bomb();
			bomb.x = x;
			bomb.y = y;
			
			_bombs.add(bomb);
		}
		
		private function checkAnimation():void
		{
			if (!_jumping && velocity.x == 0)
				play("idle");
			else if (!_jumping && velocity.x != 0)
				play("walk");
				
			if (velocity.x > 0)
				facing = RIGHT;
			else if (velocity.x < 0)
				facing = LEFT;
		}
		
		private function jump():void
		{	
			if (!_jumping) // if already jumping..
			{
				play("jump");
				this.velocity.y = -JUMP_POWER;
				_jumping = true;
			}
			
		}

		public function get bombs():FlxGroup
		{
			return _bombs;
		}

		
		public function receiveEvent(event:GameEvent):void
		{
			switch(event.type)
			{
				case GameEvent.EXPLOSION:
					var position:FlxPoint = new FlxPoint(x,y);
					var distance:Number = FlxU.getDistance(position, event.position);
					if(distance < event.radius * 15)
					{
						this.flicker(1);
						velocity = new FlxPoint((position.x - event.position.x) * 20, (position.y - event.position.y) * 20);
					}
			}
		}
		
	}

}