package pcg.arearules.structures
{
	public class TransformationGroup
	{
		private var _name:String;
		private var _transformations:Array;
		
		public function TransformationGroup(name:String)
		{
			_name = name;
		}
		
		public function passCSV(csv:String):void
		{
			
		}

		public function get name():String
		{
			return _name;
		}
		
		
	}
}