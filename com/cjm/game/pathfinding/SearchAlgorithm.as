package com.cjm.game.pathfinding 
{
	import com.cjm.math.Algorithm;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class SearchAlgorithm extends Algorithm
	{
		protected var _graph:IGraph;
		protected var _heuristic:IHeuristic;
		protected var _endNode:INode;
		protected var _startNode:INode;

		public function SearchAlgorithm( useTicks:Boolean = false, 
										 tickPerCycle:int = 100,
										 g:IGraph, 
										 a:INode, 
										 b:INode, 
										 h:IHeuristic, 
										
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