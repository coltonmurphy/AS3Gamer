package com.cjm.game.core 
{
	import com.cjm.math.geom.Vector2D;

	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IGameMovingEntity extends IGameEntity
	{
		function setVelocity(v:Vector2D):Boolean;
		function getVelocity():Vector2D;
		
		function rotateFacingTowardPosition( target:Vector2D ):Boolean
		function setHeading(v:Vector2D):Boolean;
		function getHeading():Vector2D;

		function setMaxSpeed(s:uint):Boolean;
		function getMaxSpeed():uint;
		
		function setSpeed(s:uint):Boolean;
		function getSpeed():uint;
		
		function setMaxForce(g:uint):Boolean;
		function getMaxForce():uint;
	
		function setTurnRate(g:uint):Boolean; 
		function getTurnRate():uint;
	}
	
}