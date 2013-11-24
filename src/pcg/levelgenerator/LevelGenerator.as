package pcg.levelgenerator
{
	import pcg.Area;
	import pcg.graph.Graph;

	public interface LevelGenerator
	{
		function generateLevelFromGraph(graph:Graph):Vector.<Area>
	}
}