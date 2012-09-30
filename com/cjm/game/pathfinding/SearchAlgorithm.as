package com.cjm.game.pathfinding 
{
	import com.cjm.math.Algorithm;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class SearchAlgorithm extends Algorithm
	{
		public static const NOT_FOUND:Number = 0;
		public static const NOT_FOUND:Number = 0;
		public static const FOUND:Number     = 1;
		
		protected var _graph:IGraph;
		protected var _heuristic:IHeuristic;
		protected var _endNode:INode;
		protected var _startNode:INode;

		public function SearchAlgorithm( g:IGraph, 
										 a:INode, 
										 b:INode, 
										 h:IHeuristic, 
										 useTicks:Boolean = false, 
										 tickPerCycle:int = 100
										 ) 
		{
			super( useTicks, tickPerCycle );
			
			_graph = g;
			_heuristic = h;
			_startNode = a
			_endNode   = b;
		}
	}
}