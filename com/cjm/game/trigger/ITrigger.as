package com.cjm.game.trigger 
{
	import com.cjm.game.core.IGameEntity;
	import com.cjm.game.ai.pathfinding.INode;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface ITrigger extends IGameEntity
	{
		//Determines if the entity is within the triggers region of influence. If so, the trigger will be pulled.
		public function trie( tr:IGameEntity ):void//spelled incorrectly on purpose
		
		//Testing zone data
		public function setRegion( tr:ITriggerRegion ):void
		public function getRegion( tr:ITriggerRegion ):void
		public function isTouching( e:IGameEntity, radius:Number ):void
		
		//Called from update() is condition requires it.
		public function removeFromGame( tr:ITriggerRegion ):void//Next update removal
		
		//eval and update will only execute if trigger is activated
		public function setActive( bool:Boolean ):void
		public function getActive():Boolean
		
		//helpful for search algorithm for various entity types in gameworld graph
		public function setGraphNode( node:INode ):void
		public function getGraphNode():INode
		
		//utility function to help automate trigger creation
		public function addCircularRegion( position:Vector3D, radius:Number ):ITriggerRegion;
		public function addRectangleRegion( positionTopLeft:Vector3D, positionBottomRight:Number ):ITriggerRegion;
	}
	
}