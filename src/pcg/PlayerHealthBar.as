package pcg
{
	import org.flixel.FlxGroup;

	public class PlayerHealthBar extends FlxGroup
	{
		private var _player:Player;
		
		private var _previousHealth:int;
		
		public function PlayerHealthBar(player:Player)
		{
			_player = player;
			_previousHealth = _player.health;
			
			for(var i:int = 0; i < _player.health; i++)
			{
				addHeart();
			}
		}
		
		private function addHeart():void
		{
			var heart:Heart = new Heart();
			heart.scrollFactor.make(0,0);
			heart.x = members.length * 13 + 10;
			heart.y = 10;
			
			add(heart);
		}
		
		private function removeHeart():void
		{
			
		}
		
		private function updateHearts():void
		{
			for(var i:int = 0; i < length; i++)
			{
				if(i < _player.health)
					(members[i] as Heart).fillHeart();
				else
					(members[i] as Heart).emptyHeart();
			}
		}
		
		override public function update():void
		{
			super.update();
			
			if(_player.health != _previousHealth)
				updateHearts();
			
			_previousHealth = _player.health;
		}
	}
}