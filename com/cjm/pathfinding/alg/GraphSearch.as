package com.cjm.pathfinding.alg 
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class GraphSearch 
	{
		
		//Enum of result types
		protected static const SOLVED:int = 1;//solved and finished running
		protected static const UNSOLVED:int = 0;// still trying to find solution
		protected static const UNSOLVED_COMPLETE:int = -1;// dataset is complete, no solution found
		
		protected var _useTicks:Boolean;
		protected var _ticksPerCycle:int;
		protected var _ticksCount:int;
		protected var _completed:Boolean;
		protected var _solved:Boolean;
		protected var _result:*; 
		protected var _type:String = "GraphSearch";
		
		public function GraphSearch( useTicks:Boolean = false, 
								   tickPerCycle:int = 100) 
		{
			
			_useTicks = useTicks;
			_ticksPerCycle = tickPerCycle;
			_ticksCount = 0;
			_solved = false;
			_completed = false;
		}
		
		public function search():void
		{	
			//While we are not finished, and if we are using tick count then increment and check if satisfied, if not ticking or if ticking and not satisfied, the while loop will continue
			while ( !_completed && (_useTicks && (_ticksCount++ == tickPerCycle)) )
			{
				var resultType:int = cycleOnce();
		
				_solved    = resultType == SOLVED;
				_completed = resultType == SOLVED || resultType == UNSOLVED_COMPLETE;
			}			
				
			_ticksCount = 0;		
		}
		
		/*This method is checked within internal processing*/
		public function isSolved():void
		{
			return _solved;
		}
		
		
		/*This method is responsible for updating the _completed member's value, please
		 * not if this method is called thru public means by external object, preProcess and postProcess
		 * methods will NOT run automatically
		 * returns false if can no longer process,\*/
		public function searchOnce():int
		{
			trace("Warning: SearchAlgorith processOnce is not overriden.");
			return UNSOLVED_COMPLETE;
		}
		
		//Return indices of nodes in graph
		public function getPathToTarget():Vector.<int> 
		{
			var path:Vector.<int>  = new Vector.<int> ();

			//just return an empty path if no path to target found or if
			//no target has been specified
			if ( !_solved || _goal < 0 ) return path;

			var index:int = _goal;
			path.unshift(index);

			while (index != _start)
			{
				index = _route[index];
				path.unshift(index);//push_front
			}

			return path;
		}
		
		public function getType():String{return _type}
	}

}