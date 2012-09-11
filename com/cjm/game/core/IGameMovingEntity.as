package com.cjm.game.core 
{
	import com.cjm.utils.math.Vector2D;

	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IGameMovingEntity extends IGameEntity
	{
		public function setVelocity(v:Vector2D):Boolean;
		public function getVelocity():Vector2D;
		
		public function setHeading(v:Vector2D):Boolean;
		public function getHeading():Vector2D;

		public function setMaxSpeed(s:uint):Boolean;
		public function getMaxSpeed():uint;
		
		public function setSpeed(s:uint):Boolean;
		public function getSpeed():uint;
		
		public function setMaxForce(g:uint):Boolean;
		public function getMaxForce():uint;
	
		public function setTurnRate(g:uint):Boolean;
		public function getTurnRate():uint;
	}
	
}