package pcg.arearecipes
{
	import pcg.Area;
	import pcg.Edge;
	import pcg.arearules.BorderRocksRule;
	import pcg.arearules.NeighboursToRockRule;
	import pcg.arearules.RuleItterator;
	import pcg.tilegenerators.SideTileGenerator;

	public class GoalAreaRecipe implements AreaRecipe
	{
		public function generateArea(edges:Edge):Area
		{
			var area:pcg.Area = new pcg.Area(new SideTileGenerator(edges), 30, 20, edges);
			
			var itterator:RuleItterator = new RuleItterator();
			itterator.addRule(new NeighboursToRockRule(3, 5));
			itterator.addRule(new BorderRocksRule());
			
			area = itterator.itterate(area);
			
			return area;
		}
		
		public function getAvailableEdges():Edge
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function getName():String
		{
			return "G";
		}
	}
}