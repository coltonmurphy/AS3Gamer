package com.cjm.game.ai.behaviors.steering 
{
	import com.cjm.game.ai.behaviors.Behavior;
	import com.cjm.game.ai.behaviors.IBehavior;
	import com.cjm.game.core.GameError;
	import com.cjm.game.core.IGameMovingEntity;
	import com.cjm.game.core.IUpdate;
	import com.cjm.game.signals.GameAction;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import flash.utils.getDefinitionByName;
	import org.osflash.signals.ISignal;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class SteeringSystem implements IUpdate
	{
		private var _onUpdate:GameAction              = new GameAction( Number, Number );
		private var _onMapBehaviorToAction:GameAction = new GameAction( Behavior, GameAction );
		private var _onSetCurrentBehavior:GameAction  = new GameAction( Behavior, Behavior );
		
		private var _owner:IGameMovingEntity;
		private var _package:String = "com.cjm.game.ai.behaviors.steering."
		private var _entityBehaviorsSignalMap:Dictionary;
		private var _entityActiveBehaviors:Array;
		
		private static var _entities:Vector.<IGameMovingEntity> = new Vector.<IGameMovingEntity>;
		private static var _instances:Dictionary = new Dictionary();
		
		
		public function SteeringSystem( s:SingletonKey, owner:IGameMovingEntity ) 
		{
			_owner = owner;
			_entityBehaviors = new Dictionary( true );
			_entityActiveBehaviors = new Array
		}
		
		public static function getInstance( owner:IGameMovingEntity ):SteeringSystem
		{
			if ( !_entities.indexOf( owner ) )
			{
				_instances[owner] = new SteeringSystem( new SingletonKey(), owner );
				_entities.push( owner );
			}
			
			return _instances[ owner ];
		}
		
		public function calculate(...params):Vector3D
		{
			throw new Error("SteeringSystem calculate() must be overriden by subclass")
		}
		
		public function get onMapBehaviorToAction():GameAction 
		{
			return _onMapBehaviorToAction;
		}
		public function mapBehaviorToAction( clazzName:String, signal:GameAction ):Boolean
		{
			var clazz:IBehavior = getDefinitionByName( _package.concat( clazzName ));//Should be able to access internal steering classes
			
			if ( null != clazz )
			{
				var obj:IBehavior = new clazz( _owner )
				_entityBehaviors[obj]  = signal;
				_entityBehaviors[signal] = obj;
				signal.add( setCurrentBehavior );
				_onMapBehaviorToAction.dispatch(obj, signal)
				return true;
			}
			else
			{
				throw new GameError( GameError.INVALID_DEFINITION, clazzName )
			}
			
			return false;
		}
		
		public function get onSetCurrentBehavior():GameAction {return _onSetCurrentBehavior;}
		public function setCurrentBehavior( b:GameAction, ...payLoad ):void 
		{
			var current:IBehavior = _entityActiveBehaviors[0] as Behavior;
			if ( null != current )
			{
				current.exit();
			}
			
			_entityActiveBehaviors.unshift( _entityBehaviors[b] );// Remove duplicates? Use behavior priority stack or one at a time?
			
			IBehavior(_entityBehaviors[b]).enter( payLoad );
			
			_onSetCurrentBehavior.dispatch(current, _entityBehaviors[b]);
		}
		
		public function get onUpdate( timeSlice:Number ){return _onUpdate;}
		public function update( timeSlice:Number )
		{
			_timeElapsed = getTimer() - timeSlice;//TODO: timeSlice will end up being delta, not sure if I want to thread yet
			
			for ( var i:Number = 0; i < _entityActiveBehaviors.length; i++ )
				  _entityActiveBehaviors[i].execute();
			
			_onUpdate.dispatch(timeSlice, timeElapsed)
		}
		
		public function get timeElapsed():Number 
		{
			return _timeElapsed;
		}
		
		public function queryRadiusByEntityType(radius:int = 1, type:Class = null):Vector.<IAgent>
		{
			var agents = new Vector.<IAgent>;
			
			for each( agent:IAgent in _systems )
			{
				if ( null == type || ( agent is type ))
				{
					if ( _owner.getDistance( agent.getPosition() ) <= radius )
					{
						agents.push(agent)
					}
				}
			}
			
			return agents;
		}
	}	
}
private class SingletonKey { public function SingletonKey() { }};
private class 