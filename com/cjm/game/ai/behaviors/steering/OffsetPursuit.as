package com.cjm.game.ai.behaviors.steering 
{
	import com.cjm.game.ai.agent.IAgent;
	import com.cjm.game.ai.behaviors.Behavior;
	import com.cjm.game.core.IGameEntity;
	import com.cjm.game.core.IGameMovingEntity;
	import com.cjm.patterns.behavioral.observer.INotification;
	import com.cjm.patterns.behavioral.state.IState;
	import com.cjm.patterns.structural.core.IContext;
	import com.cjm.utils.math.Vector2D;
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	internal class Seperation extends Behavior
	{
		private var _neighbors:Vector.<IGameEntity>;
		private var _avgHeading:Vector2D;//result/returned vector

		override public function start( ...params ) :void
		{
			super.start();
			
			_leader  = params[0] as IGameMovingEntity;
			_offset  = params[1] as Vector2D;
		}

		override public function calculate( multiplierModifier:Number = 1 ) :Vector2D
		{
			//Amount of neighbors
			var worldOffsetPos:Vector2D = _owner.getWorld().pointToWorldSpace( _offset, 
																		  _leader.getHeading(),
																		  _leader.getSide(),
																		  _leader.getPosition());
																		  
			var toOffset:Vector2D = worldOffsetPursuit.subtrace( _owner.getPosition() );
			
			
			//The lookahead time is proportional to the distance between the leader and
			// the pursuer, and is inversely proportional to the sum of both agents velocities
			var lookAheadTime:Number = toOffset.length / (_owner.getMaxSpeed() + _leader.getSpeed());
			var force:Vector2D = worldOffsetPos.add( _leader.getVelocity() ).scaleBy( lookAheadTime )
			
			//Now arrive at the predicted future position of the offset
			_steeringForce = new Arrive( _owner, true, force, Arrive.FAST );
			return super.calculate( multiplierModifier );
		}
	}
}