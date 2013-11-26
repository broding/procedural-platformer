package pcg.tilerecipes 
{
	/**
	 * ...
	 * @author ...
	 */
	public class Map 
	{
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
		
		public function addRecipe(recipe:TileRecipe, x:uint, y:uint):void
		{
			_recipes[x][y] = recipe;
		}
	}

}