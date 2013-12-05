package pcg.arearules.structures
{
	import pcg.Area;
	import pcg.arearules.AreaRule;

	public class TransformationRule implements AreaRule
	{
		private var transformations:Array;
		
		public function TransformationRule()
		{
		}
		
		public function addTransformation(transformation:Transformation):void
		{
			transformations.push(transformation);
		}
		
		public function applyRule(x, y:int, map:Area):uint
		{
			return 0;
		}
		
		public function getItterations():uint
		{
			return 1;
		}
		
	}
}