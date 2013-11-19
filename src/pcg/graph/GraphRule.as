package pcg.graph
{
	public interface GraphRule
	{
		function applyRule(node:Node, graph:Graph):void;
	}
}