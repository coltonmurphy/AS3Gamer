package com.cjm.game.ai.pathfinding.heuristic 
{
	import com.cjm.game.graph.IGraph;
	import com.cjm.game.pathfinding.INode;
	import com.cjm.game.pathfinding.Node;
	import com.cjm.math.MathUtil;
	import formosus.ai.pathfinding.MapNode;
	import formosus.collections.comparers.IComparer;
	/**
	 * @author Mark
	 */
	public class NoisedEuclidHeuristic extends EuclidHeuristic
	{

		override public function calculate(graph:IGraph, node1:int, node2:int):Number
		{	
			var distCost:Number = super.calculate( graph, node1, node2);
			//Return distance cost of this node to end node
			return distCost * MathUtil.random ( .8, 1.2 );
		}
	}
}
