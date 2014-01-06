package pcg
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;

	public class DeadScreen extends FlxGroup
	{
		private var _fading:Boolean;
		
		public function DeadScreen()
		{
			_fading = false;
			
			var title:FlxText = new FlxText(0, 80, FlxG.width, "NO TREASURE FOR YOU, BOY", true);
			title.setFormat("bold20", 20);
			title.alignment = "center";
			title.scrollFactor.make(0,0);
			
			var text:FlxText = new FlxText(0, 130, FlxG.width, "Press SPACE to continue..", true);
			text.setFormat("normal10", 10);
			text.alignment = "center";
			text.scrollFactor.make(0,0);
			
			var bg:FlxSprite = new FlxSprite();
			bg.makeGraphic(FlxG.width, FlxG.height, 0xff111111);
			bg.scrollFactor.make(0,0);
			bg.alpha = 0.9;
			
			add(bg);
			add(title);
			add(text);
		}
		
		override public function update():void
		{
			if(FlxG.keys.justPressed("SPACE"))
			{
				FlxG.timeScale = 1;
				FlxG.switchState(new LoadState());	
			}
		}
	}
}