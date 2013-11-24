package pcg.arearules 
{
	import pcg.Area;
	
	/**
	 * ...
	 * @author Bas Roding
	 */
	public interface AreaRule 
	{
		function applyRule(x:int, y:int, map:Area):uint;
		function getItterations():uint;
	}
	
}