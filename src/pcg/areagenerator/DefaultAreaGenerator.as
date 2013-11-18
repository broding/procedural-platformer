package pcg.areagenerator
{
	import pcg.Area;
	import pcg.ArrayMap;
	import pcg.automata.NeighboursToRockRule;
	import pcg.automata.RuleItterator;
	import pcg.tilegenerators.GradientTileGenerator;
	import pcg.automata.BorderRocksRule;
	import pcg.tilegenerators.SimpleTileGenerator;

	public class DefaultAreaGenerator implements AreaGenerator
	{
		public function generateArea():Area
		{
			var map:ArrayMap = new ArrayMap(new SimpleTileGenerator(), 30, 20);
			
			var itterator:RuleItterator = new RuleItterator();
			itterator.addRule(new NeighboursToRockRule(2, 5));
			itterator.addRule(new BorderRocksRule());
			
			map = itterator.itterate(map);
			
			var area:Area = new Area(map);
			
			return area;
		}
		
	}
}