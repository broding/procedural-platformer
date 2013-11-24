package pcg.graph
{
	public class Node
	{
		public const MAX_CONNECTIONS:uint = 3;
		
		private static var _idIncrementer:uint = 0;
		
		private var _id:uint;
		private var _identifier:int;
		private var _connections:Array;
		private var _type:int;
		
		public function Node(type:int, identifier:int = -1)
		{
			_id = _idIncrementer++;
			_type = type;
			_identifier = identifier;
			_connections = new Array();
		}

		public function connected():uint
		{
			return 0;
		}
		
		public function hasConnection(newNode:Node):Boolean
		{
			for each(var node:Node in _connections)
			{
				if(node == newNode)
					return true;
			}
			
			return false;
		}
		
		public function addConnection(node:Node):void
		{
			if(_connections.length >= MAX_CONNECTIONS || node.connected() >= MAX_CONNECTIONS)
			{
				trace("too much connections");
			}
			
			if(hasConnection(node))
				return;
			
			_connections.push(node);
			node.addOtherConnection(this);
		}
		
		public function removeConnection(node:Node):void
		{
			_connections.splice(_connections.indexOf(node), 1);
			node.connections.splice(node.connections.indexOf(this), 1);
		}
		
		internal function addOtherConnection(node:Node):void
		{
			if(_connections.length >= MAX_CONNECTIONS || node.connected() >= MAX_CONNECTIONS)
			{
				trace("too much connections");
			}
			
			_connections.push(node);
		}
		
		public function executeRule(rule:GraphRule):void
		{
			
		}
		
		public function hasConnectionWithType(type:int):Boolean
		{
			for(var i:int = 0; i < _connections.length; i++)
			{
				if(_connections[i].type == type)
					return true;
			}
			
			return false;
		}

		public function getConnectionWithType(type:int):Node
		{
			for(var i:int = 0; i < _connections.length; i++)
			{
				if(_connections[i].type == type)
					return _connections[i];
			}
			
			return null;
		}
		
		public function get type():int
		{
			return _type;
		}
		
		public function set type(value:int):void
		{
			_type = value;
		}

		public function get identifier():int
		{
			return _identifier;
		}

		public function get connections():Array
		{
			return _connections;
		}

		public function set identifier(value:int):void
		{
			_identifier = value;
		}

		public function get id():uint
		{
			return _id;
		}


	}
}