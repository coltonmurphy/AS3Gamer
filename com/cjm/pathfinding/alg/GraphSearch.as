package com.cjm.pathfinding.alg 
{
	import com.cjm.graph.IGraph;
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
		protected var _start:int
		protected var _goal :int;
		protected var _graph:IGraph;
		public function GraphSearch( g:IGraph, source:int, target:int, useTicks:Boolean = false, tickPerCycle:int = 100) 
		{
			_graph = g; 
			_start = source;
			_goal = target;
			_useTicks = useTicks;
			_ticksPerCycle = tickPerCycle;
			_ticksCount = 0;
			_solved = false;
			_completed = false;
		}
		
		public function search():void
		{	
			//While we are not finished, and if we are using tick count then increment and check if satisfied, if not ticking or if ticking and not satisfied, the while loop will continue
			while ( !_completed && (_useTicks && (_ticksCount++ == _ticksPerCycle)) )
			{
				var resultType:int = searchOnce();
		
				_solved    = resultType == SOLVED;
				_completed = resultType == SOLVED || resultType == UNSOLVED_COMPLETE;
			}			
				
			_ticksCount = 0;		
		}
		
		/*This method is checked within internal processing*/
		public function isSolved():Boolean
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
		
		public function getPathToTarget():Vector.<int>
		{
			trace("getPathToTarget needs to be overridden: " + getType());
			return new Vector.<int>
		}
		
		public function getType():String{return _type}
	}

}