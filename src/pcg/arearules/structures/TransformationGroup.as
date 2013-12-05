package pcg.arearules.structures
{
	public class TransformationGroup
	{
		private var _name:String;
		private var _transformations:Array;
		
		public function TransformationGroup(name:String)
		{
			_name = name;
			_transformations = new Array();
		}
		
		public function passCSV(csv:String):void
		{
			var split:Array = csv.split("------------------\n");
			
			for each(var transformCSV:String in split)
			{
				var transformation:Transformation = new Transformation(transformCSV);
				_transformations.push(transformation);
			}
		}

		public function get name():String
		{
			return _name;
		}

		public function get transformations():Array
		{
			return _transformations;
		}
		
		
	}
}