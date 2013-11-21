package pcg
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	
	import pcg.areagenerator.AreaGenerator;
	import pcg.areagenerator.DefaultAreaGenerator;
	import pcg.painter.HangingGrassPaint;
	import pcg.painter.Painter;
	import pcg.painter.RockFloorPaint;

	public class Level implements GameEventListener
	{	
		private var _areas:FlxGroup;
		private var _collideMaps:FlxGroup;
		private var _decorationMaps:FlxGroup;
		
		public function Level()
		{
			_areas = new FlxGroup();
			_collideMaps = new FlxGroup();
			_decorationMaps = new FlxGroup();
			
			var generator:AreaGenerator = new DefaultAreaGenerator();
			
			var area:Area = generator.generateArea();
			var painter:Painter = new Painter();
			painter.addPaint(new HangingGrassPaint());
			painter.addPaint(new RockFloorPaint());
			area.paint(painter);
			
			addArea(area);
		}
		
		private function addArea(area:Area):void
		{
			_areas.add(area);
			_collideMaps.add(area.collideTilemap);
			_decorationMaps.add(area.decorationTilemap);
		}
		
		private function processExplosion(position:FlxPoint, radius:uint):void
		{
			_areas.members[0].processExplosion(position, radius);
		}
		
		public function getBeginArea():Area
		{
			return _areas.members[0];
		}
		
		public function receiveEvent(event:GameEvent):void
		{
			switch(event.type)
			{
				case GameEvent.EXPLOSION:
					processExplosion(new FlxPoint(Math.floor(event.position.x / 16), Math.floor(event.position.y / 16)), event.radius);
			}
		}

		public function get collideMaps():FlxGroup
		{
			return _collideMaps;
		}

		public function get decorationMaps():FlxGroup
		{
			return _decorationMaps;
		}

		
	}
}