package pcg.graph.rules
{
	import pcg.graph.Graph;
	import pcg.graph.GraphRule;
	import pcg.graph.Node;

	public class StartRule implements GraphRule
	{
		public function applyRule(node:Node, graph:Graph):void
		{
			if(graph.root.type != Node.NORMAL)
				graph.root.type = Node.NORMAL;
		}
		
	}
}