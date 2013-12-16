package pcg.arearules 
{
	import pcg.Area;
	import pcg.tilegenerators.EmptyTileGenerator;
	import pcg.Edge;

	/**
	 * ...
	 * @author Bas Roding
	 */
	public class RuleItterator 
	{
		private var rules:Vector.<AreaRule>;
		
		public function RuleItterator() 
		{
			rules = new Vector.<AreaRule>();
		}
		
		public function addRule(rule:AreaRule):void
		{
			rules.push(rule);
		}
		
		public function itterate(map:Area):Area
		{
			for (var j:int = 0; j < rules.length; j++)
			{
				var newMap:Area = new Area(new EmptyTileGenerator(), map.width, map.height, map.edges);
				
				for (var i:int = 0; i < rules[j].getItterations(); i++)
				{
					for (var x:int = 0; x < map.width; x++)
					{
						for (var y:int = 0; y < map.height; y++)
						{
							newMap.setTile(rules[j].applyRule(x, y, map).toString(), x, y);
						}
					}
					
					map = newMap;
				}
				
			}
				
			return map;
		}
	}

}