﻿package com.cjm.game.pathfinding{	import com.cjm.game.ai.pathfinding.INode;	import com.cjm.game.ai.pathfinding.IHeuristic;		public class Heuristic implements IHeuristic	{				public function estimateCost(fromNode:INode, toNode:INode):Number		{				return 1;		}			}}