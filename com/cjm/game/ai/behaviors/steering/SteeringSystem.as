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
	import com.cjm.math.geom.Vector2D;
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
		
		public static const CALCULATE_METHOD_DITHER:String     = "dither";
		public static const CALCULATE_METHOD_PRIOR:String      = "prioritize";
		public static const CALCULATE_METHOD_WEIGHTAVG:String  = "weight average";
		
		public static var MAX_STEERING_FORCE:Number  = 20;
		private var _updateSignal:GameAction              = new GameAction( Number, Number );
		/*private var _onMapBehaviorToAction:GameAction = new GameAction( Behavior, GameAction );
		private var _onSetCurrentBehavior:GameAction  = new GameAction( Behavior, Behavior );*/
		
		private var _owner:IGameMovingEntity;
		private var _steeringForce:Vector2D;
		private var _viewDistance:Number;
		private var _calculateMethod:String;// should be assigned before calculation,use public static const CALC... for assignments
		
		//Default all behavior tolerance to 1, update it in the initialize method
		public var wanderTolerance:Number;
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
		
		protected var _wander:IBehavior;
		protected var _wait:IBehavior;
		protected var _seperation:IBehavior;
		protected var _seek:IBehavior;
		protected var _wallAvoidance:IBehavior;
		protected var _rotate:IBehavior;
		protected var _obstacleOvoidance:IBehavior;
		protected var _interpose:IBehavior;
		protected var _hide:IBehavior;
		protected var _evade:IBehavior;
		protected var _cohesion:IBehavior;
		protected var _arrive:IBehavior;
		protected var _alignment:IBehavior;
		
		public function SteeringSystem( owner:IGameMovingEntity ) 
		{
			_owner = owner;
			_entityBehaviors = new Dictionary( true );
			_entityActiveBehaviors = new Array
		}
		
		/*Overload initialize() for additional control variable assignments and additional behaviors*/
		public function initialize():void
		{
			_viewDistance = 5;
			_calculateMethod = CALCULATE_METHOD_WEIGHTAVG;
			
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
			
			prWallAvoidance
			prObstacleAvoidance
			
			//NOTE: Can set radius, distance, and jitter thru constructor as well as start method within the wanderOn method.s
			_wander 		 	= new Wander( _owner );
			_wait   		 	= new Wait( _owner );
			_seperation         = new Seperation( _owner );
			_seek   		 	= new Seek( _owner );
			//_wallAvoidance   	= new WallAvoidance( _owner );
			_rotate  			= new Rotate( _owner );
			_obstacleOvoidance  = new ObstacleAvoidance( _owner );
			_interpose   		= new Interpose( _owner );
			_hide   			= new Hide( _owner );
			_evade  			= new Evade( _owner );
			_cohesion   		= new Cohesion( _owner );
			_arrive   		    = new Arrive( _owner );
			_alignment   		= new Alignment( _owner );
			
			
		}
		
		/*This will calculate the steering forces and combine the relative vector data for owner x,y translations within owners update method.*/
		public function calculate():Vector2D
		{
			//reset the steering force
		    _steeringForce.Zero();

		    //use space partitioning to calculate the neighbours of this vehicle
		    //if switched on. If not, use the standard tagging system
		    if (!isSpacePartitioningOn())
		    {
			  //tag for group behavior
			  if ( _seperation.isActive() || 
				   _alignment.isActive() || 
				   _cohesion.isActive())
				   
				   _owner.getWorld().tagVehiclesWithinViewRange(_owner, _viewDistance);
		    }
		    else
		    {
			  //calculate neighbours in cell-space for group behavior
			  if ( _seperation.isActive() || 
				   _alignment.isActive() || 
				   _cohesion.isActive())
			       _owner.getWorld().getCellSpace().calculateNeighbors(_owner.getPosition(), _viewDistance);
			  
		    }
			
			//Update force
		    switch ( _calculateMethod )
		    {
			    case CALCULATE_METHOD_WEIGHTAVG:
					_steeringForce = calculateWeightedSum(); 
				break
			    case CALCULATE_METHOD_PRIOR:
					_steeringForce = calculatePrioritized(); 
				break
			    case CALCULATE_METHOD_DITHER:
					_steeringForce = calculateDithered();
			    break
			    default:
				  trace("Please assign a calculation method for SteeringSystem. Force is zero."); 

		   }//end switch

			return steeringForce;
		}
		
		protected function calculateWeightedSum():Vector2D 
		{
			var steeringForce:Vector2D = new Vector2D();
			
			//Execute activated behaviors
			if (_wander.isActive())
				steeringForce.add( _wander.calculate( wanderTolerance ));
				
			if (_wait.isActive())
				steeringForce.add( _wait.calculate( waitTolerance ));
				
			if (_seek.isActive())
				steeringForce.add( _seek.calculate( seekTolerance ));
				
			if (_wallAvoidance.isActive())
				steeringForce.add( _wallAvoidance.calculate( wallAvoidanceTolerance ));
				
			if (_rotate.isActive())
				steeringForce.add( _rotate.calculate( rotateTolerance ));
				
			if (_obstacleOvoidance.isActive())
				steeringForce.add( _obstacleOvoidance.calculate( obstacleOvoidanceTolerance ));
				
			if (_interpose.isActive())
				steeringForce.add( _interpose.calculate(interposeTolerance));
				
			if (_hide.isActive())
				steeringForce.add( _hide.calculate(hideTolerance));
				
			if (_evade.isActive())
				steeringForce.add( _evade.calculate(evadeTolerance));
			
			if (_cohesion.isActive())
				steeringForce.add( _cohesion.calculate(cohesionTolerance));
				
			if (_arrive.isActive())
				steeringForce.add( _arrive.calculate(arriveTolerance));
			
			if (_alignment.isActive())
				steeringForce.add( _alignment.calculate(alignmentTolerance));	
				
			steeringForce.truncate(MAX_STEERING_FORCE);
			
			return steeringForce;
		}
		
		
		
		//  CalculatePrioritized : calls each active behavior in order of priority
		//  and acumulates their forces until the max steering force is aquired.
		protected function calculatePrioritized():Vector2D
		{       
			var force:Vector2D         = new Vector2D();
		    var steeringForce:Vector2D = new Vector2D();
			
		    if ( _wallAvoidance.isActive() )
		    {
			    force = _wallAvoidance.calculate( wallAvoidanceTolerance )
			    
				if ( !accumulateForce( steeringForce, force )) return steeringForce;
		    }
		  
			//TODO: update behavior with obstacles of this timeslice
		    if ( _obstacleOvoidance.isActive() )
		    {
			    force = _obstacleOvoidance.calculate( obstableAvoidanceTolerance );

			    if ( !accumulateForce( steeringForce, force )) return steeringForce;
		    }

		    //TODO: update behavior with target of this timeslice
		    if (On(_evade.isActive()))
		    {
			    force = _evade.calculate( evadeTolerance );

				if ( !accumulateForce(steeringForce, force)) return steeringForce;
		    }

		    //TODO: update behavior with position to run to of this timeslice
		    if ( _behaviorFlee.isActive() )
		    {
			   force = _behaviorFlee.calculate( fleeTolerance );

			   if ( !accumulateForce( steeringForce, force) ) return steeringForce;
		    }

			//TODO: Spacial partitioning
			if (_seperation.isActive())
			{
				//TODO: update with param = _owner.getWorld().getAgents()
			    force = _seperation.calculate( seperationTolerance );

			    if ( !accumulateForce(steeringForce, force)) return steeringForce;
			}

			if (_alignment.isActive())
			{
				//TODO: update with param = _owner.getWorld().getAgents()
			    force = _alignment.calculate( alignmentTolerance );

			    if ( !accumulateForce(steeringForce, force)) return steeringForce;
			}

			if (_cohesion.isActive())
			{
				//TODO: update with param = _owner.getWorld().getAgents()
			    force = _cohesion.calculate( cohesionTolerance );

			    if ( !accumulateForce( steeringForce, force ) ) return steeringForce;
			}

		    if ( _seek.isActive() )
		    {
			    force = _seek.calculate( seekTolerance );

			    if ( !accumulateForce( steeringForce, force ) ) return steeringForce;
		    }

		    if ( _arrive.isActive() )
		    {
			    force = _arrive.calculate( arriveTolerance );

			    if ( !accumulateForce( steeringForce, force ) ) return steeringForce;
		    }
			
			if ( _wander.isActive() )
		    {
			    force = _wander.calculate( wanderTolerance );

			    if ( !accumulateForce( steeringForce, force ) ) return steeringForce;
		    }

		    if ( _behaviorPursuit.isActive() )
		    {
			    force = _behaviorPursuit.calculate( pursuitTolerance );

			    if ( !accumulateForce( steeringForce, force ) ) return steeringForce;
		    }
			
			//For follow the leader behavior, racing or RTS party navigational control
			if ( _behaviorOffsetPursuit.isActive() )
		    {
			    force = _behaviorOffsetPursuit.calculate( offsetPursuitTolerance );

			    if ( !accumulateForce( steeringForce, force ) ) return steeringForce;
		    }

		    if ( _interpose.isActive() )
		    {
			    force = _interpose.calculate( interposeTolerance );

			    if ( !accumulateForce( steeringForce, force ) ) return steeringForce;
		    }

		    //Hide requires a target and the obstacles for use for the hiding
			if ( _hide.isActive() )
		    {
			    force = _hide.calculate( hideTolerance );

			    if ( !accumulateForce( steeringForce, force ) ) return steeringForce;
		    }
  
		    if ( _behaviorFollowPath.isActive() )
		    {
			    force = _behaviorFollowPath.calculate( followPathTolerance );

			    if ( !accumulateForce( steeringForce, force ) ) return steeringForce;
		    }

		    return steeringForce;
		}
		
		private function accumulateForce( runningTot:Vector2D,
                                            forceToAdd:Vector2D )
		{
		    //calculate how much steering force the vehicle has used so far
		    var magnitudeSoFar:Number = RunningTot.length;

		    //calculate how much steering force remains to be used by this vehicle
		    var magnitudeRemaining:Number = _owner.getMaxForce() - magnitudeSoFar;

		    //return false if there is no more force left to use
		    if ( magnitudeRemaining <= 0.0 ) 
				 return false;

		    //calculate the magnitude of the force we want to add
		    var magnitudeToAdd:Number = forceToAdd.length;
		  
		    //if the magnitude of ForceToAdd and the running total
		    //does not go over the maximum force, just 
		    //add them together. Otherwise add as much of the forceToAdd vector as
		    //possible without going over maximum force.
		    if ( magnitudeToAdd < magnitudeRemaining )
		    {
			   runningTot.add( forceToAdd );
		    }
		    else
		    {
			  //add it to the steering force
			  runningTot.add ( Vector2D.Vec2DNormalize( forceToAdd ).scaleBy( magnitudeRemaining ) ); 
		    }

		    return true;
		}
		
		
		// CalculateDithered ----------------------------
		//TODO: explain
		protected function calculateDithered():Vector2D
		{  
		  //reset the steering force
		  var steeringForce:Vector2D = new Vector2D();

		  if (On(wall_avoidance) && Math.random() < prWallAvoidance)
		  {
			steeringForce = WallAvoidance(_owner.getWorld().Walls()) *
								 m_dWeightWallAvoidance / prWallAvoidance;

			if (!steeringForce.isZero())
			{
			  steeringForce.truncate(_owner.getMaxForce()); 
			  
			  return steeringForce; 
			}
		  }
		   
		  if (On(obstacle_avoidance) && Math.random() < prObstacleAvoidance)
		  {
			steeringForce += ObstacleAvoidance(_owner.getWorld().Obstacles()) * 
					m_dWeightObstacleAvoidance / prObstacleAvoidance;

			if (!steeringForce.isZero())
			{
			  steeringForce.truncate(_owner.getMaxForce()); 
			  
			  return steeringForce;
			}
		  }

		  if (!isSpacePartitioningOn())
		  {
			if (On(separation) && Math.random() < prSeparation)
			{
			  steeringForce += Separation(_owner.getWorld().Agents()) * 
								  m_dWeightSeparation / prSeparation;

			  if (!steeringForce.isZero())
			  {
				steeringForce.truncate(_owner.getMaxForce()); 
			  
				return steeringForce;
			  }
			}
		  }

		  else
		  {
			if (On(separation) && Math.random() < prSeparation)
			{
			  steeringForce += SeparationPlus(_owner.getWorld().Agents()) * 
								  m_dWeightSeparation / prSeparation;

			  if (!steeringForce.isZero())
			  {
				steeringForce.truncate(_owner.getMaxForce()); 
			  
				return steeringForce;
			  }
			}
		  }


		  if (On(flee) && Math.random() < prFlee)
		  {
			steeringForce += Flee(_owner.getWorld().Crosshair()) * m_dWeightFlee / prFlee;

			if (!steeringForce.isZero())
			{
			  steeringForce.truncate(_owner.getMaxForce()); 
			  
			  return steeringForce;
			}
		  }

		  if (On(evade) && Math.random() < prEvade)
		  {
			
			steeringForce += Evade(m_pTargetAgent1) * m_dWeightEvade / prEvade;

			if (!steeringForce.isZero())
			{
			  steeringForce.truncate(_owner.getMaxForce()); 
			  
			  return steeringForce;
			}
		  }


		  if (!isSpacePartitioningOn())
		  {
			if ( _allignment.isActive() && Math.random() < prAlignment)
			{
			  steeringForce.add(_allignment.calculate(alignmentTolerance).divideBy( prAlignment))
			  
			  if (!steeringForce.isZero())
			  {
				steeringForce.truncate(_owner.getMaxForce()); 
			  
				return steeringForce;
			  }
			}

			if ( _cohesion.isActive() && Math.random() < prCohesion)
			{
			  steeringForce += _cohesion.calculate( cohesionTolerance ).divideBy( prCohesion );
								  
			  if (!steeringForce.isZero())
			  {
				steeringForce.truncate(_owner.getMaxForce()); 
			  
				return steeringForce;
			  }
			}
		  }
		  else
		  {
			if (_allignment.isActive && Math.random() < prAlignment)
			{
			  steeringForce += AlignmentPlus(_owner.getWorld().getAgents()) *
								  m_dWeightAlignment / prAlignment;

			  if (!steeringForce.isZero())
			  {
				steeringForce.truncate(_owner.getMaxForce()); 
			  
				return steeringForce;
			  }
			}

			if (On(cohesion) && Math.random() < prCohesion)
			{
			  steeringForce += CohesionPlus(_owner.getWorld().getAgents()) *
								  m_dWeightCohesion / prCohesion;

			  if (!steeringForce.isZero())
			  {
				steeringForce.truncate(_owner.getMaxForce()); 
			  
				return steeringForce;
			  }
			}
		  }

		  if (On(wander) && Math.random() < prWander)
		  {
			steeringForce += Wander() * m_dWeightWander / prWander;

			if (!steeringForce.isZero())
			{
			  steeringForce.truncate(_owner.getMaxForce()); 
			  
			  return steeringForce;
			}
		  }

		  if (On(seek) && Math.random() < prSeek)
		  {
			steeringForce += Seek(_owner.getWorld().Crosshair()) * seekTolerance / prSeek;

			if (!steeringForce.isZero())
			{
			  steeringForce.truncate(_owner.getMaxForce()); 
			  
			  return steeringForce;
			}
		  }

		  if (On(arrive) && Math.random() < prArrive)
		  {
			steeringForce += Arrive(_owner.getWorld().Crosshair(), _deceleration) * 
								arriveTolerance / prArrive;

			if (!steeringForce.isZero())
			{
			  steeringForce.truncate(_owner.getMaxForce()); 
			  
			  return steeringForce;
			}
		  }
		 
		  return steeringForce;
		}
		
		public function isSpacePartitioningOn():void 
		{
			return false;//TODO: add spt
		}

		
		//Wandering around, activates wanderer steering.
		public function wanderOn( wanderRadius = Wander.DEFAULT_RADIUS, 
								  wanderDistance = Wander.DEFAULT_DISTANCE, 
								  wanderJitter=Wander.DEFAULT_JITTER ):void
		{
			_wander.start( wanderRadius, wanderDistance, wanderJitter );
		}
		
		public function wanderOff():void
		{
			_wander.stop();
		}
		
		public function waitOn( time = Wait.DEFAULT_TIME ):void
		{
			_wait.start( time );
		}
		
		public function waitOff():void
		{
			_wait.stop();
		}
		
		public function seekOn( target:IGameEntity ):void
		{
			_seek.start( target );
		}
		
		public function seekOff():void
		{
			_seek.stop();
		}
		
		public function seekOn( target:IGameEntity ):void
		{
			_seek.start( target );
		}
		
		public function seekOff():void
		{
			_seek.stop();
		}
		
		public function wallAvoidanceOn( walls:Vector.<IGameEntity> ):void
		{
			_wallAvoidance.start( walls );
		}
		
		public function wallAvoidanceOff():void
		{
			_wallAvoidance.stop();
		}
		
		public function rotateOn( target:IGameEntity ):void
		{
			_rotate.start( target );
		}
		
		public function rotateOff():void
		{
			_rotate.stop();
		}
		
		public function obstacleOvoidanceOn( obstacles:Vector.<IGameEntity> ):void
		{
			_obstacleOvoidance.start( obstacles );
		}
		
		public function obstacleOvoidanceOff():void
		{
			_obstacleOvoidance.stop();
		}
		
		public function interposeOn( entity1:IGameEntity, entity2:IGameEntity ):void
		{
			_interpose.start( entity1, entity2 );
		}
		
		public function interposeOff():void
		{
			_interpose.stop();
		}
		
		public function hideOn( fromEntity:IGameEntity, obstaclesToUse:Vector.<IGameEntity> ):void
		{
			_hide.start( fromEntity, obstaclesToUse );
		}
		
		public function hideOff():void
		{
			_hide.stop();
		}
		
		public function evadeOn( pursuer:IGameMovingEntity ):void
		{
			_evade.start( pursuer );
		}
		
		public function evadeOff():void
		{
			_evade.stop();
		}
		
		public function cohesionOn( neighbors:Vector.<IGameEntity> ):void
		{
			_cohesion.start( neighbors );
		}
		
		public function cohesionOff():void
		{
			_cohesion.stop();
		}
		
		public function arriveOn( location:Vector2D, howFast:Number ):void
		{
			_arrive.start( location, howFast );
		}
		
		public function arriveOff():void
		{
			_arrive.stop();
		}
		
		public function alignmentOn( neighbors:Vector.<IGameEntity>y ):void
		{
			_alignment.start( neighbors );
		}
		
		public function alignmentOff():void
		{
			_alignment.stop();
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
