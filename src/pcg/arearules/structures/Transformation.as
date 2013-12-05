package pcg.arearules.structures
{
	public class Transformation
	{
		private var _width:uint;
		private var _height:uint;
		
		private var _pattern:Array;
		private var _result:Array;
		
		public function Transformation(width:uint, height:uint)
		{
			_width = width;
			_height = height;
			
			for (var x:int = 0; x < this._width; x++)
			{
				_pattern[x] = new Array();
				_result[x] = new Array();
				
				for(var y:int = 0; y < this._height; y++)
				{
					_pattern[x][y] = Transformations.EMPTY;
					_result[x][y] = Transformations.EMPTY;
				}
			}
		}
		
		public static function passCSV(csv:String):void
		{
			
		}
	}
}