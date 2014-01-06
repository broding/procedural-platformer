package pcg.arearecipes
{
	import pcg.Area;
	import pcg.Edge;
	import pcg.arearules.AddBarrelRule;
	import pcg.arearules.AddEnemySpawnerRule;
	import pcg.arearules.BorderRocksRule;
	import pcg.arearules.RuleItterator;
	import pcg.arearules.SideOpenerRule;
	import pcg.arearules.structures.TransformationRule;
	import pcg.arearules.structures.Transformations;
	import pcg.tilegenerators.CorridorTileGenerator;
	import pcg.Game;

	public class RandomAreaRecipe implements AreaRecipe
	{
		public function generateArea(edges:Edge):Area
		{
			var area:pcg.Area = new pcg.Area(new CorridorTileGenerator(edges), Area.WIDTH, Area.HEIGHT, edges);
			
			var numberOfRules:uint = 3;
			var ruleSelectorValue:uint = Game.random.nextIntRange(0, Math.pow(2, numberOfRules));
			
			var transformRule:TransformationRule = new TransformationRule();
			
			if (ruleSelectorValue % 2 >= 1) {
				transformRule.addTransformationGroup(Transformations.getTransformationGroup("simple_vertical"));
			}
			if (ruleSelectorValue % 4 >= 2) {
				transformRule.addTransformationGroup(Transformations.getTransformationGroup("simple_horizontal"));
			}
			if (ruleSelectorValue % 8 >= 4) {
				transformRule.addTransformationGroup(Transformations.getTransformationGroup("openarea"));
			}
			
			transformRule.applyTransformations(area);
			
			var itterator:RuleItterator = new RuleItterator();
			//itterator.addRule(new NeighboursToRockRule(1, 5));
			itterator.addRule(new AddEnemySpawnerRule());
			itterator.addRule(new AddBarrelRule());
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