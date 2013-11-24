package pcg.levelgenerator
{
	import pcg.Area;
	import pcg.arearecipes.AreaRecipeFactory;
	import pcg.graph.Graph;
	import pcg.graph.Node;

	public class RandomLevelGenerator implements LevelGenerator
	{	
		public function RandomLevelGenerator()
		{
			
		}
		
		public function generateLevelFromGraph(graph:Graph):Vector.<Area>
		{
			var areas:Vector.<Area> = new Vector.<Area>();
			var busyAreas:Array = new Array();
			var nodes:Array = graph.nodes;
			
			for each(var node:Node in nodes)
			{
				var area:Area = AreaRecipeFactory.createAreaFromGraphNode();
				var x:int =  Math.floor((Math.random() * nodes.length)) * 30;
				var y:int =  Math.floor((Math.random() * nodes.length)) * 20;
				
				while(busyAreas[x * y] != null)
				{
					x =  Math.floor((Math.random() * nodes.length)) * 30;
					y =  Math.floor((Math.random() * nodes.length)) * 20;
				}
				
				busyAreas[x*y] = true;
				area.x = x;
				area.y = y;
				areas.push(area);
			}
			
			return areas;
		}
	}
}