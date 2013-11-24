package pcg.arearecipes
{
	import pcg.Area;

	public class AreaRecipeFactory
	{
		public static function createAreaFromGraphNode():Area
		{
			return new DefaultAreaRecipe().generateArea();
		}
	}
}