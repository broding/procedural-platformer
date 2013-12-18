package pcg.arearules.structures
{
	import pcg.Area;
	

	public class TransformationRule
	{
		private var _groups:Array;
		
		public function TransformationRule()
		{
			_groups = new Array();
		}
		
		public function addTransformationGroup(group:TransformationGroup):void
		{
			_groups.push(group);
		}
		
		public function applyTransformations(area:Area):void
		{
			
			for each(var group:TransformationGroup in _groups)
			{
				for(var i:int = 0; i < group.transformations.length * 2; i++)
				{
					// apply random transformation
					var index:int = Math.floor(Math.random() * group.transformations.length);
					
					applyTransformation(group.transformations[index], area)
				}
			}
		}
		
		private function applyTransformation(transformation:Transformation, area:Area):Boolean
		{
			for (var x:int = 0; x < area.width; x++) 
			{
				for(var y:int = 0; y < area.height; y++)
				{
					if(checkSubmap(transformation, area, x, y))
					{
						applyResultTransformation(transformation, area, x, y);
						return true;
					}
				}
			}
			
			return false;
		}
		
		private function checkSubmap(transform:Transformation, area:Area, startX:uint, startY:uint):Boolean
		{	
			for (var x:int = 0; x < transform.width; x++) 
			{
				for(var y:int = 0; y < transform.height; y++)
				{
					if(x + startX >= area.width || y + startY >= area.height)
						return false;
					
					if(area.getTile(x + startX,y + startY) != transform.pattern[x][y] && transform.pattern[x][y] != "*")
						return false;
				}
			}
			
			return true;
		}
		
		private function applyResultTransformation(transform:Transformation, area:Area, startX:uint, startY:uint):void
		{
			for (var x:int = 0; x < transform.width; x++) 
			{
				for(var y:int = 0; y < transform.height; y++)
				{
					if(transform.result[x][y] != "*")
						area.setTile(transform.result[x][y], x + startX, y + startY);
				}
			}
		}
		
	}
}