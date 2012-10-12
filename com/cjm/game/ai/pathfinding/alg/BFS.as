
	/**
	 * ...
	 * @author Colton Murphy
	 */

package com.cjm.game.ai.pathfinding.alg 
{
	import adobe.utils.CustomActions;
	import com.cjm.collections.IQueue;
	import com.cjm.collections.IStack;
	import com.cjm.collections.iterators.IIterator;
	import com.cjm.collections.List;
	import com.cjm.collections.Queue;
	import com.cjm.collections.Stack;
	import com.cjm.game.graph.EdgeIterator;
	import com.cjm.game.graph.GraphEdge;
	import com.cjm.game.graph.NavGraphEdge;
	import com.cjm.game.ai.pathfinding.IPath;
	import com.cjm.game.ai.pathfinding.Path;

	public class BFS extends GraphSearch
	{

		//to aid legibility
		private static const visited:int = 0;
		private static const unvisited:int = 1;
		private static const no_parent_assigned:int = 2;;

		//create a typedef for the edge and node types used by the graph
	  /*typedef typename graph_type::EdgeType Edge;
		typedef typename graph_type::NodeType Node;*/

		//a reference to the graph to be searched
		private var _graph;

		//this records the indexes of all the nodes that are visited as the
		//search progresses
		private var  _visited:Vector.<int>;

		//this holds the route taken to the target. Given a node index, the value
		//at that index is the node's parent. ie if the path to the target is
		//3-8-27, then _route[8] will hold 3 and _route[27] will hold 8.
		private var  _route:Vector.<int>;
		  
		//As the search progresses, this will hold all the edges the algorithm has
		//examined. THIS IS NOT NECESSARY FOR THE SEARCH, IT IS HERE PURELY
		//TO PROVIDE THE USER WITH SOME VISUAL FEEDBACK
		private var  _spanningTree:Vector.<GraphEdge>;

		//the source and target node indices
		private var _start:int
		private var _goal :int;
		private var _queue :Array;

		public function BFS( graph:IGraph, source:int, target:int = -1, useTicks:Boolean = false, tickAmt:int = -1 )
		{               
		  
			super( useTicks, tickAmt );
			
			_graph = graph;
			_start = start;
			_goal = target
			_visited =  new Vector<int>
			_route   =  new Vector<int>
			//create a std stack of edges
			//std::stack<const Edge*> stack;

			//create a dummy edge and put on the stack
			var dummy:GraphEdge = new GraphEdge(_start, _start, 0);
		  
			_queue = new Array();
			_queue.push( dummy );
	
			_visited[_start] = visited;
		}


		//returns a vector containing pointers to all the edges the search has examined
		public function getSearchTree() Vector.<GraphEdge>
		{
			return _spanningTree;
		}
		

		override public function searchOnce():int
		{
			//grab the next edge from top
			//const Edge* Next = stack.top();//TODO: verify

			//remove the edge from the stack
			//stack.pop();

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
				//_visited[ next.getTo()] = visited;// DFS
				
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
					
					if ( _visited[edge.getTo()] == unvisited)
					{
						_queue.push( edge );
						
						//NOTE: this is difference between BFS and DFS
						_visited[ edge.getTo()] = visited;//BFS
					}
				}
			}

			return GraphSearch.UNSOLVED;
		}


		
	}
}