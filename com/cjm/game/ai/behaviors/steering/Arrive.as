package com.cjm.game.ai.behaviors.steering 
{
	import com.cjm.game.ai.agent.IAgent;
	import com.cjm.game.ai.behaviors.Behavior;
	import com.cjm.utils.math.Vector2D;


	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	internal class Arrive extends Behavior
	{
		protected var _toPosition:Vector2D;
		protected var _deceleration:Number;
		
		override public function enter( ...params ) :void
		{
			super.enter(params);
			
			_toPosition   = params[0] as Vector2D;
			_deceleration = params[1] as Number; 
		}
		
		override public function exit( ...params ) :void
		{
			super.exit(params);
			
			//TODO: Exit functionality, record data for reuse
		}
		
		override public function execute( ...params ) :Vector2D
		{
			super.execute(params);
			
			var distance:Number = _toPosition.length;
			
			if ( distance > 0 )
			{
				//Deceleration Tweaker
				var decelTweaker:Number = 0.3;
				
				//Calculate speed requrired to reach the target given the desired decel
				var speed:Number = distance / (_deceleration * decelTweaker);
				
				//make sure the velocity is truncated
				speed = Math.min( speed, _owner.getMaxSpeed());
				
				var desiredVelocity:Vector2D = _toPosition.normalize( speed / distance );
				
				return desiredVelocity.subtract(_owner.getVelocity())
			}
		}
	}

}