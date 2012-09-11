package com.cjm.game.ai.behaviors.steering 
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	import com.cjm.game.ai.behaviors.Behavior;
	import com.cjm.game.core.IGameEntity;
	import com.cjm.game.core.IGameMovingEntity;
	import com.cjm.utils.math.Vector2D;

	internal class Evade extends Behavior
	{
		private var _evader :IGameMovingEntity;
		private var _pursuer:IGameMovingEntity;
		
		public function Evade( owner:IGameMovingEntity, autoRun:Boolean, evader:IGameMovingEntity, pursuer:IGameMovingEntity )
		{
			super( owner, autoRun, evader, pursuer );
		}
		
		override public function enter( ...params ) :Vector2D
		{
			super.enter( params );
			
			switch( params.length )
			{
				case 2:_pursuer = params[1] as IGameMovingEntity;
				case 1:_evader  = params[0] as IGameMovingEntity;
			}
		}
		override public function execute( ...params ) :Vector2D
		{
			super.execute(params);
			
			var toPusuer:Vector2D = _pursuer.getPosition().subtract(_evader.getPosition());
			var lookAhead:Number = toPusuer.length / (_evader.getMaxSpeed() + _pursuer.getSpeed());
			var toPosition:Vector2D = _pursuer.getPosition().add(_pursuer.getVelocity()).scaleBy(lookAhead);
			
			return (new Flee(_owner, true, toPosition)).getSteeringForce();
		}
	}
}