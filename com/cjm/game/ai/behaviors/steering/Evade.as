package com.cjm.game.ai.behaviors.steering 
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	import com.cjm.game.ai.behaviors.Behavior;
	import com.cjm.game.core.IGameEntity;
	import com.cjm.utils.math.Vector2D;

	internal class Evade extends Behavior
	{
		private var _evader :IGameEntity;
		private var _pursuer:IGameEntity;
		
		override public function execute( ...params ) :Vector2D
		{
			super.execute(params);
			
			_evader  = params[0] as IAgent;
			_pursuer = params[1] as IAgent;
			
			var agent1:IAgent = params[0] as IGameEntity;
			var agent2:IAgent = params[1] as IGameEntity;
			
			var toPusuer:Vector2D = agent2.getPosition().subtract(agent1.getPosition());
			var lookAhead:Number = toPusuer.length / (agent1.getMaxSpeed() + agent2.getSpeed());
			var toPosition:Vector2D = agent2.getPosition().add(agent2.getVelocity()).scaleBy(lookAhead);
			return (new Flee(_owner, true, toPosition)).getSteeringForce();
			
		}
		
	}
}