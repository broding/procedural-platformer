package pcg.arearules.structures
{
	

	public class Transformation
	{
		private var _width:uint;
		private var _height:uint;
		
		private var _pattern:Array;
		private var _result:Array;
		
		public function Transformation(csv:String)
		{
			csv = csv.replace("\r", "");
			var split:Array = csv.split("\n\n");
			
			var patternCsv:String = split[0];
			var resultCsv:String = split[1];
			var width:int = split[0].split("\n")[0].split(",").length;
			var height:int = split[0].split("\n").length;
			
			_width = width;
			_height = height;
			
			// setup array
			
			_pattern = new Array();
			_result = new Array();
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
			
			var patternLine:Array = patternCsv.split("\n");
			var resultLine:Array = resultCsv.split("\n");
			
			for(y = 0; y < patternLine.length; y++)
			{
				var patternValues:Array = patternLine[y].split(",");
				var resultValues:Array = resultLine[y].split(",");
				
				for(x = 0; x < patternValues.length; x++)
				{
					_pattern[x][y] = patternValues[x];
					_result[x][y] = resultValues[x];
				}
			}
		}
		
		public function passCSV(csv:String):void
		{
			
		}

		public function get pattern():Array
		{
			return _pattern;
		}

		public function get result():Array
		{
			return _result;
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