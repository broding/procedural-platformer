package pcg.arearecipes
{
	import pcg.Area;
	import pcg.Edge;

	public class AreaRecipeFactory
	{
		public static function createAreaFromGraphNode():Area
		{
			return new DefaultAreaRecipe().generateArea(new Edge());
		}
	}
}