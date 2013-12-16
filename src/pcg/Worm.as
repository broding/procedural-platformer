package pcg
{
	public class Worm extends Enemy
	{
		[Embed(source = "../../assets/worm.png")] private var _enemyImage:Class;
		
		public function Worm()
		{
			super();
			
			loadGraphic(_enemyImage, true, true, 16, 10);
			
			this.addAnimation("idle", [0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0], 10);
			this.addAnimation("walk", [2, 3], 7);
		}
	}
}