package com.cjm.game.ai.behaviors.steering 
{
	import com.cjm.game.ai.behaviors.Behavior;
	import com.cjm.game.core.IGameEntity;
	import com.cjm.math.geom.Vector2D;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	internal class Seek extends Behavior 
	{
		protected var _targetPosition:Vector2D;
	
		override public function start( ...params ) :void
		{
			super.start(params);
			
			_gameEntity  = params[0] as IGameEntity;
		}

		override public function calculate( multiplierModifier:Number = 1 ) :Vector2D
		{
			//TODO: Update with correct logic
			var desiredVelocity = Vector2D.Vec2DNormalize( _targetPosition.subtract(_owner.getPosition())).scaleBy(_owner.getMaxSpeed());
			_owner.getVelocity().scaleBy( desiredVelocity );
			
			return super.calculate( multiplierModifier );
		}
	}
}