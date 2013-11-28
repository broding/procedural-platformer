package pcg.tilerecipes 
{
	import pcg.Edge;
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
		private var _edges:Edge;
		
		public function TileRecipe(name:String, areaRecipe:AreaRecipe, sideValue:int = 0) 
		{
			this._name = name;
			this._areaRecipe = areaRecipe;
			this._edges = new Edge();
			
			this.calculateEdges(sideValue);
		}
		
		public function get name():String
		{
			return _name;
		}

		public function get areaRecipe():AreaRecipe
		{
			return _areaRecipe;
		}

		public function get edges():Edge
		{
			return _edges;
		}

		public function set sides(value:Edge):void
		{
			_edges = value;
		}

		public function calculateEdges(sideValue:int):void
		{
			this._edges.up = sideValue % 2 == 1;
			this._edges.right = sideValue % 4 == 2 || sideValue % 4 == 3;
			this._edges.down = sideValue % 8 >= 4;
			this._edges.left = sideValue >= 8;
		}
		
		public function generateSideValue():uint
		{
			return (_edges.up ? 1 : 0) + (_edges.right ? 2 : 0) + (_edges.down ? 4 : 0) + (_edges.left ? 8 : 0);
		}
	}

}