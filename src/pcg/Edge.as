package pcg
{
	public class Edge
	{
		public var up:Boolean;
		public var down:Boolean;
		public var left:Boolean;
		public var right:Boolean;
		
		public function Edge(up:Boolean = true, down:Boolean = true, left:Boolean = true, right:Boolean = true)
		{
			this.up = up;
			this.down = down;
			this.left = left;
			this.right = right;
		}
	}
}