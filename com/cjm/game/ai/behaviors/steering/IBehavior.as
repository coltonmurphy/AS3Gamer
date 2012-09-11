package com.cjm.game.ai.behaviors.steering
{
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	import com.cjm.patterns.behavioral.state.IState;
	import com.cjm.utils.math.Vector2D;
	import flash.geom.Vector3D;

	
	public interface IBehavior
	{
		public function enter( ...params ):Vector2D;
		public function exit( ...params ):Vector2D;
		public function execute( ...params ):Vector2D;
		public function getSteeringForce():Vector2D;
		public function isActive():Boolean;
	}
	
}