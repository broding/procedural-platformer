package pcg.arearecipes
{
	import pcg.Area;
	import pcg.Edge;
	import pcg.arearules.BorderRocksRule;
	import pcg.arearules.NeighboursToRockRule;
	import pcg.arearules.RuleItterator;
	import pcg.tilegenerators.SimpleTileGenerator;
	import pcg.tilegenerators.FullTileGenerator;

	public class EmptyAreaRecipe implements AreaRecipe
	{	
		public function generateArea(edges:Edge):Area
		{
			var area:pcg.Area = new pcg.Area(new FullTileGenerator(), Area.WIDTH, Area.HEIGHT, edges);
			
			var itterator:RuleItterator = new RuleItterator();
			itterator.addRule(new NeighboursToRockRule(5, 8));
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
			return "E";
		}
		
	}
}