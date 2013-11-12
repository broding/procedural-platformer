package pcg 
{
	import pcg.tilegenerators.TileGenerator;
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class ArrayMap 
	{
		private var _width:uint;
		private var _height:uint;
		private var _map:Array;
		
		public function ArrayMap(generator:TileGenerator, width:uint, height:uint) 
		{
			_width = width;
			_height = height;
			_map = new Array();
			
			for (var y:int = 0; y < height; y++)
			{
				_map[y] = new Array();
				
				for (var x:int = 0; x < width; x++)
				{
					_map[y][x] = generator.getTile(x, y, width, height);
				}
			}
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
			if (x < 0 || x >= width -1 || y < 0 || y >= height - 1)
				return Level.ROCK;
				
			return _map[y][x];
		}
		
		public function setTile(value:int, x:int, y:int)
		{
			_map[y][x] = value;
		}
		
		public function get width():uint 
		{
			return _width;
		}
		
		public function get height():uint 
		{
			return _height;
		}
	}

}