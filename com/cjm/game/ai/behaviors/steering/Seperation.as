package com.cjm.game.ai.behaviors.steering 
{
	import com.cjm.game.ai.agent.IAgent;
	import com.cjm.game.ai.behaviors.Behavior;
	import com.cjm.game.core.GameError;
	import com.cjm.game.core.IGameEntity;
	import com.cjm.game.core.IGameMovingEntity;
	import com.cjm.utils.math.Vector2D;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	internal class Seperation extends Behavior
	{
		private var _neighbors:Vector.<IGameEntity>;

		override public function start( ...params ) :void
		{
			super.start();
			
			if ( _neighbors.length != 0 )
				_neighbors  = params[0] as Vector.<IGameEntity>;
		}

		override public function calculate ( multiplierModifier:Number = 1 ) :Vector2D
		{
			for each( n:IGameEntity in _neighbors )
			{
				if ( n != _owner && n.isTagged() )
				{
					var toAgent:Vector2D _owner.getPosition().subtract( n.getPosition() );
					
					//scale the force inversely proportional to the agents distance from its neighbor
					_steeringForce.add( Vector2D.Vec2DNormalize( toAgent ).divideBy( toAgent.length ) );
			
				}
			}

			return super.calculate( multiplierModifier );
		}
	}
}