package pcg 
{
	import mx.core.FlexApplicationBootstrap;
	import org.flixel.*;
	/**
	 * ...
	 * @author Bas Roding
	 */
	public class FluidManager extends FlxGroup
	{
		public var stepSpeed:Number;
		private var _stepTimer:Number;
		private var _map:ArrayMap;
		private var _newFluids:Array = new Array();
		private var _removeFluids:Array = new Array();
		
		public function FluidManager() 
		{
			stepSpeed = 0.02;
			_stepTimer = 0;
			_newFluids = new Array();
		}
		
		override public function update():void 
		{
			super.update();
			
			_stepTimer += FlxG.elapsed;
			
			if (_stepTimer > stepSpeed)
			{
				step();
				_stepTimer = 0;
			}
		}
		
		public function init(map:ArrayMap)
		{
			_map = map;
			
			var start:FlxPoint = new FlxPoint(Math.floor(Math.random() * map.width), Math.floor(Math.random() * map.height));
			
			while (Level.isSolidTile(map.getTile(start.x, start.y)))
			{
				start = new FlxPoint(Math.floor(Math.random() * map.width), Math.floor(Math.random() * map.height));
			}
			
			var fluid:Fluid = new Fluid(200);
			fluid.x = start.x * 16;
			fluid.y = start.y * 16;
			add(fluid);
		}
		
		public function step():void
		{
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
			if (Level.isSolidTile(_map.getTile(x / 16, y / 16)))
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
			
			if (fluid.stepsMoving > 3 && !isWaterTile(fluid.x - fluid.liquidVelocity.x * 16, fluid.y))
				_removeFluids.push(fluid);
			
			fluid.still = false;
			
			if(!isWaterTile(fluid.x, fluid.y + 16))
				fluid.stepsMoving++;
			
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
		
		private function checkStill():void
		{
			for (var i:int = 0; i < this.length; i++)
			{
				var fluid:Fluid = members[i];
				
				for (var j:int = 0; j < this.length; j++)
				{
					var otherFluid:Fluid = members[j];
					
					if (fluid.x == otherFluid.x && fluid.y == otherFluid.y && fluid != otherFluid)
					{
						fluid.still = true;
						otherFluid.still = true;
					}
				}
			}
		}
	}

}