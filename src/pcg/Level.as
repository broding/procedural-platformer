package pcg 
{
	import org.flixel.*;
	import org.flixel.FlxTilemap;
	import pcg.automata.NeighboursToRockRule;
	import pcg.automata.RuleItterator;
	import pcg.painter.BottomBlockPaint;
	import pcg.painter.HangingGrassPaint;
	import pcg.painter.MiddleBlockPaint;
	import pcg.painter.Painter;
	import pcg.painter.RockFloorPaint;
	import pcg.painter.SingleBlockPaint;
	import pcg.painter.TopBlockPaint;
	import pcg.tilegenerators.SimpleTileGenerator;
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class Level extends FlxGroup
	{
		[Embed(source = "../../assets/tileset.png")] private var _tilesetImage:Class;
		[Embed(source = "../../assets/bg.png")] private var _bgImage:Class;
		
		public static const EMPTY:int = 0;
		public static const TOP_ROCK:int = 1;
		public static const MIDDLE_ROCK:int = 2;
		public static const MIDDLE_ROCK2:int = 3;
		public static const BOTTOM_ROCK:int = 4;
		public static const SINGLE_ROCK:int = 5;
		
		public static const ROCK_CEILING:int = 10;
		public static const ROCK_FLOOR:int = 11;
		public static const ROCK_FLOOR2:int = 12;
		public static const HANGING_GRASS:int = 13;
		
		private var _map:ArrayMap;
		private var _solidTilemap:FlxTilemap;
		private var _decorationTilemap:FlxTilemap;
		
		private var _fluidManager:FluidManager;
		
		private var _width:uint;
		private var _height:uint;
		
		private var _debugText:FlxText;
		
		public function Level(width:uint = 48, height:uint = 28) 
		{
			this._width = width;
			this._height = height;
			
			addBackground();
			
			_fluidManager = new FluidManager();
			_solidTilemap = new FlxTilemap();
			_decorationTilemap = new FlxTilemap();
			
			_map = new ArrayMap(new SimpleTileGenerator(), _width, _height);
			
			var itterator:RuleItterator = new RuleItterator();
			itterator.addRule(new NeighboursToRockRule(5));
			
			_map = itterator.itterate(_map, 3);
			
			_solidTilemap.loadMap(_map.toString(), _tilesetImage, 16, 16);
			_decorationTilemap.loadMap(_map.toString(), _tilesetImage, 16, 16);
			
			_debugText = new FlxText(5, 5, 200, "");
			
			add(_solidTilemap);
			add(_decorationTilemap);
			add(_fluidManager);
			add(_debugText);
		}
		
		private function addBackground():void
		{
			var spritesNeeded:uint = (_width) * (_height);
			var x:uint = 0;
			var y:uint = 0;
			
			for (var i:int = 0; i < spritesNeeded; i++)
			{
				y = Math.floor(i / _width);
				
				var sprite:FlxSprite = new FlxSprite((i % _width) * 32, y * 32, _bgImage);
				sprite.alpha = 0.8;
				
				add(sprite);
			}
		}
		
		private function initWater():void
		{
			
		}
		
		override public function update():void 
		{
			super.update();
			
			if (FlxG.keys.justPressed("SPACE"))
			{
				var itterator:RuleItterator = new RuleItterator();
				itterator.addRule(new NeighboursToRockRule(5));
			
				_map = itterator.itterate(_map, 1);
				
				var painter:Painter = new Painter();
				painter.addPaint(new MiddleBlockPaint());
				painter.addPaint(new BottomBlockPaint());
				painter.addPaint(new TopBlockPaint());
				painter.addPaint(new SingleBlockPaint());
				_map = painter.paint(_map);
				
				painter.clearPaints();
				painter.addPaint(new HangingGrassPaint());
				painter.addPaint(new RockFloorPaint());
				var decorationMap:ArrayMap = painter.paint(_map, true);
				
				this.resetTilemap();
				_solidTilemap.loadMap(_map.toString(), _tilesetImage, 16, 16);
				_decorationTilemap.loadMap(decorationMap.toString(), _tilesetImage, 16, 16);
				
				_fluidManager.init(_map);
			}
			
			if (FlxG.keys.justPressed("X"))
			{
				_map = new ArrayMap(new SimpleTileGenerator(), 45, 28);
				
				var painter:Painter = new Painter();
				painter.addPaint(new MiddleBlockPaint());
				painter.addPaint(new BottomBlockPaint());
				painter.addPaint(new TopBlockPaint());
				painter.addPaint(new SingleBlockPaint());
				_map = painter.paint(_map);
				
				resetTilemap();
				_solidTilemap.loadMap(_map.toString(), _tilesetImage, 16, 16);
			}
			
			_debugText.text = "Step time: " + _fluidManager.debugStepSpeed;
		}
		
		private function resetTilemap():void
		{
			for (var x:int = 0; x < _solidTilemap.widthInTiles; x++)
			{
				for (var y:int = 0; y < _solidTilemap.heightInTiles; y++)
				{
					_solidTilemap.setTile(x, y, 0, true);
					_decorationTilemap.setTile(x, y, 0, true);
					_fluidManager.clear();
				}
			}
		}
		
		public function get collideTilemap():FlxTilemap
		{
			return _solidTilemap;
		}
		
		public static function isSolidTile(tileIndex:int):Boolean
		{
			if (tileIndex == Level.TOP_ROCK || tileIndex == Level.SINGLE_ROCK || tileIndex == Level.MIDDLE_ROCK2 || tileIndex == Level.MIDDLE_ROCK || tileIndex == Level.BOTTOM_ROCK)
				return true;
			else 
				return false;
		}
		
	}

}