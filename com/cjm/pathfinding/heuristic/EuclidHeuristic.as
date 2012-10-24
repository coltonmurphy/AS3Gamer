package com.cjm.game.ai.pathfinding.heuristic 
{
	import com.cjm.game.graph.IGraph;
	import com.cjm.game.ai.pathfinding.INode;
	import com.cjm.game.ai.pathfinding.Node;
	import formosus.ai.pathfinding.MapNode;
	import formosus.collections.comparers.IComparer;
	/**
	 * @author Mark
	 */
	public class EuclidHeuristic extends Heuristic
	{

		override public function calculate(graph:IGraph, node1:int, node2:INode:int):Number
		{	
			//Return distance cost of this node to end node
			return graph.getNode(node1).getPosition().getDistance( graph.getNode(node2).getPosition() );
		}
	}
}
