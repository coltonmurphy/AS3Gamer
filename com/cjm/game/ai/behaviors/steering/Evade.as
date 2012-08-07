package com.cjm.game.ai.behaviors.steering 
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	import com.cjm.game.ai.agent.IAgent;
	import com.cjm.game.ai.behaviors.Behavior;
	import flash.geom.Vector3D;
	
	internal class Evade extends Behavior
	{
		private var _evader :IAgent;
		private var _pursuer:IAgent;
		
		override public function enter( ...params ) :Boolean
		{
			super.enter(params);
			
			_evader  = params[0] as IAgent;
			_pursuer = params[1] as IAgent;
			
			return _evader && _pursuer;
		}
		
		override public function exit( ...params ) :Boolean
		{
			super.exit(params);
			
			_evader  = params[0] as IAgent;
			_pursuer = params[1] as IAgent;
			
			return _evader && _pursuer;
		}
		
		override public function execute( ...params ) :Boolean
		{
			super.execute(params);
			
			var agent1:IAgent = params[0] as IAgent;
			var agent2:IAgent = params[1] as IAgent;
			
			var toPusuer:Vector3D = agent2.getPosition().subtract(agent1.getPosition());
			var lookAhead:Number = toPusuer.length / (agent1.getMaxSpeed() + agent2.getSpeed());
			
			return (new Flee(_owner)).execute(agent2.getPosition().add(agent2.getVelocity()).scaleBy(lookAhead));
		}
		
	}
}