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
				enter( paramsForAutoExecute );//initialize forces
				calculate( );//Updates _steeringForce
				exit( )
			}
		}	
		
		public function start(...params):void 
		{
			_active = true;
			
			if ( null == _steeringForce )
				_steeringForce = new Vector2D();
		}
		
		public function stop():void 
		{
			_active = false;
		}
		
		public function calculate(multiplierModifier:Number = 1 ):Vector2D
		{
			return _steeringForce.scaleBy( multiplierModifier );
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