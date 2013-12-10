package pcg 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxTilemap;
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class FluidManager extends FlxGroup
	{
		public var stepSpeed:Number;
		private var _stepTimer:Number;
		private var _map:FlxTilemap;
		private var _newFluids:Array = new Array();
		private var _removeFluids:Array = new Array();
		
		private var _debugStepSpeed:Number;
		private var _startTime:Date;
		private var _endTime:Date;
		
		public function FluidManager() 
		{
			stepSpeed = 0.02;
			_stepTimer = 0;
			_newFluids = new Array();
			_startTime = new Date();
			_endTime = new Date();
		}
		
		override public function update():void 
		{
			return;
			super.update();
			
			_stepTimer += FlxG.elapsed;
			
			if (_stepTimer > stepSpeed)
			{
				step();
				_stepTimer = 0;
			}
		}
		
		public function init(map:FlxTilemap):void
		{
			_map = map;
			
			var start:FlxPoint = new FlxPoint(Math.floor(Math.random() * map.width), Math.floor(Math.random() * map.height));
			
			while (Area.isSolidTile(map.getTile(start.x, start.y)))
			{
				start = new FlxPoint(Math.floor(Math.random() * map.width), Math.floor(Math.random() * map.height));
			}
		}
		
		public function addWater(x:int, y:int, amount:uint = 150):void
		{
			var fluid:Fluid = new Fluid(amount);
			fluid.x = x * (_map.width / _map.widthInTiles);
			fluid.y = y * (_map.width / _map.widthInTiles);
			add(fluid);
		}
		
		public function isAllFluidStill():Boolean
		{
			for(var i:int = 0; i < this.length; i++)
			{
				var fluid:Fluid = members[i];
				
				if(!fluid.still)
					return false;
			}
			
			return true;
		}
		
		public function step():void
		{
			_startTime = new Date();
			
			_newFluids.splice(0);
			_removeFluids.splice(0);
			
			for (var i:int = 0; i < this.length; i++)
			{
				var fluid:Fluid = members[i];
				
				if (isValidTile(fluid.x, fluid.y + 1 * 16))
					flowDown(fluid);
				else
					flowSideways(fluid);
					
			}
			
			for (var j:int = 0; j < _newFluids.length; j++)
				add(_newFluids[j]);
				
			for (j = 0; j < _removeFluids.length; j++)
				remove(_removeFluids[j], true);
				
			_endTime = new Date();
			
			_debugStepSpeed = _endTime.getMilliseconds() - _startTime.getMilliseconds();
		}
		
		private function isWaterTile(x:uint, y:uint):Boolean
		{
			for (var i:int = 0; i < this.length; i++)
			{
				var fluid:Fluid = members[i];
				
				if (fluid.x == x && fluid.y == y)
					return true;
			}
			
			return false;
		}
		
		private function isValidTile(x:uint, y:uint):Boolean
		{
			if (Area.isSolidTile(_map.getTile(x / 16, y / 16)))
				return false;
				
			if (isWaterTile(x, y))
				return false;
			
			return true;
		}
		
		private function flowDown(fluid:Fluid):void
		{
			fluid.liquidVelocity.x = 0;
			fluid.stepsMoving = 0;
			flowTo(fluid.x, fluid.y + 16, fluid);
		}
		
		private function flowSideways(fluid:Fluid):void
		{
			if (fluid.liquidVelocity.x == 0)
				fluid.liquidVelocity.x = Math.random() > 0.5 ? -1 : 1; 
				
			if(!isValidTile(fluid.x + fluid.liquidVelocity.x * 16, fluid.y))
			{
				fluid.liquidVelocity.x *= -1;
				
				if (!isValidTile(fluid.x + fluid.liquidVelocity.x * 16, fluid.y))
				{
					fluid.still = true;
					return;
				}
			}
			
			if (fluid.stepsMoving > 20 && !isWaterTile(fluid.x - fluid.liquidVelocity.x * 16, fluid.y))
				_removeFluids.push(fluid);
			
			fluid.still = false;
			
			if(!isWaterTile(fluid.x, fluid.y + 16))
				fluid.stepsMoving += 5;
			else
				fluid.stepsMoving += 1;
			
			flowTo(fluid.x + fluid.liquidVelocity.x * 16, fluid.y, fluid);
		}
		
		private function flowTo(x:uint, y:uint, fluid:Fluid):void
		{
			if (fluid.isSource())
			{
				var newFluid:Fluid = new Fluid(fluid.sourceCount);
				newFluid.x = fluid.x;
				newFluid.y = fluid.y;
				
				_newFluids.push(newFluid);
			}

			fluid.x = x;
			fluid.y = y;
		}
		
		public function get debugStepSpeed():Number 
		{
			return _debugStepSpeed;
		}
	}

}