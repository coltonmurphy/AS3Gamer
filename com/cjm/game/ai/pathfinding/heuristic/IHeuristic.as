﻿package com.cjm.game.ai.pathfinding.heuristic{		import com.cjm.game.graph.IGraph;	import com.cjm.game.ai.pathfinding.INode;	import com.cjm.collections.comparers.IComparer;		public interface IHeuristic	{		public function calculate( g:IGraph, n1Index:int, n1Index:int):Number;	}}