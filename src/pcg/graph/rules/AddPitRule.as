package pcg.graph.rules
{
	import pcg.graph.Alphabet;
	import pcg.graph.GraphRule;
	import pcg.graph.Node;

	public class AddPitRule extends GraphRule
	{
		public function AddPitRule()
		{
			super();
			
			_matchGraph.root = new Node(Alphabet.WILDCARD, 0);
			_matchGraph.root.addConnection(new Node(Alphabet.GOAL, 1));
			
			var wildCardNode:Node = new Node(Alphabet.WILDCARD, 0);
			var balloonNode:Node = new Node(Alphabet.BALLOON, 2);
			wildCardNode.addConnection(wildCardNode);
			
			var pitNode:Node = new Node(Alphabet.PIT, 3);
			balloonNode.addConnection(pitNode);
			
			pitNode.addConnection(new Node(Alphabet.GOAL, 1));
			
			_targetGraph.root = wildCardNode;
		}
	}
}