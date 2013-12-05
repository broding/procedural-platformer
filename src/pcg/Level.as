package pcg
{	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.DataLoader;
	import com.greensock.loading.LoaderMax;
	
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxTilemap;
	
	import pcg.arearecipes.StartAreaRecipe;
	import pcg.arearules.structures.Transformations;
	import pcg.levelgenerator.LevelGenerator;
	import pcg.loader.Loader;
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
		private var _recipesLibrary:TileRecipes;
		private var _levelGenerator:LevelGenerator;
		private var _areas:Vector.<Area>;
		private var _collideMaps:FlxGroup;
		private var _collideMap:FlxTilemap;
		private var _decorationMaps:FlxGroup;
		
		private var _loaded:Boolean;
		
		public function Level(levelGenerator:LevelGenerator)
		{
			_loaded = false;
			
			_areaSize = new FlxPoint(Area.WIDTH, Area.HEIGHT);
			_levelGenerator = levelGenerator;
			
			_collideMap = new FlxTilemap();
			var emptyArea:Area = new Area(new EmptyTileGenerator(), 400, 400, new Edge());
			_collideMap.loadMap(emptyArea.toString(), _tilesetImage, 16, 16);
			
			_collideMaps = new FlxGroup();
			_decorationMaps = new FlxGroup();
			
			_map = new Map(5,5);
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
		}
		
		private function paint():void
		{
			for (var x:int = 0; x < _collideMap.widthInTiles; x++)
			{
				for (var y:int = 0; y < _collideMap.heightInTiles; y++)
				{
					var map:FlxTilemap = _collideMap;
					
					if(map.getTile(x, y) == 0)
						continue;
					
					var sides:int = 
						(map.getTile(x-1, y) != 0 ? 8 : 0) +
						(map.getTile(x, y-1) != 0 ? 1 : 0) +
						(map.getTile(x+1, y) != 0 ? 2 : 0) +
						(map.getTile(x, y+1) != 0 ? 4 : 0);
					
					_collideMap.setTile(x, y, sides);
					
				}
			}
		}
		
		private function applyRules():void
		{	
			for(var i:int = 0; i < 35; i++)
			{
				var rule:TileRule = TileRules.getRule(Math.floor(Math.random() * TileRules.totalRules));
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
			
			paint();
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