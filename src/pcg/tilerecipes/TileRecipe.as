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
		
		private var _name:String;
		private var _sides:int;
		
		public function TileRecipe(name:String, sideValue:int = 15) 
		{
			this._name = name;
			this._sides = sideValue;
		}
		
	}

}