package com.cjm.game.pathfinding 
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class SearchAlgorithm 
	{
		protected var _graph:IGraph;
		protected var _heuristic:IHeuristic;
		protected var _endNode:INode;
		protected var _startNode:INode;

		
		protected var _result:*;

		public function SearchAlgorithm( g:IGraph, a:INode, b:INode, h:IHeuristic, autoRun:Boolean = true ) 
		{
			_graph = g;
			_heuristic = h;

			_startNode = a
			_endNode   = b;
			
			if ( autoRun )
			{
				preProcess();
				process();
				postProcess();
			}

		}
		
		public function process():void
		{
			while( _currentNode != _endNode )
			{
				processOnce();
			}
		}
		
		/*The methods below should be overriden by subclass*/
		public function preProcess():void
		{
			trace("Warning: SearchAlgorith preProcess is not overriden.");
		}
		
		public function postProcess():void
		{
			trace("Warning: SearchAlgorith postProcess is not overriden.");
		}
		
		public function processOnce():void
		{
			trace("Warning: SearchAlgorith processOnce is not overriden.");
		}
		
		public function getResult():*
		{
			return _result;
		}
	}
}