package pcg.graph
{
	import flash.utils.Dictionary;

	public class GraphRule
	{
		protected var _matchGraph:Graph;
		protected var _targetGraph:Graph;

		public function GraphRule()
		{
			_targetGraph = new Graph();
			_matchGraph = new Graph();
		}
		
		public function excecuteOn(graph:Graph):void
		{
			var matchingPieces:Array = new Array();
			
			var iterator:GraphIterator = new GraphIterator(graph);
			for(var i:int = 0; i < iterator.array.length; i++)
			{
				var dictionary:Dictionary = new Dictionary();
				if(iterate(iterator.array[i], _matchGraph.root, dictionary))
				{
					executeRule(dictionary);
				}
			}
		}
		
		private function iterate(graphNode:Node, matchNode:Node, dictionary:Dictionary):Boolean
		{
			if(dictionary == null)
				dictionary = new Dictionary();
			
			if(graphNode.type == matchNode.type)
			{
				dictionary[matchNode.identifier] = graphNode;
				
				if(matchNode.connections.length == 0)
				{
					trace("rule '" + this + "' succesfull added!");
					return true;
				}
				
				for(var i:int = 0; i < matchNode.connections.length; i++)
				{	
					if(graphNode.hasConnectionWithType(matchNode.connections[i].type))
					{
						var matchingGraphNode:Node = graphNode.getConnectionWithType(matchNode.connections[i].type);
						
						return iterate(matchingGraphNode, matchNode.connections[i], dictionary);
					}
					else
					{
						return false;
					}
				}
			}
			
			return false;
		}
		
		private function executeRule(foundNodes:Dictionary):void
		{
			// couple loose
			for(var key:Object in foundNodes)
			{
				var node:Node = foundNodes[key];
				
				for(var i:int = 0; i < node.connections.length; i++)
				{
					if(nodeInDictionary(foundNodes, node.connections[i]))
						node.connections[i].removeConnection(node);
				}
			}
			
			// replace types
			var iterator:GraphIterator = new GraphIterator(_targetGraph);
			for(key in foundNodes)
			{
				node = foundNodes[key];
				
				for each(var targetNode:Node in iterator.array)
				{
					if(key == targetNode.identifier)
						node.type = targetNode.type;
				}
			}
			
			// add new nodes
			for each(var node:Node in iterator.array)
			{
				if(foundNodes[node.identifier] == null)
				{
					trace("new node addes");
					foundNodes[node.identifier] = new Node(node.type, node.identifier);
				}
			}
			
			
			
			// connect all nodes together, just like in the targetGraph
			for(key in foundNodes)
			{
				node = foundNodes[key];
				
				for each(var targetNode:Node in iterator.array)
				{
					if(key == targetNode.identifier)
					{
						// copy all the connections that targetNode has, to the node
						for each(var targetNodeConnection:Node in targetNode.connections)
						{
							node.addConnection(foundNodes[targetNodeConnection.identifier]);
						}
					}
				}
				
				
			}
		}
		
		private function nodeInDictionary(dictionary:Dictionary, node:Node):Boolean
		{
			for(var key:Object in dictionary)
			{
				var otherNode:Node = dictionary[key];
				if(otherNode == node)
					return true;
			}
			
			return false;
		}
		
		private function checkMatch(graphNode:Node, ruleNode:Node):Boolean
		{
			return graphNode.type == ruleNode.type;
		}
		
		public function get matchGraph():Graph
		{
			return _matchGraph;
		}

		public function get targetGraph():Graph
		{
			return _targetGraph;
		}


	}
}