package pcg
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxTilemap;
	import pcg.tilerecipes.Map;
	import pcg.tilerecipes.TileRecipe;
	
	import pcg.graph.Graph;
	import pcg.levelgenerator.LevelGenerator;
	import pcg.tilegenerators.EmptyTileGenerator;

	public class Level implements GameEventListener
	{	
		[Embed(source = "../../assets/tileset.png")] private var _tilesetImage:Class;
		[Embed(source = "../../assets/bg.png")] private var _bgImage:Class;
		
		private var _areaSize:FlxPoint;
		
		private var _graph:Graph;
		private var _levelGenerator:LevelGenerator;
		private var _areas:Vector.<Area>;
		private var _collideMaps:FlxGroup;
		private var _collideMap:FlxTilemap;
		private var _decorationMaps:FlxGroup;
		
		public function Level(graph:Graph, levelGenerator:LevelGenerator)
		{
			_areaSize = new FlxPoint(30, 20);
			_graph = graph;
			_levelGenerator = levelGenerator;
			
			_collideMap = new FlxTilemap();
			var emptyArea:Area = new Area(new EmptyTileGenerator(), 400, 400);
			_collideMap.loadMap(emptyArea.toString(), _tilesetImage, 16, 16);
			
			_collideMaps = new FlxGroup();
			_decorationMaps = new FlxGroup();
			
			_areas = _levelGenerator.generateLevelFromGraph(_graph);
			
			var map:Map = new Map();
			var startRecipe = new TileRecipe("Start", TileRecipe.BOTTOM + TileRecipe.RIGHT);
			map.addRecipe(startRecipe, 0, 0);
			
			/*
			for each(var area:Area in _areas)
			{
				addArea(area);
			}
			*/
			
			/*
			var painter:Painter = new Painter();
			painter.addPaint(new HangingGrassPaint());
			painter.addPaint(new RockFloorPaint());
			// paint area
			*/
		}
		
		private function addArea(area:Area):void
		{	
			for(var x:int = area.x; x < area.x + area.width; x++)
			{
				for(var y:int = area.y; y < area.y + area.height; y++)
				{
					_collideMap.setTile(x, y, area.getTile(x - area.x, y - area.y), true);
				}
			}
			
			//_collideMaps.add(area.collideTilemap);
			//_decorationMaps.add(area.decorationTilemap);
		}
		
		private function processExplosion(position:FlxPoint, radius:uint):void
		{
			//_areas.members[0].processExplosion(position, radius);
		}
		
		public function receiveEvent(event:GameEvent):void
		{
			switch(event.type)
			{
				case GameEvent.EXPLOSION:
					processExplosion(new FlxPoint(Math.floor(event.position.x / 16), Math.floor(event.position.y / 16)), event.radius);
			}
		}

		public function get collideMap():FlxTilemap
		{
			return _collideMap;
		}

		public function get decorationMaps():FlxGroup
		{
			return _decorationMaps;
		}

		public function get areaSize():FlxPoint
		{
			return _areaSize;
		}

		
	}
}