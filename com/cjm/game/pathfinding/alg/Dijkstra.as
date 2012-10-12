
	/**
	 * ...
	 * @author Colton Murphy
	 */

package com.cjm.game.pathfinding.alg 
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
	import com.cjm.game.graph.IGraph;
	import com.cjm.game.graph.NavGraphEdge;
	import com.cjm.game.pathfinding.IPath;
	import com.cjm.game.pathfinding.Path;

	public class Dijkstra extends GraphSearch
	{

		//to aid legibility
		private static const visited:int = 0;
		private static const unvisited:int = 1;
		private static const no_parent_assigned:int = 2;;

		//create a typedef for the edge and node types used by the graph
	  /*typedef typename graph_type::EdgeType Edge;
		typedef typename graph_type::NodeType Node;*/

		//a reference to the graph to be searched
		private var _graph:IGraph;

		//this vector contains the edges that comprise the shortest path tree -
		//a directed subtree of the graph that encapsulates the best paths from 
		//every node on the SPT to the source node.
		private var m_ShortestPathTree:Vector<GraphEdge>;

		//this is indexed into by node index and holds the total cost of the best
	    //path found so far to the given node. For example, _costs[5]
		//will hold the total cost of all the edges that comprise the best path
		//to node 5, found so far in the search (if node 5 is present and has 
		//been visited)
		private var    _costs:Vector<Number> ; 

		//this is an indexed (by node) vector of 'parent' edges leading to nodes 
		//connected to the SPT but that have not been added to the SPT yet. This is
		//a little like the stack or queue used in BST and DST searches.
		private var  m_SearchFrontier:Vector<GraphEdge>;

		//the source and target node indices
		private var _start:int
		private var _goal :int;
		private var _queue:IndexedPriorityQLow;

		public function Dijkstra( graph:IGraph, source:int, target:int = -1, useTicks:Boolean = false, tickAmt:int = -1 )
		{               
		  
			super( useTicks, tickAmt );
			
			_graph = graph;
			_start = start;
			_goal = target
			_visited =  new Vector<int>
			_route   =  new Vector<int>
			
		
			//create an indexed priority queue that sorts smallest to largest
		    //(front to back).Note that the maximum number of elements the iPQ
		    //may contain is N. This is because no node can be represented on the 
		    //queue more than once.
		    _queue = new IndexedPriorityQLow(_costs, _graph.getNumNodes());

            //put the source node on the queue
            pq.insert(_start);

		}


		//returns a vector containing pointers to all the edges the search has examined
		 //returns the vector of edges that defines the SPT. If a target was given
	    //in the constructor then this will be an SPT comprising of all the nodes
	    //examined before the target was found, else it will contain all the nodes
	    //in the graph.
	    std::vector<const Edge*> GetSPT()const{return m_ShortestPathTree;}

	    //returns a vector of node indexes that comprise the shortest path
	    //from the source to the target. It calculates the path by working
	    //backwards through the SPT from the target node.
	    std::list<int> GetPathToTarget()const;

	   //returns the total cost to the target
	   double GetCostToTarget()const{return _costs[m_iTarget];}

	  //returns the total cost to the given node
	  double GetCostToNode(unsigned int nd)const{return _costs[nd];}

		

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
				//get lowest cost node from the queue. Don't forget, the return value
				//is a *node index*, not the node itself. This node is the node not already
				//on the SPT that is the closest to the source node
				var NextClosestNode:int = _queue.pop();

				//move this edge from the frontier to the shortest path tree
				m_ShortestPathTree[NextClosestNode] = m_SearchFrontier[NextClosestNode];

				//if the target has been found exit
				if ( NextClosestNode == _goal ) 
					 return GraphSearch.SOLVED;

	
				//push the edges leading from the node at the end of this edge 
                //onto the queue)
				//graph_type::ConstEdgeIterator ConstEdgeItr(_graph, NextClosestNode);
				var edgeIterator:IIterator = graph.getEdgeIterator( next.getTo() )
				
				/*for (const Edge* edge=ConstEdgeItr.begin();!ConstEdgeItr.end(); edge=ConstEdgeItr.next()){*/
				while ( edgeIterator.next() )
				{
					var edge:GraphEdge = edgeIterator.current();
					
					//the total cost to the node this edge points to is the cost to the
					//current node plus the cost of the edge connecting them.
					var NewCost:Number = _costs[NextClosestNode] + edge.getCost();

					  //if this edge has never been on the frontier make a note of the cost
					  //to get to the node it points to, then add the edge to the frontier
					  //and the destination node to the PQ.
					  if (m_SearchFrontier[edge.getTo()] == 0)
					  {
						_costs[edge.getTo()] = NewCost;

						pq.insert(edge.getTo());

						m_SearchFrontier[edge.getTo()] = edge;
					  }

					  //else test to see if the cost to reach the destination node via the
					  //current node is cheaper than the cheapest cost found so far. If
					  //this path is cheaper, we assign the new cost to the destination
					  //node, update its entry in the PQ to reflect the change and add the
					  //edge to the frontier
					  else if ( (NewCost < _costs[edge.getTo()]) &&
								(m_ShortestPathTree[edge.getTo()] == 0) )
					  {
						_costs[edge.getTo()] = NewCost;

						//because the cost is less than it was previously, the PQ must be
						//re-sorted to account for this.
						_queue.changePriority(edge.getTo());

						m_SearchFrontier[edge.getTo()] = edge;
					  }

				}
			}

			return GraphSearch.UNSOLVED;
		}

		public function getPathToTarget():Vector.<int>
		{
		    var path:Vector.<int>;

		    //just return an empty path if no target or no path found
		    if (_goal < 0)  return path;

		    var nd:int = _goal;

		    path.unshift(nd);//push_front

		    while ((nd != _start) && (m_ShortestPathTree[nd] != 0))
		    {
			    nd = m_ShortestPathTree[nd]->From();

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
        public function  getCostToNode(nd:int):Number
	    {
		   return _costs[nd];
		}
	}
}