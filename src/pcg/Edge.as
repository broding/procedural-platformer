package pcg
{
	public class Edge
	{
		public var up:Boolean;
		public var down:Boolean;
		public var left:Boolean;
		public var right:Boolean;
		
		/**
		 * If edge is FALSE!!!!, then its closed, a wall should be placed
		 */
		public function Edge(up:Boolean = false, down:Boolean = false, left:Boolean = false, right:Boolean = false)
		{
			this.up = up;
			this.down = down;
			this.left = left;
			this.right = right;
		}
	}
}