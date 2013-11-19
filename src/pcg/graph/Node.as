package pcg.graph
{
	public class Node
	{
		public const MAX_CONNECTIONS:uint = 3;
		
		public static const NORMAL:String = "NORMAL";
		public static const BALLOON:String = "BALLOON";
		public static const PIT:String = "PIT";
		public static const BOMB:String = "BOMB";
		public static const BREAKABLE:String = "BREAKABLE";
		
		private var _connections:Array;
		private var _type:String;
		
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

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

	}
}