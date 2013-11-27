package pcg.tilerecipes 
{
	import pcg.arearecipes.AreaRecipe;

	/**
	 * ...
	 * @author ...
	 */
	public class TileRecipe 
	{
		public static const TOP:int = 1;
		public static const LEFT:int = 8;
		public static const RIGHT:int = 2;
		public static const BOTTOM:int = 4;
		
		private var _name:String;
		private var _areaRecipe:AreaRecipe;
		private var _sides:int;
		
		public function TileRecipe(name:String, areaRecipe:AreaRecipe, sideValue:int = 15) 
		{
			this._name = name;
			this._areaRecipe = areaRecipe;
			this._sides = sideValue;
		}
		
		public function get name():String
		{
			return _name;
		}

		public function get areaRecipe():AreaRecipe
		{
			return _areaRecipe;
		}


	}

}