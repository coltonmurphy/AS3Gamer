package com.cjm.game.ai.behaviors.steering 
{
	import com.cjm.game.ai.agent.IAgent;
	import com.cjm.game.ai.behaviors.Behavior;
	import com.cjm.game.core.GameError;
	import com.cjm.game.core.IGameEntity;
	import com.cjm.game.core.IGameMovingEntity;
	import com.cjm.patterns.behavioral.observer.INotification;
	import com.cjm.patterns.behavioral.state.IState;
	import com.cjm.patterns.structural.core.IContext;
	import com.cjm.utils.math.Vector2D;
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	internal class Cohesion extends Behavior
	{
		private var _neighbors:Vector.<IGameEntity>;
		private var _centerOfMass:Vector2D;
		
		public function Cohesion( owner:IGameMovingEntity, autoRun:Boolean = false,neighbors:Vector.<IGameEntity> = null )
		{
			super( owner, autoRun, neighbors )
			
			_neighbors = neighbors;
		}
		override public function enter( ...params ) :Vector2D
		{
			super.enter(params);
			
			if ( _neighbors.length != 0 )
				_neighbors  = params[0] as Vector.<IGameEntity>;
		
			return _steeringForce;
		}

		override public function execute( ...params ) :Vector2D
		{
			super.execute(params);
			
			_centerOfMass = new Vector2D();
			_steeringForce = new Vector2D();
			
			//Amount of neighbors
			var neighborCount:Number = 0'
			
			for each( n:IGameEntity in _neighbors )
			{
				if ( n != _owner && n.isTagged() )
				{
					_centerOfMass.add( n.getPosition() );
					
					++neighborCount;
				}
			}
			
			if ( neighborCount > 0 )
			{
				_centerOfMass.divideBy( neighborCount );
				_steeringForce = (new Seek(_owner, _centerOfMass)).getSteeringForce();
			}
			
			return _steeringForce;
		}
		
	}

}