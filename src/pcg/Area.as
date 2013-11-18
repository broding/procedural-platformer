package pcg 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
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
	import pcg.tilegenerators.GradientTileGenerator;
	import pcg.tilegenerators.SimpleTileGenerator;
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class Area extends FlxGroup
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
		
		public function Area(map:ArrayMap) 
		{
			this._width = map.width;
			this._height = map.height;
			this._map = map;
			
			addBackground();
			
			_fluidManager = new FluidManager();
			_solidTilemap = new FlxTilemap();
			
			var painter:Painter = new Painter();
			painter.addPaint(new MiddleBlockPaint());
			painter.addPaint(new BottomBlockPaint());
			painter.addPaint(new TopBlockPaint());
			painter.addPaint(new SingleBlockPaint());
			_map = painter.paint(_map);
			
			_solidTilemap.loadMap(_map.toString(), _tilesetImage, 16, 16);
			
			_debugText = new FlxText(5, 5, 200, "");
			
			add(_solidTilemap);
			add(_fluidManager);
			add(_debugText);
		}
		
		public function paint(painter:Painter):void
		{
			if(_decorationTilemap != null)
				remove(_decorationTilemap, true);
				
			_decorationTilemap = new FlxTilemap();
			
			var decorationMap:ArrayMap = painter.paint(_map, true);
			
			_decorationTilemap.loadMap(decorationMap.toString(), _tilesetImage, 16, 16);
			
			add(_decorationTilemap);
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
			_fluidManager.init(_map);
		}
		
		override public function update():void 
		{
			super.update();
			
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
			if (tileIndex == Area.TOP_ROCK || tileIndex == Area.SINGLE_ROCK || tileIndex == Area.MIDDLE_ROCK2 || tileIndex == Area.MIDDLE_ROCK || tileIndex == Area.BOTTOM_ROCK)
				return true;
			else 
				return false;
		}
		
		public function getPlayerSpawnPoint(xpos:int):FlxPoint
		{
			var point:FlxPoint = new FlxPoint();
			
			//Boolean ==> Area.isSolidTile(_map.getTile(5, 7));
			for (var i = 0; i < _map.height; i++) {
				if (Area.isSolidTile(_map.getTile(xpos, i)) == false && Area.isSolidTile(_map.getTile(xpos, i + 1)) == true) {
					point.x = 16 * xpos;
					point.y = 16 * i;
				}
			}
			return point; 
		}
		
	}

}