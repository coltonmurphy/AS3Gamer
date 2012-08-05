package com.cjm.game.ai.behaviors.steering 
{
	import com.cjm.game.ai.behaviors.Behavior;
	import com.cjm.game.ai.behaviors.IBehavior;
	import com.cjm.game.core.IGameMovingEntity;
	import com.cjm.patterns.behavioral.state.IState;
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
		public function enter(...params):Boolean 
		{
			super.enter(params);
			
			_rotating = true;
		}
		
		public function exit(...params):Boolean 
		{
			super.exit(params);
			
			_rotating = false;
		}
		
	
		public function execute(...params):void 
		{
			super.execute(params);
			
			var te:Number = SteeringSystem.getInstance( _owner ).timeElapsed;//time elapsed
			
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
	
		
		public function destroy():void 
		{
			super.destroy();
			
			_memory = null;
			
		}
	
		
		public function get direction():uint 
		{
			return _direction;
		}
		
		public function set direction(value:uint):void 
		{
			_direction = value;
		}
		
	}

}