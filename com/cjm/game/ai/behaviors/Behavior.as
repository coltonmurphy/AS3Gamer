package com.cjm.game.ai.behaviors 
{
	import com.cjm.game.core.IGameMovingEntity;
	import com.cjm.patterns.behavioral.state.IState;
	import com.cjm.patterns.behavioral.state.State;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Behavior extends State implements IBehavior
	{
		protected var _owner:IGameMovingEntity = null;
		protected var _steeringForce:Vector3D  = null;
		
		public function Behavior( gme:IGameMovingEntity ) 
		{
			_owner = gme;
		}	
		
		public function getSteeringForce():Vector3D
		{
			return _steeringForce;
		}
	}
}