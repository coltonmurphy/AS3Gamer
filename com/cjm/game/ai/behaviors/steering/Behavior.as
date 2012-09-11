package com.cjm.game.ai.behaviors.steering 
{
	import com.cjm.game.core.GameError;
	import com.cjm.game.core.IGameMovingEntity;
	import com.cjm.patterns.behavioral.state.IState;
	import com.cjm.patterns.behavioral.state.State;
	import com.cjm.utils.math.Vector2D;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Behavior implements IBehavior
	{
		protected var _owner:IGameMovingEntity = null;
		protected var _steeringForce:Vector2D  = null;
		protected var _active:Boolean  = false;
		
		/*Constructor parameters:
		 * gme                  = is the entity to which the force derived is applied to
		 * paramsForAutoExecute = is used for when instantiating behavior from inside a behavior, because some behaviors execute others*/
		public function Behavior( gme:IGameMovingEntity, autoRun:Boolean = false, ...paramsForAutoExecute ) 
		{
			_owner = gme;
			
			if ( autoRun )
			{
				enter( paramsForAutoExecute );
				execute( paramsForAutoExecute );//Updates _steeringForce
				exit( paramsForAutoExecute )
			}
		}	
		
		public function enter(...params):Vector2D 
		{
			_active = true;
			
			return _steeringForce;
		}
		
		public function exit(...params):Vector2D 
		{
			_active = false;
			
			return _steeringForce;
		}
		
		public function execute( ...params):Vector2D
		{
			return _steeringForce;
		}
		
		public function getSteeringForce():Vector2D
		{
			return _steeringForce;
		}
		
		public function isActive():Boolean
		{
			return _active;
		}
	}
}