package pcg.graph
{
	public class Node
	{
		public const MAX_CONNECTIONS:uint = 3;
		
		private var _connections:Array;
		
		public function Node()
		{
			_connections = new Array(MAX_CONNECTIONS);
		}
		
		public function connected():uint
		{
			return 0;
		}
		
		public function addConnection(node:Node):void
		{
			if(_connections.length >= MAX_CONNECTIONS || node.connected() >= MAX_CONNECTIONS)
			{
				trace("too much connections");
			}
			
			_connections.push(node);
			node.addConnection(node);
		}
		
		public function executeRule(rule:GraphRule):void
		{
			
		}
	}
}