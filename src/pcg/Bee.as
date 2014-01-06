package pcg
{
	public class Bee extends Enemy
	{
		[Embed(source = "../../assets/bee.png")] private var _enemyImage:Class;
		
		private const SPEED:int = 15;
		
		public function Bee()
		{
			super();
			
			loadGraphic(_enemyImage, true, true, 10, 10);
			height = 12;
			offset.y = -1;
			
			this.addAnimation("normal", [0, 1, 2, 3], 10);
			play("normal");
		}
		
		override public function update():void
		{
			super.update();
			
			if(y > Game.player.y)
				velocity.y = -SPEED;
			else
				velocity.y = SPEED;
			
			if(x > Game.player.x)
				velocity.x = -SPEED;
			else
				velocity.x = SPEED;
		}
		
		override public function kill():void
		{
			super.kill();
		}
	}
}