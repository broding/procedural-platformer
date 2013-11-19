package pcg.graph
{
	public class Graph
	{
		private var _root:Node;
		private var _rules:Array;
		
		public function Graph()
		{
			_root = new Node();
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

	}
}