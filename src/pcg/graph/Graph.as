package pcg.graph
{
	public class Graph
	{
		private var _root:Node;
		private var _rules:Array;
		
		public function Graph()
		{
			_root = new Node(Alphabet.WILDCARD);
			_root.addConnection(new Node(Alphabet.AXIOM));
			_rules = new Array();
		}
		
		public function toString():String
		{
			return "";
		}
		
		public function addRule(rule:GraphRule):void
		{
			
		}
		
		public function executeRules():void
		{
			for(var i:int = 0; i < _rules.length; i++)
			{
				_root.executeRule(_rules[i]);
			}
		}

		public function get root():Node
		{
			return _root;
		}

		public function set root(value:Node):void
		{
			_root = value;
		}
		
		public function get nodes():Array
		{
			var iterator:GraphIterator = new GraphIterator(this);
			return iterator.array;
		}

		public static function generateGraph():Graph
		{
			var graph:Graph = new Graph();
			
			var start:Node = new Node(Alphabet.START);
			var balloon:Node = new Node(Alphabet.BALLOON);
			var pit:Node = new Node(Alphabet.PIT);
			var end:Node = new Node(Alphabet.GOAL);
			
			start.addConnection(balloon);
			balloon.addConnection(pit);
			pit.addConnection(end);
			
			graph.root = start;
			
			return graph;
		}
	}
}