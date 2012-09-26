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
		protected var _completed:Boolean;
		
		protected var _result:*;

		public function SearchAlgorithm( g:IGraph, a:INode, b:INode, h:IHeuristic, autoExecute:Boolean = true ) 
		{
			_graph = g;
			_heuristic = h;
			_completed = false;
			_startNode = a
			_endNode   = b;
			
			if ( autoExecute )
			{
				execute();
			}

		}
		
		public function execute():void
		{
			preProcess();
			process();
			postProcess();
		}
		
		private function process():void
		{
			while( !isComplete()  )
			{
				processOnce();
				
				trace("SearchAlgorithm processing. process cycle.");//should be responsible for changing _completed's value.
			}
		}
		
		/*This method is checked within internal processing*/
		public function isComplete():void
		{
			return false;
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
		
		/*This method is responsible for updating the _completed member's value, please
		 * not if this method is called thru public means by external object, preProcess and postProcess
		 * methods will NOT run automatically
		 * returns false if can no longer process,\*/
		public function processOnce():Boolean
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