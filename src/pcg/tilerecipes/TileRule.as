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
			
			if(this._patternMap.width != this._resultMap.width || _patternMap.height != _resultMap.height)
				throw new Error("Pattern map does not match Result map size");
		}
		
		/**
		 * Rule is only applied once, even if there are two matches
		 */
		public function applyRule(map:Map):Boolean
		{
			for (var x:int = 0; x < map.width; x++) 
			{
				for(var y:int = 0; y < map.height; y++)
				{
					if(checkSubmap(map, x, y))
					{
						applyResultMap(map, x, y);
						
						return true;
					}
				}
			}
			
			return false;
		}
		
		private function checkSubmap(map:Map, startX:uint, startY:uint):Boolean
		{	
			for (var x:int = 0; x < this._patternMap.width; x++) 
			{
				for(var y:int = 0; y < this._patternMap.height; y++)
				{
					if(x + startX >= map.width || y + startY >= map.height)
						return false;
					
					if(map.getRecipe(x + startX,y + startY).name != _patternMap.getRecipe(x,y).name && _patternMap.getRecipe(x,y).name != "*")
						return false;
					
					if(map.getRecipe(x + startX,y + startY).generateSideValue() != _patternMap.getRecipe(x,y).generateSideValue() && _patternMap.getRecipe(x,y).name != "*")
						return false;
				}
			}
			
			return true;
		}
		
		private function applyResultMap(map:Map, startX:uint, startY:uint):void
		{
			for (var x:int = 0; x < this._patternMap.width; x++) 
			{
				for(var y:int = 0; y < this._patternMap.height; y++)
				{
					if(_resultMap.getRecipe(x,y).name != "*")
						map.setRecipe(_resultMap.getRecipe(x, y), x + startX, y + startY);
				}
			}
		}
	}
	
}