

package com.cjm.graph
{

	import com.cjm.collections.iterators.IIterator;
	import com.cjm.graph.GraphEdge;
	import com.cjm.graph.IEdge;
	import com.cjm.graph.IGraph;
	import com.cjm.graph.INode;
	import com.cjm.pathfinding.alg.Dijkstra;
	import com.cjm.math.geom.Vector2D;
	import com.cjm.pathfinding.alg.GraphSearch;
	import com.cjm.utils.VectorUtil;
	
	public class GraphHelper
	{
		//--------------------------- Valid Neighbour ----------------------------
		//
		//  returns true if x,y is a valid position in the map
		//------------------------------------------------------------------------
		public static function isValidNeighbour( x:int,  y:int,  cellsX:int, cellsY:int):Boolean
		{
		  return !((x < 0) || (x >= cellsX) || (y < 0) || (y >= cellsY));
		}
		  
		//----------------------Add All Neighbours ToGrid Node ------------------
		//
		//  use to add he eight neighboring edges of a graph node that 
		//  is positioned in a grid layout
		//------------------------------------------------------------------------

		public static function addAllNeighboursToGridNode(graph:IGraph, row:int, col:int, cellsByX:int,  cellsByY:int)
		{   
			var i:int = -1; var j:int = -1;
			
			for ( i; i<2; ++i )
		    {
			    for ( j; j<2; ++j )
				{
				    var nodeX:int= col+j;
				    var nodeY:int = row+i;

				    //skip if equal to this node
				    if ( (i == 0) && (j==0) ) continue;
				
				    //check to see if this is a valid neighbour
				    if (isValidNeighbour(nodeX, nodeY, cellsByX, cellsByY))
				    {
						//calculate the distance to this node
						var xIndex:int = row   * cellsByX + col;
						var yIndex:int = nodeY * cellsByX + nodeX;
						
						var posNode:Vector2D        = graph.getNode(xIndex).getPosition();
						var posNeighbour:Vector2D   = graph.getNode(yIndex).getPosition();

						//this neighbour is okay so it can be added
						var newEdge:GraphEdge = new GraphEdge( xIndex, yIndex, Vector2D.Vec2DDistance( posNode, posNeighbour ) );
						graph.addEdge( newEdge );
						
						//if graph is not a diagraph then an edge needs to be added going
						//in the other direction
						if (!graph.isDigraph())
						{
							newEdge = new GraphEdge( yIndex, xIndex, newEdge.getCost() );
							graph.addEdge( newEdge );
						}
				    }
				}
		    }
		}


		//--------------------------- Create Grid ------------------------------------
		//
		//  creates a graph based on a grid layout. This function requires the 
		//  dimensions of the environment and the number of cells required horizontally
		//  and vertically 
		//-----------------------------------------------------------------------------
	
		public static function createGrid( graph:IGraph,
									       cySize:int,
									       cxSize:int,
									       numCellsY:int,
									       numCellsX:int )
		{ 
	
		    var cellWidth  = Number(cySize) / Number(numCellsX);
		    var cellHeight = Number(cxSize) / Number(numCellsY);

		    var midX = cellWidth/2;
		    var midY = cellHeight/2;

			//first create all the nodes
		    for (var row:int = 0; row < numCellsY ; ++row)
		    {
			    for ( var col:int = 0; col < numCellsX; ++col )
			    {
					var position:Vector2D = new Vector2D(midX + (col*cellWidth),midY + (row*cellHeight))
					var index:int         = graph.getNextFreeNodeIndex();
					var node:GraphNode    = new GraphNode( index, position );
					graph.addNode( node );
			    }
		    }
			
			//now to calculate the edges. (A position in a 2d array [x][y] is the
			//same as [y*NumCellsX + x] in a 1d array). Each cell has up to eight
			//neighbours.
			for ( row=0; row<numCellsY; ++row)
			{
				for ( col=0; col<numCellsX; ++col)
				{
					addAllNeighboursToGridNode(graph, row, col, numCellsX, numCellsY);
				}
			}
		}  


		//--------------------------- Weight Graph Node Edges -------------------
		//
		//  Given a cost value and an index to a valid node this function examines 
		//  all a node's edges, calculates their length, and multiplies
		//  the value with the weight. Useful for setting terrain costs.
		//------------------------------------------------------------------------
		public static  function weightGraphNodeEdges( graph:IGraph, node:int, weight:Number = 1)
		{
		  //make sure the node is present
	
		  //set the cost for each edge
		  var edgeIt:IIterator = graph.getEdgeIterator( node );
		  while( edgeIt.next() )
		  {
				var pE:IEdge = edgeIt.current() as IEdge;
			  
				//calculate the distance between nodes
				var dist:Number = Vector2D.Vec2DDistance( graph.getNode( pE.getFrom() ).getPosition(),
									   graph.getNode(pE.getTo()).getPosition());

				//set the cost of this edge
				graph.setEdgeCost(pE.getFrom(), pE.getTo(), dist * weight);

				//if not a digraph, set the cost of the parallel edge to be the same
				if ( !graph.isDigraph()) 
				{      
					graph.setEdgeCost(pE.getTo(), pE.getFrom(), dist * weight);
				}
			}
		}


		//----------------------- Create All Pairs able ------------------------------
		//
		// creates a lookup table encoding the shortest path info between each node
		// in a graph to every other
		//-----------------------------------------------------------------------------
		public static function createAllPairsTable( g:IGraph):Vector.<Vector.<int> > 
		{
		    var no_path:int = -1;
		  
		    var row:Vector.<int> = new Vector.<int>(g.getNumNodes(), true);
		    row = VectorUtil.assign( row, no_path );
		  
		    var shortestPaths:Vector.<Vector.<int> >  = new Vector.<Vector.<int>>(g.getNumNodes(), true);
            VectorUtil.assign( shortestPaths, row);
		  
		    for (var source:int=0; source<g.getNumNodes(); ++source)
		    {
		
			    var graph:Dijkstra = new Dijkstra(g, source);
                graph.search();
			
			    //Shortest path tree
			    var spt:Vector.<IEdge> = graph.getSPT();

			    //now we have the SPT it's easy to work backwards through it to find
			    //the shortest paths from each node to this source node
			    for (var target:int = 0; target<g.getNumNodes(); ++target)
			    {
			        //if the source node is the same as the target just set to target
				    if ( source == target )
				    {
					    shortestPaths[source][target] = target;
				    }
				    else
				    {
						var nd:int = target;

						while ((nd != source) && (spt[nd] != 0))
						{
						  shortestPaths[spt[nd].getFrom()][target]= nd;

						  nd = spt[nd].getFrom();
						}
				    }
			    }
		    }
			
		    return shortestPaths;
		}

	
		//----------------------- Create All Pairs Costs Table ------------------------
		//
		//  creates a lookup table of the cost associated from traveling from one
		//  node to every other
		//-----------------------------------------------------------------------------
		public static function createAllPairsCostsTable( g:IGraph ) : Vector.< Vector.<Number > > 
		{
		    var row:Vector.<Number> = new Vector.<Number> (g.getNumNodes(), true);
			VectorUtil.assign( row, 0 );
			
			//create a two dimensional vector
		    var pathCosts:Vector.<Vector.<Number> > = new Vector.<Vector.<Number> >(g.getNumNodes(),true);
            VectorUtil.assign( pathCosts, row );
			
		    for (var source:int =0; source<g.getNumNodes(); ++source)
		    {
				//do the search
				var search:Dijkstra = new Dijkstra( g, source );

				//assign cost from source to target in 2d vector
				for (var target:int = 0; target<g.getNumNodes(); ++target)
				{
					if ( source != target )
					{
						pathCosts[source][target] = search.getCostToNode(target);
					}
			    }
				
			 }

		  return pathCosts;
		}

		//---------------------- Calculate Average Graph Edge Length ------------------
		//
		//  Euclidean:determines the average length of the edges in a navgraph (using the 
		//  distance between the source & target node positions (not the cost of the 
		//  edge as represented in the graph, which may account for all sorts of 
		//  other factors such as terrain type, gradients etc)
		//------------------------------------------------------------------------------	
		public function calculateAverageGraphEdgeLength( g:IGraph ):Number
		{
			var totalLength:Number        = 0;
		    var numEdgesCounted:Number    = 0;
		    var nodeItr:IIterator = g.getNodeIterator();
		    while ( nodeItr.next() )
		    {
			    var n:INode = nodeItr.current() as INode;
			    var edgeItr:IIterator = g.getEdgeIterator( n.getIndex() );
				
			    while( edgeItr.next() )
			    { 
					var e:IEdge = nodeItr.current() as IEdge;
				    
					//add length of edge to total length
					var locA:Vector2D = g.getNode(e.getFrom()).getPosition();
					var locB:Vector2D = g.getNode(e.getTo()).getPosition();
					totalLength += Vector2D.Vec2DDistance( locA, locB );
					++numEdgesCounted;
			    }
		    }
		  
		  return totalLength / numEdgesCounted;
		}

		//----------------------------- GetCostliestGraphEdge -------------------
		//
		//  returns the cost of the costliest edge in the graph
		//-----------------------------------------------------------------------------
		public function  getCostliestGraphEdge( g:IGraph ):Number
		{
		  var greatest:Number = Number.MIN_VALUE;
		  var nodeItr:IIterator = g.getNodeIterator();
		  while ( nodeItr.next() )
		  {
			    var pN:INode = nodeItr.current() as INode;
			  
			    var edgeItr:IIterator = g.getEdgeIterator( pN.getIndex() );
			    while( edgeItr.next() )
			    { 
				    var e:IEdge = edgeItr.current() as IEdge;
					
				    if ( e.getCost() > greatest)
					     greatest = e.getCost();
			  }
		  }
		  return greatest;
		}
	}	
}




