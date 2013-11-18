package pcg.automata 
{
	import pcg.ArrayMap;
	
	/**
	 * ...
	 * @author Bas Roding
	 */
	public interface Rule 
	{
		function applyRule(x:int, y:int, map:ArrayMap):uint;
		function getItterations():uint;
	}
	
}