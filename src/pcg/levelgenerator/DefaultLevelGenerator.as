package pcg.levelgenerator
{
	import pcg.Area;
	import pcg.arearecipes.AreaRecipeFactory;
	import pcg.graph.Graph;
	import pcg.graph.Node;

	public class DefaultLevelGenerator implements LevelGenerator
	{
		private var _areas:Vector.<Area>;
		public function DefaultLevelGenerator()
		{
		}
		
		public function generateLevelFromGraph(graph:Graph):Vector.<Area>
		{
			_areas = new Vector.<Area>();
			
			var busyAreas:Array = new Array();
			var nodes:Array = graph.nodes;
			
			iterate(null, graph.root, new Array());
			
			return _areas;
		}
		
		private function iterate(parentArea:Area, node:Node, usedAreas:Array):void
		{
			if(parentArea == null)
			{
				var area:Area = AreaRecipeFactory.createAreaFromGraphNode();
			}
			else
			{
				var area:Area = AreaRecipeFactory.createAreaFromGraphNode();
				
				if(Math.random() > 0.3) // left and right
				{
					var leftright:int = Boolean( Math.round(Math.random())) ? -1 : 1;
					var newX:int = parentArea.x + (30 * leftright);
					var newY:int = parentArea.y;
					
					if(usedAreas[newX * parentArea.y] != null)
					{
						newX = parentArea.x + (30 * -leftright);
						
						if(usedAreas[newX * parentArea.y] != null)
						{
							newX = parentArea.x;
							newY = parentArea.y + 20;
						}
					}
					
					area.x = newX;
					area.y = newY;
				}
				else // down
				{
					area.x = parentArea.x;
					area.y = parentArea.y + 20;
				}
			}
			
			usedAreas[area.x * area.y] = true;
			
			for each(var connection:Node in node.connections)
			{
				iterate(area, connection, usedAreas);
			}
		}
		
	}
}