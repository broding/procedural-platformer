package pcg.arearecipes
{
	import pcg.Area;
	import pcg.Edge;
	import pcg.arearules.AddDoorRule;
	import pcg.arearules.BorderRocksRule;
	import pcg.arearules.NeighboursToRockRule;
	import pcg.arearules.RuleItterator;
	import pcg.tilegenerators.SideTileGenerator;

	public class StartAreaRecipe implements AreaRecipe
	{	
		public function generateArea(edges:Edge):Area
		{
			var area:pcg.Area = new pcg.Area(new SideTileGenerator(edges), Area.WIDTH, Area.HEIGHT, edges);
			
			var itterator:RuleItterator = new RuleItterator();
			itterator.addRule(new NeighboursToRockRule(2, 5));
			itterator.addRule(new BorderRocksRule());
			itterator.addRule(new AddDoorRule());
			
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
			return "S";
		}
		
	}
}