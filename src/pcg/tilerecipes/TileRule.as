package pcg.tilerecipes 
{
	import pcg.tilerecipes.Map;
	
	
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class TileRule 
	{
		private var _patternMap:Map;
		private var _resultMap:Map;
		
		public function TileRule(patternMap:Map, resultMap:Map)
		{
			this._patternMap = patternMap;
			this._resultMap = resultMap;
			
		}
		
		public function applyRule(map:Map):Boolean
		{
			for (var i = 0; i < 5; i++) 
			{
				
			}
			
			return false;
		}
	}
	
}