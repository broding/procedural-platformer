package pcg 
{
	import org.flixel.FlxSprite;
	import org.flixel.*;
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class GameState extends FlxState
	{
		private var _player:Player;
		private var _level:Area;
		
		public function GameState() 
		{
			_level = new Area();
			add(_level);
			
			_player = new Player();
			var spawnpoint:FlxPoint = new FlxPoint();
			spawnpoint = _level.getPlayerSpawnPoint(40);
			_player.x = spawnpoint.x;
			_player.y = spawnpoint.y;
			add(_player);
		}
		
		override public function update():void 
		{
			super.update();
			
			FlxG.collide(_player, _level.collideTilemap);
		}
		
	}

}