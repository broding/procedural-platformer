package pcg.tilerecipes 
{
	/**
	 * ...
	 * @author ...
	 */
	public class Map 
	{
		private static var _recipesList:TileRecipes;
		
		private var _recipes:Array;
		private var _height:uint;
		private var _width:uint;
		
		public function Map(width:uint, height:uint) 
		{
			this._width = width;
			this._height = height;
			
			_recipes = new Array();
			for (var i:int = 0; i < 5; i++)
			{
				_recipes[i] = new Array();
			}
		}
		
		public function loadFromCSV(csv:String, recipeLibrary:TileRecipes):void
		{
			var lines:Array = csv.split("\n");
			
			for(var y:int = 0; y < lines.length; y++)
			{
				var values:Array = lines[y].split(",");
				
				for(var x:int = 0; y < values.length; x++)
				{
					setRecipe(recipeLibrary.getRecipe(values[x]), x, y);
				}
			}
		}
		
		public function setRecipe(recipe:TileRecipe, x:uint, y:uint):void
		{
			if(x >= _width || y >= _height)
				throw new Error("Recipe added outside map size");
			
			_recipes[x][y] = recipe;
		}
		
		public function getRecipe(x:uint, y:uint):TileRecipe
		{
			return _recipes[x][y];
		}

		public function get height():uint
		{
			return _height;
		}

		public function get width():uint
		{
			return _width;
		}
	}

}