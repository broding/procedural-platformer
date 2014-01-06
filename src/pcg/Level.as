package pcg
{	
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	
	import pcg.arearecipes.StartAreaRecipe;
	import pcg.arearules.structures.Transformations;
	import pcg.levelgenerator.LevelGenerator;
	import pcg.loader.Loader;
	import pcg.painter.HangingGrassPaint;
	import pcg.painter.Painter;
	import pcg.painter.RockFloorPaint;
	import pcg.tilegenerators.EmptyTileGenerator;
	import pcg.tilerecipes.Map;
	import pcg.tilerecipes.TileRecipe;
	import pcg.tilerecipes.TileRecipes;
	import pcg.tilerecipes.TileRule;
	import pcg.tilerecipes.TileRules;

	public class Level implements GameEventListener
	{	
		[Embed(source = "../../assets/tileset2.png")] private var _tilesetImage:Class;
		[Embed(source = "../../assets/bg.png")] private var _bgImage:Class;
		
		private var _areaSize:FlxPoint;
		
		private var _map:Map;
		private var _ladders:FlxGroup;
		private var _barrels:FlxGroup;
		private var _torches:FlxGroup;
		private var _spawnDoor:Door;
		private var _goalDoor:Door;
		private var _recipesLibrary:TileRecipes;
		private var _levelGenerator:LevelGenerator;
		private var _areas:Vector.<Area>;
		private var _collideMap:FlxTilemap;
		private var _decorationMap:FlxTilemap;
		private var _background:FlxGroup;
		
		private var _loaded:Boolean;
		
		public function Level(levelGenerator:LevelGenerator)
		{
			_loaded = false;
			
			_areaSize = new FlxPoint(Area.WIDTH, Area.HEIGHT);
			_levelGenerator = levelGenerator;
			_ladders = new FlxGroup();
			_barrels = new FlxGroup();
			_torches = new FlxGroup();
			Game.ladders = _ladders;
			
			var emptyArea:Area = new Area(new EmptyTileGenerator(), 3 * Area.WIDTH, 3 * Area.HEIGHT, new Edge());
			
			_collideMap = new FlxTilemap();
			_collideMap.loadMap(emptyArea.toString(), _tilesetImage, 16, 16);
			_decorationMap = new FlxTilemap();
			_decorationMap.loadMap(emptyArea.toString(), _tilesetImage, 16, 16);
			
			_map = new Map(3,3);
			var startRecipe:TileRecipe = new TileRecipe("S", new StartAreaRecipe(), TileRecipe.RIGHT);
			_map.setRecipe(startRecipe, 0, 0);
			
			var loader:Loader = new Loader(function():void
			{
				applyRules();
				loadMap();
			});
				
			loader.addLoadable(new TileRecipes());
			loader.addLoadable(new TileRules());
			loader.addLoadable(new Transformations());
			loader.start();
			
			_background = new FlxGroup();
			var timesX:uint = (1 * _areaSize.x * 16) / 32;
			var timesY:uint = (1 * _areaSize.y * 16) / 32;
			
			for(var x:int = 0; x < timesX; x++)
			{
				for(var y:int = 0; y < timesY; y++)
				{
					var bg:FlxSprite = new FlxSprite(x * 32, y * 32, _bgImage);
					bg.scrollFactor.make(0,0);
					_background.add(bg);
				}
			}
		}
		
		private function applyRules():void
		{	
			for(var i:int = 0; i < 80; i++)
			{
				var rule:TileRule = TileRules.getRule(Math.floor(Game.random.nextDoubleRange(0,1) * TileRules.totalRules));
				rule.applyRule(_map);
			}
		}
		
		private function loadMap():void
		{
			for(var x:int = 0; x < _map.width; x++)
			{
				for(var y:int = 0; y < _map.height; y++)
				{
					var tileRecipe:TileRecipe = _map.getRecipe(x, y);
					var area:Area = tileRecipe.areaRecipe.generateArea(tileRecipe.edges);
					area.x = x * Area.WIDTH;
					area.y = y * Area.HEIGHT;
					
					addArea(area);
				}
			}
			
			for (x = 0; x < _collideMap.widthInTiles; x++)
			{
				for (y = 0; y < _collideMap.heightInTiles; y++)
				{
					paint(x,y);	
					processTileType(x, y);
				}
			}
			
			var painter:Painter = new Painter();
			painter.addPaint(new HangingGrassPaint());
			painter.addPaint(new RockFloorPaint());
			painter.paint(_decorationMap, _collideMap);
			
			Game.tilemap = _collideMap;
			
			_loaded = true;
			
		}
		
		private function paint(x:int, y:int):void
		{
			var map:FlxTilemap = _collideMap;
			
			if(map.getTile(x, y) == 0 || map.getTile(x, y) > 35)
				return;
			
			var sides:int = 
				(map.getTile(x-1, y) != 0 ? 8 : 0) +
				(map.getTile(x, y-1) != 0 ? 1 : 0) +
				(map.getTile(x+1, y) != 0 ? 2 : 0) +
				(map.getTile(x, y+1) != 0 ? 4 : 0);
			
			_collideMap.setTile(x, y, sides + (Math.random() > 0.5 ? 20 : 0));
		}
		
		private function processTileType(x:int, y:int):void
		{
			switch(_collideMap.getTile(x,y))
			{
				case TileType.LADDER:
					addLadder(x,y);
					_collideMap.setTile(x,y, 0);
					break;
				case TileType.ENEMYSPAWNER:
					var enemySpawner:EnemySpawner = new EnemySpawner(x * 16, y * 16);
					Game.director.addEnemySpawner(enemySpawner);
					_collideMap.setTile(x,y, 0);
					break;
				case TileType.BARREL:
					var barrel:Barrel = new Barrel();
					barrel.x = x * 16 + 3;
					barrel.y = y * 16;
					_barrels.add(barrel);
					_collideMap.setTile(x,y, 0);
					break;
				case TileType.SPAWNDOOR:
					var door:Door = new Door();
					door.x = x * 16;
					door.y = y * 16 - 10;
					_spawnDoor = door;
					_collideMap.setTile(x,y, 0);
					break;
				case TileType.GOALDOOR:
					var goalDoor:Door = new Door();
					goalDoor.x = x * 16;
					goalDoor.y = y * 16 - 10;
					_goalDoor = goalDoor;
					_collideMap.setTile(x,y, 0);
					break;
			}
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
		}
		
		private function addLadder(x:int, y:int):void
		{
			var ladder:Ladder = new Ladder(true);
			ladder.x = x * 16;
			ladder.y = y * 16;
			ladders.add(ladder);
			
			var i:int = 1;
			
			while(_collideMap.getTile(x, y + i) == 0)
			{
				ladder = new Ladder();
				ladder.x = x * 16;
				ladder.y = (y + i) * 16;
				ladders.add(ladder);
				
				i++;
			}
		}
		
		/**
		 * Recursive function
		 */
		private function processExplosion(position:FlxPoint, radius:uint, modifiedTiles:Array = null):void
		{
			if(modifiedTiles == null)
			{
				var maxTiles:uint = _collideMap.widthInTiles * _collideMap.heightInTiles
				modifiedTiles = new Array(maxTiles);
			}
			
			var tileIndex:uint = position.y * _collideMap.widthInTiles + position.x;
			
			// early outs
			if(radius == 0 || modifiedTiles[tileIndex] == true)
				return;
			
			_collideMap.setTile(position.x, position.y, 0, true);
			_decorationMap.setTile(position.x, position.y - 1, 0, true);
			
			modifiedTiles[tileIndex] = true;
			
			// down
			processExplosion(new FlxPoint(position.x, position.y + 1), radius - 1, modifiedTiles);
			// up
			processExplosion(new FlxPoint(position.x, position.y - 1), radius - 1, modifiedTiles);
			// left
			processExplosion(new FlxPoint(position.x - 1, position.y), radius - 1, modifiedTiles);
			// down
			processExplosion(new FlxPoint(position.x + 1, position.y), radius - 1, modifiedTiles);
		}
		
		public function receiveEvent(event:GameEvent):void
		{
			switch(event.type)
			{
				case GameEvent.EXPLOSION:
					processExplosion(new FlxPoint(Math.floor(event.position.x / 16), Math.floor(event.position.y / 16)), event.radius);
					repaint(event.position.x / 16 - event.radius, event.position.y / 16 - event.radius, event.radius * 2 + 1, event.radius * 2 + 1	);
			}
		}
		
		private function repaint(startX:uint, startY:uint, width:uint, height:uint):void
		{
			for(var x:int = startX; x < startX + width; x++)
			{
				for(var y:int = startY; y < startY + height; y++)
				{
					paint(x, y);
				}
			}
		}

		public function get collideMap():FlxTilemap
		{
			return _collideMap;
		}

		public function get areaSize():FlxPoint
		{
			return _areaSize;
		}

		public function get ladders():FlxGroup
		{
			return _ladders;
		}

		public function get background():FlxGroup
		{
			return _background;
		}

		public function get loaded():Boolean
		{
			return _loaded;
		}

		public function get decorationMap():FlxTilemap
		{
			return _decorationMap;
		}

		public function get barrels():FlxGroup
		{
			return _barrels;
		}

		public function get spawnDoor():Door
		{
			return _spawnDoor;
		}

		public function get goalDoor():Door
		{
			return _goalDoor;
		}

		public function get torches():FlxGroup
		{
			return _torches;
		}

		
	}
}