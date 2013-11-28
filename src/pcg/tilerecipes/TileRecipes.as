package pcg.tilerecipes
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.DataLoader;
	import com.greensock.loading.LoaderMax;
	
	import flash.utils.getDefinitionByName;
	
	import pcg.arearecipes.DefaultAreaRecipe;
	import pcg.arearecipes.EmptyAreaRecipe;
	import pcg.arearecipes.GoalAreaRecipe;
	import pcg.arearecipes.StartAreaRecipe;

	public class TileRecipes
	{
		StartAreaRecipe;
		GoalAreaRecipe;
		EmptyAreaRecipe;
		DefaultAreaRecipe;
		
		private var _recipes:Array;
		private var _loaded:Boolean;
		private var _loadedCallback:Function;
		
		public function TileRecipes(loadedCallback:Function)
		{	
			_loaded = false;
			_loadedCallback = loadedCallback;
			_recipes = new Array();
			
			var queue:LoaderMax = new LoaderMax({name:"ruleQueue", onComplete:completeHandler});
			queue.append( new com.greensock.loading.DataLoader("../assets/tilerecipes.csv", {name:"tilerecipes"}));
			queue.load();
			
			function completeHandler(event:LoaderEvent):void 
			{
				var csv:String = LoaderMax.getContent("tilerecipes");
				var lines:Array = csv.split("\n");
				
				for each(var line:String in lines)
				{
					var values:Array = line.split(",");
					var areaRecipeClass:Class = getDefinitionByName("pcg.arearecipes::" + values[1]) as Class;
					_recipes.push(new TileRecipe(values[0], new areaRecipeClass()));
				}
				
				_loaded = true;
				_loadedCallback();
			}
		}

		public function get loaded():Boolean
		{
			return _loaded;
		}
		
		public function getRecipe(name:String):TileRecipe
		{
			for each(var recipe:TileRecipe in _recipes)
			{
				if(recipe.name == name)
					return new TileRecipe(recipe.name, recipe.areaRecipe);
			}
			
			throw new Error("Could not found recipe");
		}

	}
}