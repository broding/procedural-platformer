package pcg.tilerecipes 
{
	import pcg.arearecipes.EmptyAreaRecipe;

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
			for (var x:int = 0; x < this._width; x++)
			{
				_recipes[x] = new Array();
				for(var y:int = 0; y < this._height; y++)
				{
					_recipes[x][y] = new TileRecipe("E", new EmptyAreaRecipe());
				}
			}
		}
		
		public function loadFromCSV(csv:String, recipeLibrary:TileRecipes):void
		{
			var lines:Array = csv.split("\n");
			
			for(var y:int = 0; y < lines.length; y++)
			{
				var values:Array = lines[y].split(",");
				
				for(var x:int = 0; x < values.length; x++)
				{
					var name:String = (values[x] as String).substr(0, 1);
					var sides:String = (values[x] as String).substr(1);
					
					var recipe:TileRecipe = recipeLibrary.getRecipe(name);
					recipe.calculateEdges(int(sides));
					setRecipe(recipe, x, y);
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
			if(_recipes[x][y] == null)
				throw new Error("Could not find recipe");
			else
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
		
		public function print():void
		{
			var map:String;
			trace("map ( " + _width + " - " + _height + ":");
			
			for (var y:int; y < _height; y++)
			{
				map = "";
				for(var x:int; x < _width; x++)
				{
					map += _recipes[x][y].name + ",";
				}
				
				trace(map);
			}
			
			trace("");
		}
	}

}