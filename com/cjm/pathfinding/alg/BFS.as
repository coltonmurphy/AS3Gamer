
	/**
	 * ...
	 * @author Colton Murphy
	 */

package com.cjm.pathfinding.alg 
{
	import com.cjm.collections.IQueue;
	import com.cjm.collections.IStack;
	import com.cjm.collections.iterators.IIterator;
	import com.cjm.collections.List;
	import com.cjm.collections.Queue;
	import com.cjm.collections.Stack;
	import com.cjm.graph.EdgeIterator;
	import com.cjm.graph.GraphEdge;
	import com.cjm.graph.IEdge;



	public class BFS extends GraphSearch
	{
		private static const VISITED:int = 0;
		private static const UNVISITED:int = 1;
		
	

		//this records the indexes of all the nodes that are VISITED as the
		//search progresses
		private var  _visited:Vector.<int>;

		//this holds the route taken to the target. Given a node index, the value
		//at that index is the node's parent. ie if the path to the target is
		//3-8-27, then _route[8] will hold 3 and _route[27] will hold 8.
		private var  _route:Vector.<int>;
		  
		//As the search progresses, this will hold all the edges the algorithm has
		//examined. THIS IS NOT NECESSARY FOR THE SEARCH, IT IS HERE PURELY
		//TO PROVIDE THE USER WITH SOME VISUAL FEEDBACK
		private var _spanningTree:Vector.<IEdge>;
		private var _queue:Array;

		public function BFS( graph:IGraph, source:int, target:int = -1, useTicks:Boolean = false, tickAmt:int = -1 )
		{               
			super( graph, source, target, useTicks, tickAmt );
		
			_type = "BFS";
			_visited =  new Vector<int>
			_route   =  new Vector<int>
		    _spanningTree = new Vector.<IEdge>
			
			//create a dummy edge and put on the stack
			var dummy:GraphEdge = new GraphEdge(_start, _start, 0);
		  
			_queue = new Array();
			_queue.push( dummy );
	
			_visited[_start] = VISITED;
		}


		//returns a vector containing pointers to all the edges the search has examined
		public function getSearchTree() Vector.<GraphEdge>
		{
			return _spanningTree;
		}
		

		override public function searchOnce():int
		{
			if ( _queue.isEmpty() )
			{
				 return GraphSearch.UNSOLVED_COMPLETE;
			}
			else
			{
				var next:GraphEdge = _queue[0]//TODO: use front() if use Queue object
			
				_queue.pop();
				
				//make a note of the parent of the node this edge points to
				_route[ next.getTo() ] = next.getFrom();

				//put it on the tree. (making sure the dummy edge is not placed on the tree)
				if ( !next.equals( dummy ) )
				{
					_spanningTree.push( next );//push_back
				}
			   
				//NOTE: this is difference between BFS and DFS
				//_visited[ next.getTo()] = VISITED;// DFS
				
				//if the target has been found the method can return success
				if ( next.getTo() == _goal )
				{
					return GraphSearch.SOLVED;
				}
	
				//push the edges leading from the node at the end of this edge 
                //onto the queue)
				//graph_type::ConstEdgeIterator ConstEdgeItr(_graph, next.getTo());
				var edgeIterator:IIterator = graph.getEdgeIterator( next.getTo() )
				
				/*for (const Edge* pE=ConstEdgeItr.begin();!ConstEdgeItr.end(); pE=ConstEdgeItr.next()){*/
				while ( edgeIterator.next() )
				{
					var edge:GraphEdge = edgeIterator.current();
					
					if ( _visited[edge.getTo()] == UNVISITED)
					{
						_queue.push( edge );
						
						//NOTE: this is difference between BFS and DFS
						_visited[ edge.getTo()] = VISITED;//BFS
					}
				}
			}

			return GraphSearch.UNSOLVED;
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
		
	}
}