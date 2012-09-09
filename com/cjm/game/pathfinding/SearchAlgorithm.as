package com.cjm.game.pathfinding 
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class SearchAlgorithm 
	{
		protected var _heuristic:IHeuristic;
		protected var endNode:INode;
		protected var startNode:INode;

		protected var _open:Array;
		protected var _closed:Array;
		protected var _graph:IGraph;
		protected var _path:IPath;//Result
		
		public function SearchAlgorithm( g:IGraph, h:IHeuristic ) 
		{
			_graph = g;
			_heuristic = h;
			
			_open = new Vector.<INode>;
			_closed = new Vector.<INode>;
		}
		
		
		public function setTargetNode( n:INode ):void
		{
			endNode = n;
		}
		
		public function setStartingNode( n:INode ):void
		{
			startNode = n;
		}
		
		public function process():void
		{
			startNode.g = 0;
			startNode.h = _heuristic.estimateCost(startNode, endNode);
			startNode.f = startNode.g + startNode.h;
		}
		
		
	}
}