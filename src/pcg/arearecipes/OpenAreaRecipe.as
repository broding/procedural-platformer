package pcg.arearecipes
{
	import pcg.Area;
	import pcg.Edge;
	import pcg.arearules.BorderRocksRule;
	import pcg.arearules.RuleItterator;
	import pcg.arearules.structures.TransformationRule;
	import pcg.arearules.structures.Transformations;
	import pcg.tilegenerators.CorridorTileGenerator;

	public class OpenAreaRecipe implements AreaRecipe
	{
		public function generateArea(edges:Edge):Area
		{
			var area:pcg.Area = new pcg.Area(new CorridorTileGenerator(edges), Area.WIDTH, Area.HEIGHT, edges);
			
			var transformRule:TransformationRule = new TransformationRule();
			transformRule.addTransformationGroup(Transformations.getTransformationGroup("simple_vertical"));
			transformRule.addTransformationGroup(Transformations.getTransformationGroup("simple_horizontal"));
			transformRule.addTransformationGroup(Transformations.getTransformationGroup("openarea"));
			
			transformRule.applyTransformations(area);
			
			var itterator:RuleItterator = new RuleItterator();
			//itterator.addRule(new NeighboursToRockRule(2, 6));
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
			return "N";
		}
	}
}