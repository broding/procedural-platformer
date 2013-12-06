package pcg.tilerecipes
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.DataLoader;
	import com.greensock.loading.LoaderMax;
	
	import pcg.loader.Loadable;

	public class TileRules implements Loadable
	{
		private static var _rules:Array;
		
		private static var _onComplete:Function;
		
		public function start(onComplete:Function):void
		{
			_onComplete = onComplete;
			_rules = new Array();
			
			loadRules(["start", 
				"addDefault", 
				"addDefault2", 
				"addDefault3",
				"addDefault4",
				"addDefault5",
				"addDefault6",
				"addDefault7",
				"twister",
				"addWater"]);
		}
		
		private static function loadRules(ruleNames:Array):void
		{
			var queue:LoaderMax = new LoaderMax({name:"ruleQueue", onComplete:completeHandler});
			
			for(var i:int = 0; i < ruleNames.length; i++)
				queue.append( new com.greensock.loading.DataLoader("../assets/tilerules/" + ruleNames[i] + ".csv", {name:ruleNames[i]}));
			
			queue.load();
			
			function completeHandler(event:LoaderEvent):void 
			{
				for each(var ruleName:String in ruleNames)
					addRule(LoaderMax.getContent(ruleName));
					
				_onComplete();
			}
		}
		
		private static function addRule(csv:String):void
		{
			csv = csv.replace("\r", "");
			var split:Array = csv.split("\n\n");
			
			var patternCsv:String = split[1];
			var resultCsv:String = split[2];
			var width:int = split[1].split("\n")[0].split(",").length;
			var height:int = split[1].split("\n").length;
			
			var pattern:Map = new Map(width, height);
			var result:Map = new Map(width, height);
			
			pattern.loadFromCSV(patternCsv);
			result.loadFromCSV(resultCsv);
			
			var rule:TileRule = new TileRule(pattern, result);
			
			_rules.push(rule);
		}
		
		public static function getRule(index:uint):TileRule
		{
			return _rules[index];
		}
		
		public static function get totalRules():uint
		{
			return _rules.length;
		}
	}
}