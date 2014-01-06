package pcg
{
	import pcg.ai.JumpAI;

	public class Frog extends Enemy
	{
		[Embed(source = "../../assets/frog.png")] private var _frogImage:Class;
		
		public function Frog()
		{
			super();
			
			loadGraphic(_frogImage, true, true, 10, 10);
			
			this.addAnimation("idle", [0, 1, 2, 3, 4], 5);
			
			this.addAnimation("walk", [0, 1, 2, 3, 4], 5);
			
			this.width = 10;
			
			this._ai = new JumpAI(this);
			this._ai.setTarget(Game.player);
		}
	}
}