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
		protected var _algorithm:Class;
		
		public function PathFinderSystem( w:IGameWorld ) 
		{
			super( w );
		}
		
		public function setGraph( g:IGraph ):void
		{
			_graph = g;
		}
		public function setSearchAlgorithm( a:Class ):void
		{
			_algorithm = a;
		}
		
		//To find a path immediately, Note: Could be expensive is used excessively.
		public function findPathNodeToNode( a:INode, b:INode ):IPath
		{
			if ( _graph && _algorithm )
			{
				var h:IHeuristic;
				var sa:SearchAlgorithm;
				var path:IPath;
				
				h = new Heuristic();
				sa = new _algorithm( _graph, h );
				
				if ( !(sa is SearchAlgorithm) )
				{
					sa.setTargetNode( b );
					sa.setStartingNode( a );
					var path:IPath = sa.process();
					if ( null != path && path.length > 0 )
						return path;
				}
				else
				{
					throw new GameError("PathFinderSystem findPathNodeToNode algorithm class type is not a 'SeachAlgorthm'")
				}
			}
			else
			{
				throw new GameError("PathFinderSystem findPathNodeToNode, graph and/or algorithm is not defined.")
			}
			
			trace("No path found from node to node.")
			return null;
		}
	}

}