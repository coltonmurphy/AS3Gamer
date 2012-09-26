package com.cjm.game.ai.behaviors.steering 
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	import com.cjm.game.ai.agent.IAgent;
	import com.cjm.game.ai.behaviors.Behavior;
	import com.cjm.game.core.IGameMovingEntity;
	import com.cjm.utils.math.Vector2D;

	
	internal class Interpose extends Behavior
	{
		protected var _agentA :IGameMovingEntity;
		protected var _agentB :IGameMovingEntity;
		
		protected var _midpoint:Vector2D;
		protected var _timeToReachMidpoint:Number;
		protected var _furturePosB:Vector2D;
		protected var _furturePosC:Vector2D;
		
		override public function start( ...params ) :void
		{
			super.start();
			
			_agentA = params[0] as IGameMovingEntity;
			_agentB = params[1] as IGameMovingEntity;	
		}
		
		override public function calculate( multiplierModifier:Number = 1 ) :Vector2D
		{
			_midpoint = ( _agentA.getPosition().add(_agentB.getPosition()) ).scaleBy( 0.5 );
			_timeToReachMidpoint = _owner.getDistance( _midpoint ) / _agentA.getMaxSpeed();
			_furturePosA = _agentA.getPosition().add(_agentA.getVelocity()).scaleBy(_timeToReachMidpoint);
			_furturePosB = _agentB.getPosition().add(_agentB.getVelocity()).scaleBy(_timeToReachMidpoint);
			
			//Midpoint of predicted positions
			_midpoint = _furturePosA.add( _furturePosB ).scaleBy( 0.5 );
			
			var howFast:Number = 2;
			_steeringForce = (new Arrive(_owner, true, _midpoint, howFast)).getSteeringForce();
			
			return super.calculate( multiplierModifier );
		}
		
	}
}