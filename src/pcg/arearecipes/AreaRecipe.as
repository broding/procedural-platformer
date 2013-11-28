package pcg.arearecipes
{
	import pcg.Area;
	import pcg.Edge;

	public interface AreaRecipe
	{
		function getName():String;
		function getAvailableEdges():Edge;
		function generateArea(edges:Edge):Area;
	}
}