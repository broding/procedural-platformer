package pcg 
{
	import pcg.tilegenerators.TileGenerator;

	/**
	 * ...
	 * @author Bas Roding
	 */
	public class Area 
	{
		[Embed(source = "../../assets/tileset.png")] private var _tilesetImage:Class;
		[Embed(source = "../../assets/bg.png")] private var _bgImage:Class;

		public static const WIDTH:uint = 25;
		public static const HEIGHT:uint = 15;
		
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

		private var _x:int;
		private var _y:int;
		private var _width:uint;
		private var _height:uint;
		private var _edges:Edge;
		private var _map:Array;
		
		public function Area(generator:TileGenerator, width:uint, height:uint, edges:Edge) 
		{
			_x = 0;
			_y = 0;
			_width = width;
			_height = height;
			_map = new Array();
			_edges = edges;
			
			for (var y:int = 0; y < height; y++)
			{
				_map[y] = new Array();
				
				for (var x:int = 0; x < width; x++)
				{
					_map[y][x] = generator.getTile(x, y, width, height);
				}
			}
		}
		
		private function processTile(tile:String):uint
		{
			switch(tile)
			{
				case "L":
					return TileType.LADDER;
					break;
				
				case "X":
					return Math.random() > 0.5 ? 0 : 1;
					break;
			}
			
			return int(tile);
		}

		public function set y(value:int):void
		{
			_y = value;
		}

		public function set x(value:int):void
		{
			_x = value;
		}

		public function toString():String
		{
			var string:String = "";
			
			for (var y:int = 0; y < _height; y++)
			{
				for (var x:int = 0; x < _width; x++)
				{
					string += _map[y][x] + ",";
				}
				
				string += "\n"
			}
			
			string = string.slice(0, string.length - 1);
			
			return string;
		}
		
		public function getTile(x:int, y:int):int
		{
			if (x < 0 || x >= width || y < 0 || y >= height)
				return 1;
				
			return _map[y][x];
		}
		
		public function setTile(value:String, x:int, y:int):void
		{
			_map[y][x] = processTile(value);
		}
		
		public function get y():int
		{
			return _y;
		}
		
		public function get x():int
		{
			return _x;
		}
		
		public function get width():uint 
		{
			return _width;
		}
		
		public function get height():uint 
		{
			return _height;
		}
		
		public static function isSolidTile(tileIndex:int):Boolean
		{
			return tileIndex != 0;
		}

		public function get edges():Edge
		{
			return _edges;
		}

	}

}