package com.cjm.game.ai.behaviors.steering 
{
	import com.cjm.game.ai.behaviors.Behavior;
	import com.cjm.game.ai.behaviors.IBehavior;
	import com.cjm.game.core.GameError;
	import com.cjm.game.core.GameSystem;
	import com.cjm.game.core.IGameEntity;
	import com.cjm.game.core.IGameMovingEntity;
	import com.cjm.game.core.IUpdate;
	import com.cjm.game.signals.GameAction;
	import com.cjm.utils.math.Vector2D;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import flash.utils.getDefinitionByName;
	import org.osflash.signals.ISignal;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class SteeringSystem extends GameSystem implements IUpdate
	{
		public static var MAX_STEERING_FORCE:Number  = 20;
		private var _updateSignal:GameAction              = new GameAction( Number, Number );
		/*private var _onMapBehaviorToAction:GameAction = new GameAction( Behavior, GameAction );
		private var _onSetCurrentBehavior:GameAction  = new GameAction( Behavior, Behavior );*/
		
		private var _owner:IGameMovingEntity;
		public var wanderTolerance:Number;

		//Default all behavior tolerance to 1, update it in the initialize method.
		public var waitTolerance				 = 1;
		public var seekTolerance 				 = 1;
		public var wallAvoidanceTolerance		 = 1;
		public var rotateTolerance				 = 1;
		public var obstacleOvoidanceTolerance    = 1;
		public var interposeTolerance 			 = 1;
		public var hideTolerance 			     = 1;
		public var evadeTolerance				 = 1;
		public var cohesionTolerance 			 = 1;
		public var arriveTolerance				 = 1;
		public var alignmentTolerance 			 = 1;
		
		protected var _behaviorWander:IBehavior;
		protected var _behaviorWait:IBehavior;
		protected var _behaviorSeek:IBehavior;
		protected var _behaviorWallAvoidance:IBehavior;
		protected var _behaviorRotate:IBehavior;
		protected var _behaviorObstacleOvoidance:IBehavior;
		protected var _behaviorInterpose:IBehavior;
		protected var _behaviorHide:IBehavior;
		protected var _behaviorEvade:IBehavior;
		protected var _behaviorCohesion:IBehavior;
		protected var _behaviorArrive:IBehavior;
		protected var _behaviorAlignment:IBehavior;
		
		public function SteeringSystem( owner:IGameMovingEntity ) 
		{
			_owner = owner;
			_entityBehaviors = new Dictionary( true );
			_entityActiveBehaviors = new Array
		}
		
		/*Overload initialize() for additional control variable assignments and additional behaviors*/
		public function initialize():void
		{
			/*//TODO: Use xml configuration file for behavior affinity/priority tweaks, used to modify vector lengths of active behaviors
			 * These members are public so they can be modified by client at anytime.*/
			wanderTolerance 			 = .6;
			waitTolerance				 = .8;
			seekTolerance 				 = .5;
			wallAvoidanceTolerance		 = 1;
			rotateTolerance				 = 1;
			obstacleOvoidanceTolerance   = 1;
			interposeTolerance 			 = .3;
			hideTolerance 			     = 1;
			evadeTolerance				 = 1;
			cohesionTolerance 			 = .7;
			arriveTolerance				 = .9;
			alignmentTolerance 			 = .7;
			
			//NOTE: Can set radius, distance, and jitter thru constructor as well as enter method within the wanderOn method.
			_behaviorWander 		 	= new Wander( _owner );
			_behaviorWait   		 	= new Wait( _owner );
			_behaviorSeek   		 	= new Seek( _owner );
			_behaviorWallAvoidance   	= new WallAvoidance( _owner );
			_behaviorRotate  			= new Rotate( _owner );
			_behaviorObstacleOvoidance  = new ObstacleAvoidance( _owner );
			_behaviorInterpose   		= new Interpose( _owner );
			_behaviorHide   			= new Hide( _owner );
			_behaviorEvade  			= new Evade( _owner );
			_behaviorCohesion   		= new Cohesion( _owner );
			_behaviorArrive   		    = new Arrive( _owner );
			_behaviorAlignment   		= new Alignment( _owner );
		}
		
		/*This will calculate the steering forces and combine the relative vector data for owner x,y translations within owners update method.*/
		public function calculate():Vector2D
		{
			var steeringForce = new Vector2D();
			
			//Execute activated behaviors
			if (_behaviorWander.isActive())
				steeringForce.add( _behaviorWander.execute().scaleBy( wanderTolerance ));
				
			if (_behaviorWait.isActive())
				steeringForce.add( _behaviorWait.execute().scaleBy( waitTolerance ));
				
			if (_behaviorSeek.isActive())
				steeringForce.add( _behaviorSeek.execute().scaleBy( seekTolerance ));
				
			if (_behaviorWallAvoidance.isActive())
				steeringForce.add( _behaviorWallAvoidance.execute().scaleBy( wallAvoidanceTolerance ));
				
			if (_behaviorRotate.isActive())
				steeringForce.add( _behaviorRotate.execute().scaleBy( rotateTolerance ));
				
			if (_behaviorObstacleOvoidance.isActive())
				steeringForce.add( _behaviorObstacleOvoidance.execute().scaleBy( obstacleOvoidanceTolerance ));
				
			if (_behaviorInterpose.isActive())
				steeringForce.add( _behaviorInterpose.execute().scaleBy( interposeTolerance ));
				
			if (_behaviorHide.isActive())
				steeringForce.add( _behaviorHide.execute().scaleBy( hideTolerance ));
				
			if (_behaviorEvade.isActive())
				steeringForce.add( _behaviorEvade.execute().scaleBy( evadeTolerance ));
			
			if (_behaviorCohesion.isActive())
				steeringForce.add( _behaviorCohesion.execute().scaleBy( cohesionTolerance ));
				
			if (_behaviorArrive.isActive())
				steeringForce.add( _behaviorArrive.execute().scaleBy( arriveTolerance ));
			
			if (_behaviorAlignment.isActive())
				steeringForce.add( _behaviorAlignment.execute().scaleBy( alignmentTolerance ));	
				
			steeringForce.truncate(MAX_STEERING_FORCE)
			
			return steeringForce;
		}
		
		//Wandering around, activates wanderer steering.
		public function wanderOn( wanderRadius = Wander.DEFAULT_RADIUS, 
								  wanderDistance = Wander.DEFAULT_DISTANCE, 
								  wanderJitter=Wander.DEFAULT_JITTER ):void
		{
			_behaviorWander.enter( wanderRadius, wanderDistance, wanderJitter );
		}
		
		public function wanderOff():void
		{
			_behaviorWander.exit();
		}
		
		public function waitOn( time = Wait.DEFAULT_TIME ):void
		{
			_behaviorWait.enter( time );
		}
		
		public function waitOff():void
		{
			_behaviorWait.exit();
		}
		
		public function seekOn( target:IGameEntity ):void
		{
			_behaviorSeek.enter( target );
		}
		
		public function seekOff():void
		{
			_behaviorSeek.exit();
		}
		
		public function seekOn( target:IGameEntity ):void
		{
			_behaviorSeek.enter( target );
		}
		
		public function seekOff():void
		{
			_behaviorSeek.exit();
		}
		
		public function wallAvoidanceOn( walls:Vector.<IGameEntity> ):void
		{
			_behaviorWallAvoidance.enter( walls );
		}
		
		public function wallAvoidanceOff():void
		{
			_behaviorWallAvoidance.exit();
		}
		
		public function rotateOn( target:IGameEntity ):void
		{
			_behaviorRotate.enter( target );
		}
		
		public function rotateOff():void
		{
			_behaviorRotate.exit();
		}
		
		public function obstacleOvoidanceOn( obstacles:Vector.<IGameEntity> ):void
		{
			_behaviorObstacleOvoidance.enter( obstacles );
		}
		
		public function obstacleOvoidanceOff():void
		{
			_behaviorObstacleOvoidance.exit();
		}
		
		public function interposeOn( entity1:IGameEntity, entity2:IGameEntity ):void
		{
			_behaviorInterpose.enter( entity1, entity2 );
		}
		
		public function interposeOff():void
		{
			_behaviorInterpose.exit();
		}
		
		public function hideOn( fromEntity:IGameEntity ):void
		{
			_behaviorHide.enter( fromEntity );
		}
		
		public function hideOff():void
		{
			_behaviorHide.exit();
		}
		
		public function evadeOn( pursuer:IGameMovingEntity ):void
		{
			_behaviorEvade.enter( pursuer );
		}
		
		public function evadeOff():void
		{
			_behaviorEvade.exit();
		}
		
		public function cohesionOn( neighbors:Vector.<IGameEntity> ):void
		{
			_behaviorCohesion.enter( neighbors );
		}
		
		public function cohesionOff():void
		{
			_behaviorCohesion.exit();
		}
		
		public function arriveOn( location:Vector2D, howFast:Number ):void
		{
			_behaviorArrive.enter( location, howFast );
		}
		
		public function arriveOff():void
		{
			_behaviorArrive.exit();
		}
		
		public function alignmentOn( neighbors:Vector.<IGameEntity>y ):void
		{
			_behaviorAlignment.enter( neighbors );
		}
		
		public function alignmentOff():void
		{
			_behaviorAlignment.exit();
		}
		
		
		public function get updateSignal( timeSlice:Number ) { return _updateSignal; }
		/*Determine runtime state modifications for entering and exiting various behaviors, and keep record of timeElapsed for time sensitive behaviors*/
		public function update( timeSlice:Number )
		{
			_timeElapsed = getTimer() - timeSlice;//TODO: timeSlice will end up being delta, not sure if I want to thread yet

			_updateSignal.dispatch(timeSlice, timeElapsed)
		}
		
		public function get timeElapsed():Number 
		{
			return _timeElapsed;
		}
	}	
}
