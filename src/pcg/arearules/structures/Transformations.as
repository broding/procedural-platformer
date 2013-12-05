package pcg.arearules.structures
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.DataLoader;
	import com.greensock.loading.LoaderMax;
	
	import pcg.loader.Loadable;

	public class Transformations implements Loadable
	{
		public static const EMPTY:String = "0";
		public static const ROCK:String = "1";
		public static const LADDER:String = "L";
		public static const TREASURE:String = "T";
		
		private static var _groups:Array;
		private static var _onComplete:Function;
		
		public function start(onComplete:Function):void
		{
			_onComplete = onComplete;
			
			var transformations:Array = ["simple"];
			_groups = new Array();
			
			var queue:LoaderMax = new LoaderMax({name:"transformationsQueue", onComplete:completeHandler});
			
			for(var i:int = 0; i < transformations.length; i++)
				queue.append( new com.greensock.loading.DataLoader("../assets/transformations/" + transformations[i] + ".csv", {name:transformations[i]}));
			
			queue.load();
			
			function completeHandler(event:LoaderEvent):void 
			{
				for each(var transformationName:String in transformations)
				{
					var group:TransformationGroup = new TransformationGroup(transformationName);
					group.passCSV(LoaderMax.getLoader(transformationName));
					_groups.push(group);
				}
				
				_onComplete();
			}
		}
		
		public static function getTransformationGroup(name:String):TransformationGroup
		{
			for(var i:int = 0; i < _groups.length; i++)
			{
				if(_groups[i].name == name)
					return _groups[i];
			}
			
			throw new Error("No group found with name");
		}
	}
}