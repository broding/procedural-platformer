package pcg 
{
	import org.flixel.*;
	import org.flixel.FlxTilemap;
	import pcg.automata.NeighboursToRockRule;
	import pcg.automata.RuleItterator;
	import pcg.tilegenerators.SimpleTileGenerator;
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class Level extends FlxTilemap
	{
		[Embed(source = "../../assets/tileset.png")] private var tileset:Class;
		
		public static const EMPTY:int = 0;
		public static const ROCK:int = 1;
		
		private var map:ArrayMap;
		
		public function Level() 
		{
			map = new ArrayMap(new SimpleTileGenerator(), 45, 28);
			
			var itterator:RuleItterator = new RuleItterator();
			itterator.addRule(new NeighboursToRockRule());
			
			map = itterator.itterate(map, 3);
			
			this.loadMap(map.toString(), tileset, 16, 16);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (FlxG.keys.justPressed("SPACE"))
			{
				var itterator:RuleItterator = new RuleItterator();
				itterator.addRule(new NeighboursToRockRule());
			
				map = itterator.itterate(map, 1);
				this.resetTilemap();
				this.loadMap(map.toString(), tileset, 16, 16);
			}
			
			if (FlxG.keys.justPressed("X"))
			{
				map = new ArrayMap(new SimpleTileGenerator(), 45, 28);
				resetTilemap();
				this.loadMap(map.toString(), tileset, 16, 16);
			}
		}
		
		private function resetTilemap():void
		{
			for (var x:int = 0; x < this.widthInTiles; x++)
			{
				for (var y:int = 0; y < this.heightInTiles; y++)
				{
					this.setTile(x, y, 0, true);
				}
			}
		}
		
	}

}