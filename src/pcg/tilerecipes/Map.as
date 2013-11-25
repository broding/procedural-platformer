package pcg.tilerecipes 
{
	/**
	 * ...
	 * @author ...
	 */
	public class Map 
	{
		var recipes:Array;
		var height:uint;
		var width:uint;
		
		public function Map() 
		{
			recipes = new Array();
			for (var i = 0; i < 5; i++)
			{
				recipes[i] = new Array();
			}
		}
		
		public function addRecipe(recipe:TileRecipe, x:uint, y:uint) 
		{
			recipes[x][y] = recipe;
		}
		
		
		
	}

}