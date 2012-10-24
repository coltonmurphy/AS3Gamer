
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
	import com.cjm.graph.IGraph;
	import com.cjm.graph.NavGraphEdge;
	import com.cjm.pathfinding.heuristic.EuclidHeuristic;
	import com.cjm.pathfinding.heuristic.IHeuristic;
	import com.cjm.collections.IndexedPriorityQLow;
	
	public class AStar extends GraphSearch
	{

		//a reference to the graph to be searched
		private var _graph:IGraph;

		//indexed into my node. Contains the 'real' accumulative cost to that node
		private var _gCost:Vector.<Number>;

		//indexed into by node. Contains the cost from adding _gCost[n] to
		//the heuristic cost from n to the target node. This is the vector the
		//priority queue indexes into.
		private var _fCost:Vector.<Number>;

		private var _spt:Vector.<GraphEdge>;
		private var _searchFrontier:Vector.<GraphEdge>;

		//the source and target node indices
		private var _start:int
		private var _goal :int;
		private var _heu  :IHeuristic;
		private var _queue:IndexedPriorityQLow;
		
		public static var EuclidHueristic:IHeuristic = new EuclidHeuristic();
		
       
		public function AStar( graph:IGraph, source:int, target:int = -1, h:IHeuristic=AStar.EuclidHueristic, useTicks:Boolean = false, tickAmt:int = -1 )
		{               
			super( useTicks, tickAmt );
			
			_type = "AStar";
			_graph = graph;
			_start = start;
			_goal = target
			_visited =  new Vector<int>
			_route   =  new Vector<int>
			_heu = h;
		
			//A great queue from Matt Buckland.create an indexed priority queue that sorts smallest to largest
		    //(front to back).Note that the maximum number of elements the q
		    //may contain is n. This is because no node can be represented on the 
		    //queue more than once.
		    _queue = new IndexedPriorityQLow(_fCost, _graph.getNumNodes());

            //put the source node on the queue
            _queue.insert(_start);
		}

		//Shortest path tree:
		//returns a vector containing pointers to all the edges the search has examined
		//returns the vector of edges that defines the SPT. If a target was given
	    //in the constructor then this will be an SPT comprising of all the nodes
	    //examined before the target was found, else it will contain all the nodes
	    //in the graph.
	    public function getSPT():Vector.<GraphEdge>
		{
			return _spt;
		}

		//Cycle once 
		//returns an integer representative to search state, respectfully 'solve','unsolved', and
		//'unsolved_complete'
		override public function searchOnce():int
		{
			if ( _queue.isEmpty() )
			{
				 return GraphSearch.UNSOLVED_COMPLETE;
			}
			else
			{
				//get lowest cost node from the queue
				var nextClosest:int = _queue.pop();

				//move this edge from the frontier to the shortest path tree
				_spt[nextClosest] = _searchFrontier[nextClosest];

				//if the target has been found exit
				if ( nextClosest == _goal ) 
					 return GraphSearch.SOLVED;

				//push the edges leading from the node at the end of this edge 
                //onto the queue)
				var edgeIterator:IIterator = graph.getEdgeIterator( next.getTo() );
				while ( edgeIterator.next() )
				{
					var edge:GraphEdge = edgeIterator.current();

				    //calculate the 'real' cost to this node from the start
				    var g:Number = _gCost[nextClosest] + edge.getCost();
					
					//if the node has not been added to the frontier, add it and update
					//the gross, frontier, and heuristic costs accrued thus far
					if ( null == _searchFrontier[edge.getTo()])
					{
						_fCost[edge.getTo()] = g + _heu.calculate(_graph, _goal, edge.getTo());
						_gCost[edge.getTo()] = g;

						_queue.insert(edge.getTo());

						_searchFrontier[edge.getTo()] = edge;
					}

					//if this node is already on the frontier but the cost to get here
					//is less than previous nodes, update it
					//costs and frontier accordingly.
					else if ((g < _gCost[edge.getTo()]) && (null == _spt[edge.getTo()]))
					{
						_fCost[edge.getTo()] = g + _heu.calculate(_graph, _goal, edge.getTo());
						_gCost[edge.getTo()] = g;

						_queue.changePriority(edge.getTo());

						_searchFrontier[edge.getTo()] = edge;
					}
				}
			}
			return GraphSearch.UNSOLVED;
		}

		override public function getPathToTarget():Vector.<int>
		{
		    var path:Vector.<int>;

		    //just return an empty path if no target or no path found
		    if (_goal < 0)  return path;

		    var nd:int = _goal;

		    path.unshift(nd);//push_front

		    while ((nd != _start) && (_spt[nd] != 0))
		    {
			    nd = GraphEdge(_spt[nd]).getFrom();

			    path.unshift(nd);//push_front
		    }

		    return path;
		}
		
		//returns the total cost to the target
		public function getCostToTarget():Number
		{
			return _costs[_goal];
		}

        //returns the total cost to the given node
        public function getCostToNode(nd:int):Number
	    {
		   return _costs[nd];
		}
	}
}