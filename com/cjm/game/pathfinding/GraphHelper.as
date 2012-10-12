
//-----------------------------------------------------------------------------
//
//  Name:   HandyGraphFunctions.h
//
//  Author: Mat Buckland (www.ai-junkie.com)
//
//  Desc:   As the name implies, some useful functions you can use with your
//          graphs. 

//          For the function templates, make sure your graph interface complies
//          with the SparseGraph class
//-----------------------------------------------------------------------------
/*#include <iostream>

#include "misc/Cgdi.h"
#include "misc/utils.h"
#include "misc/Stream_Utility_Functions.h"
#include "Graph/GraphAlgorithms.h"
#include "Graph/AStarHeuristicPolicies.h"*/

package com.cjm.game.pathfinding
{
	import com.cjm.game.ai.behaviors.steering.Interpose;
	import com.cjm.game.graph.EdgeIterator;
	import com.cjm.game.graph.GraphEdge;
	import com.cjm.game.graph.IEdge;
	import com.cjm.game.graph.IGraph;
	import com.cjm.game.graph.INode;
	import com.cjm.game.graph.NavGraphNode;
	import com.cjm.game.pathfinding.alg.Dijkstra;
	import com.cjm.game.pathfinding.alg.Dykstra;
	import com.cjm.game.pathfinding.Edge;
	import com.cjm.math.geom.Vector2D;
	public class GraphHelper
	{
		//--------------------------- ValidNeighbour -----------------------------
		//
		//  returns true if x,y is a valid position in the map
		//------------------------------------------------------------------------
		public static function ValidNeighbour(int x, int y, int NumCellsX, int NumCellsY):Boolean
		{
		  return !((x < 0) || (x >= NumCellsX) || (y < 0) || (y >= NumCellsY));
		}
		  
		//------------ GraphHelper_AddAllNeighboursToGridNode ------------------
		//
		//  use to add he eight neighboring edges of a graph node that 
		//  is positioned in a grid layout
		//------------------------------------------------------------------------
		//template <class graph_type>
		static public function AddAllNeighboursToGridNode(graph:IGraph,row:int, col:int, NumCellsX:int,  NumCellsY:int)
		{   
			for ( var i:int =-1; i<2; ++i)
		    {
			    for var j:int =-1; j<2; ++j)
				{
				   var nodeX:int= col+j;
				   var nodeY:int = row+i;

				  //skip if equal to this node
				  if ( (i == 0) && (j==0) ) continue;
				
				  //check to see if this is a valid neighbour
				  if (validNeighbour(nodeX, nodeY, NumCellsX, NumCellsY))
				  {
					//calculate the distance to this node
					var posNode:Vector2D        = graph.getNode(row*NumCellsX+col).getPosition();
					var posNeighbour:Vector2D   = graph.getNode(nodeY*NumCellsX+nodeX).getPosition();

					var dist:Number = posNode.getDistance( posNeighbour );

					//this neighbour is okay so it can be added
					
					//TODO: create edges
					/*graph_type::EdgeType NewEdge(row*NumCellsX+col,
												 nodeY*NumCellsX+nodeX,
												 dist);*/
				    var newEdge:Edge = new Edge( posNode, posNeighbour, dist );
					graph.addEdge( newEdge );
					
					//if graph is not a diagraph then an edge needs to be added going
					//in the other direction
					if (!graph.isDigraph())
					{
					  /*graph_type::EdgeType NewEdge(nodeY*NumCellsX+nodeX,
												   row*NumCellsX+col,
												   dist);*/
						
						newEdge = new Edge( posNeighbour,posNode, dist );
						graph.addEdge( newEdge );
					}
				  }
				}
		  }
		}


		//--------------------------- GraphHelper_CreateGrid --------------------------
		//
		//  creates a graph based on a grid layout. This function requires the 
		//  dimensions of the environment and the number of cells required horizontally
		//  and vertically 
		//-----------------------------------------------------------------------------
		//template <class graph_type>
		static public function CreateGrid( graph:IGraph,
									       cySize:int,
									       cxSize:int,
									       numCellsY:int,
									       numCellsX:int )
		{ 
		    //need some temporaries to help calculate each node center
		    //TODO: 
		    var cellWidth  = Number(cySize) / Number(numCellsX);
		    var cellHeight = Number(cxSize) / Number(numCellsY);

		    var midX = cellWidth/2;
		    var midY = cellHeight/2;

			//first create all the nodes
		    for (var row:int = 0; row < numCellsY ; ++ro w)
		    {
			    for ( var col:int = 0; col < numCellsX; ++col )
			    {
					var position:Vector2D = new Vector2D(midX + (col*CellWidth),midY + (row*CellHeight))
					var index:Interpose   = graph.getNextFreeNodeIndex();
					var node:NavGraphNode = new NavGraphNode( index, position );
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
					AddAllNeighboursToGridNode(graph, row, col, numCellsX, numCellsY);
				}
			}
		}  


		//--------------------------- WeightNavGraphNodeEdges -------------------------
		//
		//  Given a cost value and an index to a valid node this function examines 
		//  all a node's edges, calculates their length, and multiplies
		//  the value with the weight. Useful for setting terrain costs.
		//------------------------------------------------------------------------
		//template <class graph_type>
		static public function WeightNavGraphNodeEdges( graph:IGraph, node:int, weight:Number)
		{
		  //make sure the node is present
		  //assert(node < graph.NumNodes());

		  //set the cost for each edge
		  //graph_type::ConstEdgeIterator ConstEdgeItr(graph, node);
		  var edgeIt:EdgeIterator = graph.getEdgeIterator( node );
		  //for ( var pE:IEdge = edgeIt.begin(); !edgeIt.end(); pE=edgeIt.next())
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


		//----------------------- CreateAllPairsTable ---------------------------------
		//
		// creates a lookup table encoding the shortest path info between each node
		// in a graph to every other
		//-----------------------------------------------------------------------------
		//template <class graph_type>
		static public function CreateAllPairsTable( G:IGraph):Vector<Vector<int> >
		{
		  var no_path = -1;
		  
		  std::vector<int> row(G.NumNodes(), no_path);
		  
		  std::vector<std::vector<int> > ShortestPaths(G.NumNodes(), row);

		  for (var source:int=0; source<G.getNumNodes(); ++source)
		  {
			//calculate the SPT for this node
			//TODO:Dijkstra search
			//Graph_SearchDijkstra<graph_type> search(G, source);

			std::vector<const graph_type::EdgeType*> spt = search.getSPT();

			//now we have the SPT it's easy to work backwards through it to find
			//the shortest paths from each node to this source node
			for (int target = 0; target<G.NumNodes(); ++target)
			{
			  //if the source node is the same as the target just set to target
			  if (source == target)
			  {
				ShortestPaths[source][target] = target;
			  }

			  else
			  {
				int nd = target;

				while ((nd != source) && (spt[nd] != 0))
				{
				  ShortestPaths[spt[nd]->From][target]= nd;

				  nd = spt[nd]->From;
				}
			  }
			}//next target node
		  }//next source node

		  return ShortestPaths;
		}


		//----------------------- CreateAllPairsCostsTable -------------------------------
		//
		//  creates a lookup table of the cost associated from traveling from one
		//  node to every other
		//-----------------------------------------------------------------------------
		/*template <class graph_type>*/
		public static function CreateAllPairsCostsTable( G:IGraph ) : Vector< Vector<Number > > 
		{
		    //create a two dimensional vector
		    var row:Vector.<Number>               = new Vector.<Number> (G.NumNodes(), 0.0);
		    var PathCosts:Vector<Vector<Number> > = new Vector<Vector<Number> >(G.NumNodes(), row);

		    for (int source=0; source<G.getNumNodes(); ++source)
		    {
				//do the search
				var searchInstance:Dijkstra = new Dykstra(G, start, null)//No target? TODO: update to optional parameter search(G, source);

				//iterate through every node in the graph and grab the cost to travel to
				//that node
				for (int target = 0; target<G.getNumNodes(); ++target)
				{
					if ( source != target )
					{
						PathCosts[source][target]= search.getCostToNode(target);
					}
			    }//next target node
				
			 }//next source node

		  return PathCosts;
		}

		//---------------------- CalculateAverageGraphEdgeLength ----------------------
		//
		//  determines the average length of the edges in a navgraph (using the 
		//  distance between the source & target node positions (not the cost of the 
		//  edge as represented in the graph, which may account for all sorts of 
		//  other factors such as terrain type, gradients etc)
		//------------------------------------------------------------------------------
		/*template <class graph_type>*/
		public function calculateAverageGraphEdgeLength( g:IGraph/*const graph_type& G*/)
		{
			var totalLength:Number        = 0;
		    var numEdgesCounted:Number    = 0;

		 /* graph_type::ConstNodeIterator NodeItr(G);
		    const graph_type::NodeType* pN;
		    for (pN = NodeItr.begin(); !NodeItr.end(); pN=NodeItr.next())
		    {
			    graph_type::ConstEdgeIterator EdgeItr(G, pN->Index());
			    for (const graph_type::EdgeType* pE = EdgeItr.begin(); !EdgeItr.end(); pE=EdgeItr.next())
			    {
			        //increment edge counter
			        ++NumEdgesCounted;

			        //add length of edge to total length
			        TotalLength += Vec2DDistance(G.GetNode(pE->From()).Pos(), G.GetNode(pE->To()).Pos());
				}
			}*/

		    var nodeItr:IIterator = g.getNodeIterator();
		    while ( nodeItr.next() )
		    {
			    var pN = nodeItr.current();
			    var edgeItr:IIterator = g.getEdgeIterator( nodeItr.cursor );
				
			    while( edgeItr.next() )
			    { 
				    ++numEdgesCounted;

					//add length of edge to total length
					totalLength += Vector2D.Vec2DDistance( g.getNode(pE.getFrom()).getPosition(), 
														   g.getNode(pE.getTo()).getPosition());
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

		  /*graph_type::ConstNodeIterator NodeItr(G);
		  const graph_type::NodeType* pN;
		  for (pN = NodeItr.begin(); !NodeItr.end(); pN=NodeItr.next())
		  {
			graph_type::ConstEdgeIterator EdgeItr(G, pN->Index());
			for (const graph_type::EdgeType* pE = EdgeItr.begin(); !EdgeItr.end(); pE=EdgeItr.next())
			{
			  if (pE->Cost() > greatest)greatest = pE->Cost();
			}
		  }*/

		  var nodeItr:IIterator = g.getNodeIterator();
		  while ( nodeItr.next() )
		  {
			    var pN:INode = nodeItr.current() as INode;
			  
			    var edgeItr:IIterator = g.getEdgeIterator( pN.index() );
			    while( edgeItr.next() )
			    { 
				    var pE:GraphEdge = edgeItr.current() as IEdge;
					
				    if ( pE.getCost() > greatest)
					     greatest = pE.getCost();
			  }
		  }
		  return greatest;
		}

	#endif

	}	
}




