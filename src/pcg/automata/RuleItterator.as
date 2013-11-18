package pcg.automata 
{
	import pcg.ArrayMap;
	import pcg.tilegenerators.EmptyTileGenerator;
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class RuleItterator 
	{
		private var rules:Vector.<Rule>;
		
		public function RuleItterator() 
		{
			rules = new Vector.<Rule>();
		}
		
		public function addRule(rule:Rule):void
		{
			rules.push(rule);
		}
		
		public function itterate(map:ArrayMap):ArrayMap
		{
			for (var j:int = 0; j < rules.length; j++)
			{
				var newMap:ArrayMap = this.setupArrayMap(map.width, map.height);
				
				for (var i:int = 0; i < rules[j].getItterations(); i++)
				{
					for (var x:int = 0; x < map.width; x++)
					{
						for (var y:int = 0; y < map.height; y++)
						{
							newMap.setTile(rules[j].applyRule(x, y, map), x, y);
						}
					}
					
					map = newMap;
				}
				
			}
				
			return map;
		}
		
		private function setupArrayMap(width:int, height:int):ArrayMap
		{
			return new ArrayMap(new EmptyTileGenerator(), width, height);
		}
	}

}