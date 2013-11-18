package pcg 
{
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxState;
	
	import pcg.areagenerator.AreaGenerator;
	import pcg.areagenerator.DefaultAreaGenerator;
	import pcg.painter.HangingGrassPaint;
	import pcg.painter.Painter;
	import pcg.painter.RockFloorPaint;

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
			this.initLevel();
		}
		
		private function initLevel():void
		{
			if(_level != null)
			{
				remove(_level);
				remove(_player);
			}
			
			_player = new Player();
			_player.x = 200;
			_player.y = 200;
			
			var generator:AreaGenerator = new DefaultAreaGenerator();
			
			_level = generator.generateArea();
			var painter:Painter = new Painter();
			painter.addPaint(new HangingGrassPaint());
			painter.addPaint(new RockFloorPaint());
			_level.paint(painter);
			
			add(_level);
			
			_player = new Player();
			var spawnpoint:FlxPoint = new FlxPoint();
			spawnpoint = _level.getPlayerSpawnPoint(3);
			_player.x = spawnpoint.x;
			_player.y = spawnpoint.y;
			add(_player);
		}
		
		override public function update():void 
		{
			super.update();
			
			FlxG.collide(_player, _level.collideTilemap);
			
			if(FlxG.keys.justPressed("SPACE"))
			{
				initLevel();
			}
			
		}
		
	}

}