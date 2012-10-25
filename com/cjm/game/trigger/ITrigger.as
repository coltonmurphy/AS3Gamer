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
		function evaluate( tr:IGameEntity ):void//spelled incorrectly on purpose
		
		//Testing zone data
		function setRegion( tr:ITriggerRegion ):void
		function getRegion( tr:ITriggerRegion ):void
		function isTouching( e:IGameEntity, radius:Number ):void
		
		//Called from update() is condition requires it.
		function removeFromGame( tr:ITriggerRegion ):void//Next update removal 
		
		//eval and update will only execute if trigger is activated
		function setActive( bool:Boolean ):void
		function getActive():Boolean
		
		//helpful for search algorithm for various entity types in gameworld graph
		function setGraphNode( node:INode ):void
		function getGraphNode():INode
		
		//utility function to help automate trigger creation
		function addCircularRegion( position:Vector3D, radius:Number ):ITriggerRegion;
		function addRectangleRegion( positionTopLeft:Vector3D, positionBottomRight:Number ):ITriggerRegion;
	}
	
}