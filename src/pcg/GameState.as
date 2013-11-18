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
			_player = new Player();
			_player.x = 200;
			_player.y = 200;
			
			add(_level);
			add(_player);
		}
		
		override public function update():void 
		{
			super.update();
			
			FlxG.collide(_player, _level.collideTilemap);
		}
		
	}

}