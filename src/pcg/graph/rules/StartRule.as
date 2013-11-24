package pcg.graph.rules
{
	import pcg.graph.Alphabet;
	import pcg.graph.Graph;
	import pcg.graph.GraphRule;
	import pcg.graph.Node;

	public class StartRule extends GraphRule
	{	
		public function StartRule()
		{
			super();
			
			_matchGraph.root = new Node(Alphabet.AXIOM, 0);
			
			_targetGraph.root = new Node(Alphabet.START, 0);
			_targetGraph.root.addConnection(new Node(Alphabet.GOAL, 1));
		}
		
	}
}