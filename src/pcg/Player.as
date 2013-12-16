package pcg 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;

	/**
	 * ...
	 * @author Bas Roding
	 */
	public class Player extends FlxSprite implements GameEventListener
	{
		private static const WALK_SPEED:uint = 119;
		private static const JUMP_POWER:uint = 240;
		private static const RUN_SPEED:uint = 130;
		
		[Embed(source = "../../assets/player2.png")] private var _playerImage:Class;
		[Embed(source = "../../assets/muzzle.png")] private var _muzzleImage:Class;
		
		private var _jumping:Boolean = false;
		private var _jumpedAgo:Number = 0;
		private var _climbingLadder:Boolean;
		
		private var _bombs:FlxGroup;
		private var _weapon:Weapon;
		
		private var _justLandedTimer:Number;
		
		public function Player() 
		{
			_bombs = new FlxGroup();
			_weapon = new Weapon();
			_climbingLadder = false;
			
			this.loadGraphic(_playerImage, true, true, 16, 16);
			this.addAnimation("idle", [0], 10);
			this.addAnimation("walk", [0, 1, 0, 2], 7);
			this.addAnimation("jump", [3], 3, false);
			this.addAnimation("jump_falling", [4, 5], 5);
			this.addAnimation("jump_end", [6, 0], 5, false);
			this.addAnimation("shooting", [7, 0], 5);
			this.addAnimation("knocked", [8], 5, false);
			this.width = 10;
			this.offset.x = 3;
		}
		
		override public function update():void 
		{
			super.update();
			
			_weapon.update();
			
			checkAnimation();
			
			if (FlxG.keys.LEFT) 
				velocity.x = -WALK_SPEED;
			else if (FlxG.keys.RIGHT)
				velocity.x = WALK_SPEED;
			else 
				velocity.x = 0;
			if (FlxG.keys.justPressed("B"))
			{
				jump();
			}
			
			FlxG.overlap(this, Game.ladders, function(player:Player, ladder:Ladder):void
			{
				if((FlxG.keys.UP || FlxG.keys.DOWN))
					_climbingLadder = true;
				
				_jumping = false;
				
				player.velocity.y = player.velocity.y / 1.3;
				
				if(FlxG.keys.UP)
					player.velocity.y = -WALK_SPEED;
				else if(FlxG.keys.DOWN)
					player.velocity.y = WALK_SPEED;
			});
			
			
			
			if(FlxG.keys.X)
			{
				var fired:Boolean = _weapon.fire(x, y, facing);
				
				if(fired && velocity.x == 0 && !_jumping && _justLandedTimer == 0)
					play("shooting");
			}
			
			_justLandedTimer = Math.max(0, _justLandedTimer -= FlxG.elapsed);
			
			if (this.justTouched(FLOOR))
			{
				_jumping = false;
				play("jump_end", true);
				_justLandedTimer = 0.1;
			}
				
			if(!_climbingLadder)
				velocity.y += 13;
			
			_climbingLadder = false;
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
			if (!_jumping && velocity.x == 0 && _justLandedTimer == 0)
				play("idle");
			else if (!_jumping && velocity.x != 0 && _justLandedTimer == 0)
				play("walk");
			
			if(_jumping && velocity.y > 0)
				play("jump_falling");
				
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
		
		public function hit(enemy:Enemy):void
		{	
			flicker(1);
			flash(0xff0000, 0.2);
			FlxG.shake(0.03, 0.08);
		}
		
		private function knockBack(direction:uint, force:uint):void
		{
			velocity.make((direction == FlxObject.LEFT ? -1 : 1) * force, -100);
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