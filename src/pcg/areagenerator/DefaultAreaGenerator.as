package pcg.areagenerator
{
	import pcg.Area;
	import pcg.ArrayMap;
	import pcg.automata.NeighboursToRockRule;
	import pcg.automata.RuleItterator;
	import pcg.tilegenerators.GradientTileGenerator;
	import pcg.automata.BorderRocksRule;

	public class DefaultAreaGenerator implements AreaGenerator
	{
		public function generateArea():Area
		{
			var map:ArrayMap = new ArrayMap(new GradientTileGenerator(), 30, 20);
			
			var itterator:RuleItterator = new RuleItterator();
			itterator.addRule(new NeighboursToRockRule(3, 5));
			itterator.addRule(new BorderRocksRule());
			
			map = itterator.itterate(map);
			
			var area:Area = new Area(map);
			
			return area;
		}
		
	}
}