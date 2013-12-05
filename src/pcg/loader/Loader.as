package pcg.loader
{
	public class Loader
	{
		private var _currentLoadingIndex:uint;
		private var _onComplete:Function;
		private var _loadables:Vector.<Loadable>;
		
		public function Loader(onComplete:Function)
		{
			_onComplete = onComplete;
			_currentLoadingIndex = 0;
			_loadables = new Vector.<Loadable>();
		}
		
		public function addLoadable(loadable:Loadable):void
		{
			_loadables.push(loadable);
		}
		
		public function start():void
		{
			if(_loadables.length >= 0)
				_loadables[_currentLoadingIndex].start(loadNextItem);
		}
		
		private function loadNextItem():void
		{
			if(_currentLoadingIndex + 1 >= _loadables.length)
				_onComplete();
			else
				_loadables[++_currentLoadingIndex].start(loadNextItem);
		}
	}
}