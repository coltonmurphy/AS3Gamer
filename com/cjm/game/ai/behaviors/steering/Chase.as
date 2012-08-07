package com.cjm.game.ai.behaviors.steering 
{
	import com.cjm.game.ai.agent.IAgent;
	import com.cjm.game.ai.behaviors.Behavior;
	import com.cjm.patterns.behavioral.observer.INotification;
	import com.cjm.patterns.behavioral.state.IState;
	import com.cjm.patterns.structural.core.IContext;
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	internal class Chase extends Behavior
	{
		private var _pursuer:IAgent;
		private var _evader :IAgent;
		

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
			
			return (new Flee()).execute(agent2.getPosition().add(agent2.getVelocity()).scaleBy(lookAhead));
		}
		
	}

}