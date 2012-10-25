package com.cjm.game.core 
{
	import com.cjm.math.geom.Vector2D;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IGameWorld extends IUpdate implements ITick, IRun
	{
		function initialize():void
		function render( ...params ):void;
		function tick( ...param ):void;
		function run():Boolean;
		function pause():Boolean; 
		
		//Tag for processing
		function tagObstaclesWithinViewRange( ige:IGameEntity, range:Number ):Boolean;
		
		//Calculate point to local space
		function pointToLocalSpace( obstaclePos:Vector2D, myHeading:Vector2D, mySide:Vector2D, myPos:Vector2D ):Vector2D;
		function pointToGlobalSpace( obstaclePos:Vector2D, myHeading:Vector2D, mySide:Vector2D, myPos:Vector2D ):Vector2D;
	}
	
}