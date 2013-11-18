package pcg 
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class Fluid extends FlxSprite
	{
		public var liquidVelocity:FlxPoint;
		public var stepsMoving:uint;
		
		private var _source:Boolean;
		private var _sourceCount:uint;
		private var _still:Boolean;
		
		public function Fluid(sourceCount:uint = 0) 
		{
			stepsMoving = 0;
			liquidVelocity = new FlxPoint();
			
			_still = false;
			_source = sourceCount != 0 ? true : false;
			_sourceCount = sourceCount;
			
			makeGraphic(16, 16, 0xaa0000ff);
		}
		
		public function isSource():Boolean
		{
			if (_sourceCount != 0 && _source)
			{
				_source = false;
				_sourceCount--;
				return true;
			}
			
			return false;
		}
		
		public function get sourceCount():uint 
		{
			return _sourceCount;
		}
		
		public function get still():Boolean 
		{
			return _still;
		}
		
		public function set still(value:Boolean):void 
		{
			if (_still)
				makeGraphic(16, 16, 0x550000ff);
			else
				makeGraphic(16, 16, 0x550000ff);
				
			_still = value;
		}
	}

}