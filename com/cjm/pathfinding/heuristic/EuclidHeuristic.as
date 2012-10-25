package com.cjm.pathfinding.heuristic 
{
	import com.cjm.graph.IGraph;
	
	public class EuclidHeuristic extends Heuristic
	{ 
		override public function calculate(graph:IGraph, node1:int, node2:int):Number
		{		
			//Return distance cost of this node to end node
			return graph.getNode(node1).getPosition().getDistance( graph.getNode(node2).getPosition() );
		}
	}
}
