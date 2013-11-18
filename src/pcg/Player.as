package pcg 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class Player extends FlxSprite
	{
		private static const WALK_SPEED:uint = 70;
		private static const JUMP_POWER:uint = 180;
		private static const RUN_SPEED:uint = 130;
		
		[Embed(source = "../../assets/player.png")] private var _playerImage:Class;
		
		private var _jumping:Boolean = false;
		private var _jumpedAgo:Number = 0;
		
		public function Player() 
		{
			this.loadGraphic(_playerImage, true, true, 16, 16);
			this.addAnimation("idle", [0, 1, 2, 3], 10);
			this.addAnimation("walk", [4, 5, 6, 7], 10);
			this.addAnimation("jump", [8, 9], 10, false);
			this.addAnimation("jump_end", [10], 0, false);
			this.addAnimation("duck", [11, 12], 10);
			this.width = 10;
			this.offset.x = 3;
		}
		
		override public function update():void 
		{
			super.update();
			
			checkAnimation();
			
			if (FlxG.keys.LEFT && FlxG.keys.UP) {
				velocity.x = -WALK_SPEED;
				jump();
			}
			else if (FlxG.keys.RIGHT && FlxG.keys.UP) {
				velocity.x = WALK_SPEED;
				jump();
			}
			else if (FlxG.keys.LEFT)
				velocity.x = -WALK_SPEED;
			else if (FlxG.keys.RIGHT)
				velocity.x = WALK_SPEED;
			else if (FlxG.keys.UP)
				jump();
			else
				velocity.x = 0;
				
			if (this.justTouched(FLOOR))
			{
				_jumping = false;
				play("jump_end");
			}
				
			if (FlxG.keys.B)
			{
				jump();
			}
				
			velocity.y += 10;
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
		
	}

}