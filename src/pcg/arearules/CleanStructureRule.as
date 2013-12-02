package pcg.arearules
{
	import pcg.Area;

	public class CleanStructureRule implements AreaRule
	{
		public function CleanStructureRule()
		{
		}
		
		public function applyRule(x, y:int, map:Area):uint
		{
			return 0;
		}
		
		public function getItterations():uint
		{
			return 0;
		}
		
	}
}