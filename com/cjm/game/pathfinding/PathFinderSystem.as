package com.cjm.game.pathfinding 
{
	import com.cjm.game.core.GameError;
	import com.cjm.game.core.GameSystem;
	import com.cjm.game.core.IGameWorld;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class PathFinderSystem extends GameSystem
	{
		//protected var _list:Vector.<IGameEntity>; // contains targets to locate a path to
		protected var _graph:IGraph;
	    
		protected var _useAStar:Boolean;
		protected var _useDykstra:Boolean;//Future
		protected var _useM2M:Boolean;//Future use for RTS
		
		public function PathFinderSystem( w:IGameWorld ) 
		{
			super( w );
		}
		
		public function initialize( ):void 
		{
			_useAStar = true;
			_useDykstra = false;
			_useM2M = false;
		}
		
		public function setGraph( g:IGraph ):void
		{
			_graph = g;
		}
			
		//To find a path immediately, Note: Could be expensive is used excessively.
		public function findPathNodeToNode( a:INode, b:INode ):IPath
		{
			if ( _graph )
			{
				var sa:SearchAlgorithm;
				var path:IPath;
				var h:IHeuristic;
				
				if ( _useAStar )
				{
					var path:IPath = new AStar( _graph, a, b, h = new Heuristic() ).getResult() as IPath;

					if ( null != path && path.length > 0 )
						return path;
				}
			}
			
			return null;
		}
	}

}