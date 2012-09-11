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
		
		public function Rotate( owner:IGameMovingEntity ) 
		{
			super(owner)
		}
		
		/* INTERFACE com.cjm.game.ai.behaviors.IBehavior */
		override public function enter(...params):Vector2D 
		{
			super.enter(params);
			
			_rotating = true;
		}
		
		override public function exit(...params):Vector2D 
		{
			super.exit(params);
			
			_rotating = false;
		}
		
	
		override public function execute(...params):Vector2D 
		{
			super.execute(params);
			
			_direction = params[0] as Number;//0 == clockwise
			var te:Number = _owner.getSteeringSystem().timeElapsed;//time elapsed
			
			if (_rotating)
			{
				var h:Number  = _owner.getHeading();
				var tr:Number = _owner.getTurnRate();
				var nh:Number = _direction == 0 ? (h += ( tr * te )) : (h -= ( tr * te ));
				
				_memory.push(h);
				
			    _owner.setHeading( nh  ) ;
			}
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