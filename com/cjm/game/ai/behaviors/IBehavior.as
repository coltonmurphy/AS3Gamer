package com.cjm.game.ai.behaviors
{
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	import com.cjm.patterns.behavioral.state.IState;
	import flash.geom.Vector3D;

	
	public interface IBehavior extends IState
	{
		public function getSteeringForce():Vector3D;
	}
	
}