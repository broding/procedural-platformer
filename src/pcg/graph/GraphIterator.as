package pcg.graph
{
	public class GraphIterator
	{
		private var _graph:Graph;
		private var _currentNode:Node;
		private var _array:Array;
		
		public function GraphIterator(graph:Graph)
		{
			_array = new Array();
			_graph = graph;
			_currentNode = null;
			
			fillArray(_graph.root);
		}
		
		private function fillArray(node:Node):void
		{
			if(!inArray(node))
				_array.push(node);
			else
				return;
			
			for(var i:int = 0; i < node.connections.length; i++)
			{
				fillArray(node.connections[i]);
			}
		}
		
		public function iterate():Node
		{
			if(_currentNode == null)
				return _currentNode = _graph.root;
			
			return null;
		}
		
		private function inArray(node:Node):Boolean
		{
			for(var i:int = 0; i < _array.length; i++)
			{
				if(_array[i] == node)
					return true;
			}
			
			return false;
		}

		public function get array():Array
		{
			return _array;
		}

	}
}