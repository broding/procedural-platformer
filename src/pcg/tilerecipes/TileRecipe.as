package pcg.tilerecipes 
{
	/**
	 * ...
	 * @author ...
	 */
	public class TileRecipe 
	{
		public static const TOP:int = 1;
		public static const LEFT:int = 8;
		public static const RIGHT:int = 2;
		public static const BOTTOM:int = 4;
		
		var name:String;
		var sideValue:int;
		
		public function TileRecipe(name:String, sideValue:int = 15) 
		{
			this.name = name;
			this.sideValue = sideValue;
		}
		
	}

}