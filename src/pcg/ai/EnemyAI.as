package pcg.ai
{
	import org.flixel.FlxObject;

	public interface EnemyAI
	{
		function update():void;
		function setTarget(object:FlxObject):void;
		function destroy():void
	}
}