package com.cjm.game.graph 
{
	import com.cjm.collections.iterators.IIterator;
	import com.cjm.collections.iterators.Iterator;
	import com.cjm.game.pathfinding.Edge;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class SparseGraph implements IGraph 
	{
		private static const INVALID_NODE_INDEX:Number = -1;
		
		//the nodes that comprise this graph
		private var _nodes:Vector.<INode>;

		//a vector of adjacency edge lists. (each node index keys into the 
		//list of edges associated with that node)
		private var _edges:Vector.<Vector.<IEdge>>;//2D and indexed by node index
		 
		//is this a directed graph?
		private var _isDigraph:Boolean;

		//the index of the next node to be added
		private var _nextNodeIndex:int;
  
		public function SparseGraph( digraph:Boolean ) 
		{
			_isDigraph = digraph;
			_nextNodeIndex = 0;
			_nodes = new Vector.<INode>;
			_edgeLists = new Vector.< Vector.<IEdge> >
		} 
		
		/* INTERFACE com.cjm.game.graph.IGraph */
		
		public function getEdgeIterator( index:int):EdgeIterator 
		{
			return new EdgeIterator( index < getNumNodes() ? _edgeLists[ index ] : new Vector.<IEdge> );
		}
		
		public function getNodeIterator():NodeIterator 
		{
			return new NodeIterator( _nodes );
		}

		public function getNode(idx:int):INode 
		{
			return _nodes[idx]
		}

		public function getEdge(from:int, to:int):IEdge 
		{
			var edgeIt:IIterator = getEdgeIterator( from );
			
			while ( edgeIt.next() )
			{
				var c:IEdge = edgeIt.current() as IEdge;
				
				if ( c.getTo() == to )  return c;
			}
			
		    /*for (EdgeList::const_iterator curEdge = _edgeLists[from].begin();
			   curEdge != _edgeLists[from].end();
			   ++curEdge)
		    {
				if (curEdge->To() == to) return *curEdge;
		    }*/
			
			return null;
		}
		
		public function getNextFreeNodeIndex():int 
		{
			return _nextNodeIndex
		}
		
		public function addNode(node:INode):int 
		{
			//make sure both nodes are active before adding the edge
			if ( node.getIndex() < _nodes.length )
			{
				_nodes[node.getIndex()] = node;

				return _nextNodeIndex;
			}
			  
		    else
			{
				_nodes.push( node);
				_edgeLists.push( new Vector.<IEdge> );

				return _nextNodeIndex++;
			}
		}
		
		public function removeNode(index:int):int 
		{
			//set this node's index to INVALID_NODE_INDEX
		    _nodes[index].setIndex(INVALID_NODE_INDEX);

		    //if the graph is not directed remove all edges leading to this node and then
		    //clear the edges leading from the node
		    if (!_isDigraph)
		    {    
			    //visit each neighbour and erase any edges leading to this node
			
				var edgeItI:EdgeIterator = getEdgeIterator( index );
				while ( edgeItI.next() )
				{ 
				    var edgeItJ:EdgeIterator = getEdgeIterator( edgeItI.current().getTo() );

					while ( edgeItJ.next() )
					{
					    if (edgeItJ.current().getTo() == index)
						{
							 var list:Vector.<IEdge> = _edgeLists[edgeItJ.current().getTo()]
						     //curE = _edgeLists[curEdge->To()].erase(curE);
							 list.splice( edgeItJ.index, 1)
						     break;
						}
					}
				}

				//finally, clear this node's edges
				_edgeLists[index] = new Vector.<IEdge>;
			}

			//if a digraph remove the edges the slow way
			else
			{
				cullInvalidEdges();
		    }
		}
		
		public function addEdge(edge:GraphEdge) 
		{
			var validEdge:Boolean = (_nodes[edge.getTo()].getIndex() != SparseGraph.INVALID_NODE_INDEX) && 
			                      (_nodes[edge.getFrom()].getIndex() != SparseGraph.INVALID_NODE_INDEX)
			if ( validEdge )
		    {
				//add the edge, first making sure it is unique
				if ( isUniqueEdge(edge.getFrom(), edge.getTo()) )
				{
				    _edgeLists[edge.getFrom()].push(edge);//push_back
				}

				//if the graph is undirected we must add another connection in the opposite
				//direction
				if ( !_isDigraph )
				{
				    //check to make sure the edge is unique before adding
				    if ( isUniqueEdge(edge.getTo(), edge.getFrom()) )
				    {
						var newEdge = new GraphEdge(edge.getTo(), edge.getFrom(), edge.getCost() )

						_edgeLists[edge.getTo()].push(newEdge);
				    }
				}
			}
		}
		
		public function removeEdge(from:int, to:int):void 
		{
			var edgeItFrom:EdgeIterator = getEdgeIterator( from );
			var edgeItTo:EdgeIterator   = getEdgeIterator( to );
			
		    if (!_isDigraph)
		    {
				while ( edgeItTo.next() )
				{
					var c:IEdge             = edgeItTo.current();//
					var list:Vector.<IEdge> = _edgeLists[to];
					
				    if ( c.getTo() == from )
				    {
						list.splice( edgeItTo.index, 1 ); //TODO:verify we are removing correct index
						break;
					}
				}
		    }

		  
			while( edgeItFrom.next() )
			{
				var c:IEdge = edgeItFrom.current();
				var list:Vector.<IEdge>  = _edgeLists[from];
				if ( c.getTo() == to)
				{
					list.splice( edgeItFrom.index, 1 )//TODO:verify we are removing correct index
					break;
				}
		    }
		}
		
		public function setEdgeCost(from:int, to:int, cost:Number):void 
		{
			//visit each neighbour and erase any edges leading to this node
		    var it:EdgeIterator = getEdgeIterator( from );
			while ( it.next() )
			{
				var e:IEdge = it.current() as IEdge;
				
				if ( e.getTo() == to)
				{
				    e.setCost( cost );
				    break;
				}
			}
			
			/*for ( var curEdge = _edgeLists[from].begin(); 
			   curEdge != _edgeLists[from].end();
			   curEdge.next; curEdge )
			{
				if (curEdge->To() == to)
				{
				    curEdge->SetCost(NewCost);
				     break;
				}
			}*/
		}
		
		public function getNumNodes():int 
		{
			return _nodes.length;
		}
		
		public function getNumActiveNodes():int 
		{
			var count:int = 0;

			for ( var n:int = 0; n < _nodes.length; ++n) 
				if (INode(_nodes[n]).getIndex() != SparseGraph.INVALID_NODE_INDEX) 
				++count;

			return count;
		}
		
		public function getNumEdges():int 
		{
			var tot:int = 0;

			for ( var i = 0; i < _edgeLists.length; i++ )
			{
			    tot += _edgeLists[i].length;
			}

			return tot;
		}
		
		public function isDigraph():Boolean 
		{
			return _isDigraph
		}
		
		public function isEmpty():Boolean 
		{
			_nodes.length == 0;
		}
		
		public function isNodePresent(nd:int):Boolean 
		{
			if ((nd >= _nodes.length || 
			    (INode(_nodes[nd]).getIndex() == SparseGraph.INVALID_NODE_INDEX)))
			{
			  return false;
			}
		    return true;
		}
		
		public function isEdgePresent(from:int, to:int):Boolean 
		{
			if (isNodePresent(from) && isNodePresent(from))
			{
				var it:EdgeIterator = getEdgeIterator( from )//_edgeLists[from].begin();
			
				while( it.next() )
			    {
				    if (IEdge(it.current()).getTo() == to) 
						return true;
				}
				
				
			}
			
			return false;
		}

		public function clear():void 
		{
			_nodes     = new Vector.<INode>;
			_edgeLists = new Vector.<Vector.<IEdge>>
		}
		
		public function removeEdges():void 
		{
			for ( var i = 0; i < _edgeLists.length; i++ )
			{
				_edgeLists[i] = new Vector.<IEdge>;
			}
		}
		
		//returns true if an edge is not already present in the graph. Used
		//when adding edges to make sure no duplicates are created.
		private function isUniqueEdge( from:int,  to:int):Boolean
		{
			var edgeIt:EdgeIterator = getEdgeIterator( from );
			
			while ( edgeIt.next() )
			{
				if (IEdge(edgeIt.current()).getTo() == to)
				{
				    return false;
				}
			}

			return true;
		};

		//iterates through all the edges in the graph and removes any that point
		//to an invalidated node
		private function cullInvalidEdges():void
		{
			for ( var i:int = 0; i < _edgeLists.length; i++  )
			{
				var curEdgeList:Vector.<IEdge> = _edgeLists[i] as EdgeList;
				
				for (var j:int = 0; j < curEdgeList.length; j++ )
				{
					var edge:IEdge = curEdgeList[j];
					var toInvalid:Boolean   = _nodes[edge.getTo()  ].getIndex() == SparseGraph.INVALID_NODE_INDEX
				    var fromInvalid:Boolean = _nodes[edge.getFrom()].getIndex() == SparseGraph.INVALID_NODE_INDEX
				    
					if ( toInvalid || fromInvalid )
				    {
						 curEdgeList.splice(j, 1);
						 j--
				    }
				}
				
				//TODO: remove edge list from _edgeLists is current list size is zero
			}
		};	
	}
	
	
	internal class NodeIterator extends Iterator
	{
		
	    //if a graph node is removed, it is not removed from the 
        //vector of nodes (because that would mean changing all the indices of 
        //all the nodes that have a higher index). This method takes a node
        //iterator as a parameter and assigns the next valid element to it.
	    //Skips to next viable node location
        private function getNextValidNode( n:INode ):void
        { 
			var inval  = SparseGraph.INVALID_NODE_INDEX;
			var valid  = n.getIndex() != inval;
		
			if ( valid ) return;
				
			while ( !valid  )
			{
				next();//updates current()
				
				valid  = current().getIndex() != invalid;
			}
        }

        override public function next():Boolean
        {
			var validStep:Boolean = super.next();//index increment

			if( validStep )
			    getNextValidNode( current() as INode );

			return validStep;
        }  
    }
	
	internal class EdgeIterator extends Iterator{	}
	}
}