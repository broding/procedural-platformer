package org.flixel.plugin
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxCamera;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;

	public class FlxSpriteDeluxe extends FlxSprite
	{
		private var _children:FlxGroup;
		
		public function FlxSpriteDeluxe()
		{
			_children = new FlxGroup();
		}
		
		public function add(object:FlxBasic):void
		{
			_children.add(object);
		}
		
		public function remove(object:FlxBasic):void
		{
			_children.remove(object, true);
		}
		
		override public function update():void
		{
			super.update();
			
			_children.preUpdate();
			_children.update();
			
			for(var i:int = 0; i < _children.length; i++)
			{
				if(true)
				{
					var child:FlxSprite = _children.members[i];
					child.x = x + child.offsetToParent.x;
					child.y = y + child.offsetToParent.y;
				}
				
			}
			
			_children.postUpdate();
		}
		
		override public function draw():void
		{
			super.draw();
			
			_children.draw();
		}
	}
}