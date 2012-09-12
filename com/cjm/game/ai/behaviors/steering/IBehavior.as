package com.cjm.game.ai.behaviors.steering
{
	
	/**
	 * ...
	 * @author Colton Murphy
	 */

	import com.cjm.utils.math.Vector2D;

	public interface IBehavior
	{
		public function start( ...params ):void;
		public function stop( ):void;
		public function calculate( multiplierModifier:Number = 1 ):Vector2D;
		public function getSteeringForce():Vector2D;
		public function isActive():Boolean;
	}
	
}