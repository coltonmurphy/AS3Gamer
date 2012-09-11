package com.cjm.game.ai.behaviors.steering 
{
	import com.cjm.game.ai.agent.IAgent;
	import com.cjm.game.ai.behaviors.Behavior;
	import com.cjm.game.core.IGameEntity;
	import com.cjm.patterns.behavioral.observer.INotification;
	import com.cjm.patterns.behavioral.state.IState;
	import com.cjm.patterns.structural.core.IContext;
	import com.cjm.utils.math.Vector2D;
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	internal class Alignment extends Behavior
	{
		private var _neighbors:Vector.<IGameEntity>;
		private var _avgHeading:Vector2D;//result/returned vector

		override public function enter( ...params ) :void
		{
			super.enter(params);
			
			
		}

		override public function execute( ...params ) :Vector2D
		{
			super.execute(params);
			
			_neighbors  = params[0] as Vector.<IGameEntity>;
			_avgHeading = new Vector2D();
			
			//Amount of neighbors
			var neighborCount:Number = 0'
			
			for each( n:IGameEntity in _neighbors )
			{
				if ( n != _owner && n.isTagged() )
				{
					_avgHeading.add( n.getHeading() );
					
					++neighborCount;
				}
			}
			
			if ( neighborCount > 0 )
			{
				_avgHeading.divideBy( neighborCount );
				_avgHeading.subtract( _owner.getHeading() );
			}
			
			return _avgHeading;
		}
		
	}

}