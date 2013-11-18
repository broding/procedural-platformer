package pcg 
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxState;
	
	import pcg.areagenerator.AreaGenerator;
	import pcg.areagenerator.DefaultAreaGenerator;
	import pcg.painter.HangingGrassPaint;
	import pcg.painter.Painter;
	import pcg.painter.RockFloorPaint;
	import org.flixel.FlxParticle;

	/**
	 * ...
	 * @author Bas Roding
	 */
	public class GameState extends FlxState
	{
		private var _player:Player;
		private var _level:Area;
		private var _emitter:FlxEmitter;
		
		public function GameState() 
		{
			_emitter = new FlxEmitter();
			for(var i:int = 0; i < 5; i++)
			{
				var particle:FlxParticle = new FlxParticle();
				particle.makeGraphic(2, 2, 0xffffffff);
				particle.exists = false;
				_emitter.add(particle);
			}
			
			this.initLevel();
			
			_emitter.start(true, 2, 0.1, 3);
			add(_emitter);
		}
		
		private function initLevel():void
		{
			if(_level != null)
			{
				remove(_level);
				remove(_player);
			}
			
			_player = new Player();
			
			var generator:AreaGenerator = new DefaultAreaGenerator();
			
			_level = generator.generateArea();
			var painter:Painter = new Painter();
			painter.addPaint(new HangingGrassPaint());
			painter.addPaint(new RockFloorPaint());
			_level.paint(painter);
			
			
			_player = new Player();
			var spawnpoint:FlxPoint = new FlxPoint();
			spawnpoint = _level.getPlayerSpawnPoint(3);
			_player.x = spawnpoint.x;
			_player.y = spawnpoint.y;
			
			add(_level);
			add(_player);
			add(_player.bombs);
		}
		
		override public function update():void 
		{
			super.update();
			
			FlxG.collide(_player, _level.collideTilemap);
			FlxG.collide(_player.bombs, _level.collideTilemap);
			
			if(FlxG.keys.justPressed("SPACE"))
			{
				initLevel();
			}
			
		}
		
	}

}