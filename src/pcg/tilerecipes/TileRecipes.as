package pcg.tilerecipes
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.DataLoader;
	import com.greensock.loading.LoaderMax;
	
	import pcg.arearecipes.AreaRecipe;
	import pcg.arearecipes.DefaultAreaRecipe;
	import pcg.arearecipes.EmptyAreaRecipe;
	import pcg.arearecipes.GoalAreaRecipe;
	import pcg.arearecipes.StartAreaRecipe;
	import pcg.loader.Loadable;

	public class TileRecipes implements Loadable
	{	
		private static var _recipes:Array;
		private static var _onComplete:Function;
		
		public static function getRecipe(name:String):TileRecipe
		{
			for each(var recipe:TileRecipe in _recipes)
			{
				if(recipe.name == name)
					return new TileRecipe(recipe.name, recipe.areaRecipe);
			}
			
			throw new Error("Could not found recipe");
		}
		
		public function start(onComplete:Function):void
		{
			_onComplete = onComplete;
			_recipes = new Array();
			
			var queue:LoaderMax = new LoaderMax({name:"ruleQueue", onComplete:completeHandler});
			queue.append( new com.greensock.loading.DataLoader("../assets/tilerecipes.csv", {name:"tilerecipes"}));
			queue.load();
			
			function completeHandler(event:LoaderEvent):void 
			{
				var csv:String = LoaderMax.getContent("tilerecipes");
				csv = csv.replace(/\s*\R/g, "\n");
				var lines:Array = csv.split("\n");
				
				for each(var line:String in lines)
				{
					var values:Array = line.split(",");
					_recipes.push(new TileRecipe(values[0], getAreaRecipe(values[1]) ) )
				}
				
				_onComplete();
			}
		}
		
		public static function getAreaRecipe(type:String):AreaRecipe
		{
			switch(type)
			{
				case "StartAreaRecipe":
					return new StartAreaRecipe();
					break;
				case "GoalAreaRecipe":
					return new GoalAreaRecipe();
					break;
				case "DefaultAreaRecipe":
					return new DefaultAreaRecipe();
					break;
				case "EmptyAreaRecipe":
					return new EmptyAreaRecipe();
					break;
			}
			
			throw new Error("Cant find recipe");
			
		}

	}
}