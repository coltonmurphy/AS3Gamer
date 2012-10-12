package com.cjm.game.ai.pathfinding 
{
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IPath 
	{
		public function next():INode//using cursor for iterations
		public function end():INode
		public function begin():INode;
		public function length():uint;
		public function getNode( i:uint ):INode;
		public function addNode( n:INode ):uint;
		public function removeNode( n:INode ):uint
		public function setNodes( vs:Vector.<INode> ):Boolean;
		public function getNodes( ):Vector.<INode>;
		public function inverse( ):Vector.<INode>;
		public function getCurrentWaypoint( ):INode;
		public function setNextWaypoint( ):void;
		public function finshed( ):void;
	}
	
}