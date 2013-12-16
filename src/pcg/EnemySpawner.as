package pcg
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;

	public class EnemySpawner extends FlxSprite
	{
		private var _budget:uint = 3;
		private var _spawnTimer:Number;
		private var _activated:Boolean;
		
		public function EnemySpawner(x:uint, y:uint)
		{
			makeGraphic(16, 16, 0xff5f0ff1);
			
			this._activated = false;
			this._spawnTimer = 0;
			this.x = x;
			this.y = y;
		}
		
		override public function update():void
		{
			super.update();
			
			if(!_activated || _budget <= 0)
				return;
			
			_spawnTimer -= FlxG.elapsed;
			
			if(_spawnTimer <= 0)
			{
				var enemy:Enemy = new Worm();
				enemy.x = x;
				enemy.y = y;
				var event:GameEvent = new GameEvent(GameEvent.ENEMY_SPAWNED);
				event.enemy = enemy;
				Game.emitGameEvent(event);
				
				_budget -= enemy.type.budgetCost;
				_spawnTimer = 2;
			}
		}
		
		public function spawn():void
		{
			if(_activated)
				return;
			_activated = true;
			
			
		}
	}
}