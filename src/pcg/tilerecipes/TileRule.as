package pcg.tilerecipes 
{
	import pcg.tilerecipes.Map;
	
	
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class TileRule 
	{
		var patternMap:Map;
		var resultMap:Map;
		
		public function TileRule(patternMap:Map, resultMap:Map)
		{
			this.patternMap = patternMap;
			this.resultMap = resultMap;
			
		}
		
		public function applyRule(map:Map):Boolean
		{
			for (var i = 0; i < 5; i++) {
				
			}
		}
	}
	
}