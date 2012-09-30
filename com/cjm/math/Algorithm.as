package com.cjm.math 
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Algorithm 
	{
		protected var _useTicks:Boolean;
		protected var _ticksPerCycle:int;
		protected var _ticksCount:int;
		protected var _completed:Boolean;
		protected var _result:*;
		
		public function Algorithm( useTicks:Boolean = false, 
								   tickPerCycle:int = 100) 
		{
			_useTicks = useTicks;
			_ticksPerCycle = tickPerCycle;
			_ticksCount = 0;
			_completed = false;
		}
		
		public function cycle():void
		{
			do {
				var finished = processOnce();
				var ticksSatisfied:Boolean = (_useTicks &&  _ticksCount++ != tickPerCycle)
			}
			while( !finished && ticksSatisfied )
				trace("SearchAlgorithm processing. process cycle.");//should be responsible for changing _completed's value.);
			
		}
		
		/*This method is checked within internal processing*/
		public function isComplete():void
		{
			return _completed;
		}
		
		
		/*This method is responsible for updating the _completed member's value, please
		 * not if this method is called thru public means by external object, preProcess and postProcess
		 * methods will NOT run automatically
		 * returns false if can no longer process,\*/
		public function cycleOnce():Boolean
		{
			trace("Warning: SearchAlgorith processOnce is not overriden.");
			return false;
		}
		
		public function getResult():*
		{
			return _result;
		}
	}

}