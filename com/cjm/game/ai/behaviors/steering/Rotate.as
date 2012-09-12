package com.cjm.game.ai.behaviors.steering 
{
	import com.cjm.game.ai.behaviors.Behavior;
	import com.cjm.game.ai.behaviors.IBehavior;
	import com.cjm.game.core.IGameMovingEntity;
	import com.cjm.patterns.behavioral.state.IState;
	import com.cjm.utils.math.Vector2D;
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	internal class Rotate extends Behavior 
	{
		private var _memory:Vector.<Number>;
		private var _direction:Number;	

		/* INTERFACE com.cjm.game.ai.behaviors.IBehavior */
		override public function start(...params):Vector2D 
		{
			super.start(params);
			
			_direction = params[0] as Number;//0 == clockwise
		}
		
		override public function calculate( multiplierModifier:Number = 1 ):Vector2D 
		{
			var te:Number = _owner.getSteeringSystem().timeElapsed;//time elapsed
			var h:Number  = _owner.getHeading();
			var tr:Number = _owner.getTurnRate();
			var nh:Number = _direction == 0 ? (h += ( tr * te )) : (h -= ( tr * te ));
			
			_memory.push(h);
			
			_owner.setHeading( nh  ) ;
			
			return super.calculate( multiplierModifier );//Blank vector, heading is modified, not position
		}

		public function undo():void 
		{
			super.undo();
			
			//Set to previous heading
			//TODO, time stamp undo to match execute timeElapsed deltas
			while ( _memory.length )
				_owner.setHeading( _memory.pop() );
		}
	}
}