package com.cjm.game.ai.behaviors.steering 
{
	import com.cjm.game.ai.agent.IAgent;
	import com.cjm.game.ai.behaviors.Behavior;
	import com.cjm.game.core.IGameMovingEntity;
	import com.cjm.utils.math.Vector2D;
	import flash.geom.Vector3D;


	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	internal class Flee extends Behavior
	{
		protected var _toPosition:Vector2D;


		public function Flee( owner:IGameMovingEntity, autoRun:Boolean, target:Vector2D = null )
		{
			super( owner, autoRun, target )
		}
		
		override public function start( ...params ) :void
		{
			super.start(params);
			
			_toPosition   = params[0] as Vector2D; 
		}
		
		override public function calculate( multiplierModifier:Number = 1 ) : Vector2D
		{
			var desiredVel:Vector2D = _toPosition.subtract(_owner.getPosition()).normalize(_owner.getSpeed());
			_steeringForce = desiredVel.subtract(_owner.getVelocity()).getReverse(); 
		
			return super.calculate(  multiplierModifier );
		}	
	}
}