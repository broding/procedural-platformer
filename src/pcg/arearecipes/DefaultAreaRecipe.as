package pcg.arearecipes
{
	import pcg.Area;
	import pcg.Edge;
	import pcg.arearules.BorderRocksRule;
	import pcg.arearules.NeighboursToRockRule;
	import pcg.arearules.RuleItterator;
	import pcg.tilegenerators.SimpleTileGenerator;

	public class DefaultAreaRecipe implements AreaRecipe
	{
		public function generateArea():Area
		{
			var area:pcg.Area = new pcg.Area(new SimpleTileGenerator(), 30, 20);
			
			var itterator:RuleItterator = new RuleItterator();
			itterator.addRule(new NeighboursToRockRule(1, 5));
			itterator.addRule(new BorderRocksRule());
			
			area = itterator.itterate(area);
			
			return area;
		}
		
		public function getAvailableEdges():Edge
		{
			return new Edge();
		}
		
		public function getName():String
		{
			return "Default";
		}
		
		
	}
}