package com.cjm.game.ai.agent
{
	/**
	 * ...
	 * @author Colton Murphy
	 */

	import com.cjm.game.ai.agent.state.AgentState;
	import com.cjm.game.ai.agent.state.AgentStateMachine;
	import com.cjm.game.ai.behaviors.steering.SteeringSystem;
	import com.cjm.game.core.IGameWorld;
	import com.cjm.game.weapon.TargetingSystem;
	import com.cjm.pathfinding.PathPlanner;
	import com.cjm.game.core.GameMovingEntity;
	import com.cjm.game.weapon.WeaponSystem;
	import com.cjm.math.geom.Matrix2D;
	import com.cjm.math.geom.Vector2D;
	import com.cjm.math.MathUtil;
	import flash.display.Shape;

	
	public class Agent extends GameMovingEntity implements IAgent
	{
		//systems
		protected var _steeringSystem:SteeringSystem;
		protected var _weaponSystem:WeaponSystem;
		protected var _pathPlanner:PathPlanner;
		protected var _stateMachine:AgentStateMachine;
		protected var _targetingSystem:TargetingSystem;
		
	    //the agent's health. Every time the agent is shot this value is decreased. If
	    //it reaches zero then the agent dies (and respawns)
	    protected var _health:int;
	  
	    //the bot's maximum health value. It starts its life with health at this value
	    protected var _maxHealth:int;

	    //each time this agent kills another this value is incremented
	    protected var _score:int;

	    //a agent only perceives other agents within this field of view
	    protected var _fieldOfView:Number;
	  
		//to show that a player has been hit it is surrounded by a thick 
		//red circle for a fraction of a second. This variable represents
		//the number of update-steps the circle gets drawn
		protected var _numUpdatesHitPersistant:int;

		//set to true when the bot is hit, and remains true until 
		//_numUpdatesHitPersistant becomes zero. (used by the render method to
		//draw a thick red circle around a bot to indicate it's been hit)
		protected var _hit:Boolean;

	    //a vertex buffer containing the bot's geometry
	    protected var _vecVB:Vector.<Vector2D>;
		
	    //the buffer for the transformed vertices
	    protected var _vecVBTrans:Vector.<Vector2D> ;
		
		public function Agent( position:Vector2D, 
							   radius:uint       = 1, 
							   velocity          = new Vector2D(0,0),
							   maxSpeed          = 3,
							   heading           = new Vector2D(1,0),
							   mass:uint         = 1,
							   scale:Vector2D    = new Vector2D(1,1), 
							   turnRate:Number   = 5,
							   maxForce:Number   = 5 )
		{
			super( world, position, radius, 
				   velocity, maxSpeed, heading, 
				   mass, turnRate, maxForce );
			
		    _score = 0;
            _maxHealth = 100;
			_hit = false;
			
		    setUpVertexBuffer();
		  
		    //create the goal queue
		    //m_pBrain = new Goal_Think(this);

			_stateMachine    = AgentStateMachine.getInstance();
			_pathPlanner     = new PathPlanner( this );	
			_steeringSystem  = new SteeringSystem( this );
			_weaponeSystem   = new WeaponSystem( this, reactionTime, aimAccuracy, aimPersistance );
			_targetingSystem = new TargetingSystem( this )
		}
		
		
		
		public function update(timeElapsed:Number):void
		{
			updateMovement(timeElapsed);
		}
		
		protected function updateMovement(timeElapsed:Number):void
		{
			//Get steering force
			///Force = Mass*Acceleration
			var steeringForce:Vector2D = _steeringSystem.calculate();
		
			if ( steeringForce.isZero())
			{
			    var brakingRate = 0.8; 

				_velocity.scaleBy( brakingRate );                                     
			}
			
			///Acceleration = Force / Mass
			var acceleration: Vector2D = steeringForce.divideBy( getMass() );
			
			_velocity.add( acceleration.scaleBy( timeElapsed ) );
			
			//Cap the speed
			_velocity.truncate( _maxSpeed );
			
			//Update coordinate location
			_position.add( _velocity.scaleBy( timeElapsed ) );
			
			//Update heading if moving
			if ( _velocity.lengthSquared > 0.00000001 )
			{
				setHeading( _velocity.normalize() );
				
				_side = _heading.getPerp();
			}
		}
		
		override public function render(...context):void
		{
			if ( _visible && null == _view)
			{
				var parentView:DisplayObject = context[0] as DisplayObject;
				_view = getView();
				_view.graphics.lineStyle(1, 1);
				_view.graphics.beginFill(0xC4FB89);
				_view.graphics.drawCircle(0, 0, 1);
				_view.graphics.endFill();
				_view.x = _position.x;
				_view.y = _position.y;
				parentView.addChild(_view);
			}	
		}
		
		
		
		
		
		public function reduceHealth( val:uint ):void
		{
		    _health -= val;

		    if (  _health <= 0 )
		    {
			    setDead();
		    }

		    _hit = true;

		    //m_iNumUpdatesHitPersistant = (int)(FrameRate * script->GetDouble("HitFlashTime"));
		}


		//----------------------- ChangeWeapon ----------------------------------------
		public function changeWeapon( type:uint ):void
		{
		    _weaponSystem.changeWeapon( type );
		}
		  
		//---------------------------- FireWeapon -------------------------------------
		//
		//  fires the current weapon at the given position
		//-----------------------------------------------------------------------------
		public function fireWeapon( pos:Vector2D ):void
		{
		    _weaponSystem.shootAt( pos );
		}

		//----------------- CalculateExpectedTimeToReachPosition ----------------------
		//
		//  returns a value indicating the time in seconds it will take the bot
		//  to reach the given position at its current speed.
		//-----------------------------------------------------------------------------
		public function calculateTimeToReachPosition( pos:Vector2D ):void
		{
		    return Vector2D.Vec2DDistance(getPosition(), pos) / (getMaxSpeed() * 30/*FrameRate*/);
		}
		
		//------------------------- hasLOSt0 ------------------------------------------
		//
		//  returns true if the bot has line of sight to the given position.
		//-----------------------------------------------------------------------------
		public function hasLOSto(pos:Vector2D):Boolean
		{
		    return _world.isLOSOkay(_position, pos);
		}

		//returns true if this bot can move directly to the given position
		//without bumping into any walls
		public function canWalkTo(pos:Vector2D):Boolean
		{
		    return !_world.isPathObstructed(_position, pos, _radius);
		}
		
		//similar to above. Returns true if the bot can move between the two
		//given positions without bumping into any walls
		public function canWalkBetween( from:Vector2D,  to:Vector2D):Boolean
		{
		    return !_world.isPathObstructed(from, to, _radius);
		}
		
		
		//--------------------------- canStep Methods ---------------------------------
		//
		//  returns true if there is space enough to step in the indicated direction
		//  If true PositionOfStep will be assigned the offset position
		//-----------------------------------------------------------------------------
		public function canStepLeft( positionOfStep:Vector2D ):Boolean
		{
		    var stepDistance:Number = getRadius() * 2;

			var scalar:Vector2D = getFacing().getPerp().subtractBy( stepDistance ).scaleBy( getRadius() );
		    positionOfStep = getPosition().subtract(getFacing().getPerp()).multiply(scalar);

		    return canWalkTo( positionOfStep );
		}

		public function canStepRight( positionOfStep:Vector2D ):Boolean
		{
		    var stepDistance:Number = getRadius() * 2;

			var scalar:Vector2D = getFacing().getPerp().addBy( stepDistance ).scaleBy( getRadius() );
		    positionOfStep = getPosition().add( getFacing().getPerp() ).multiply( scalar ) ;
		    return canWalkTo( positionOfStep );
		}
		
		
		public function canStepForward(positionOfStep:Vector2D):Boolean
		{
		    var stepDistance:Number = getRadius() * 2;

			// PositionOfStep = Pos() + Facing() * StepDistance + Facing() * BRadius();
			//TODO: Order of operations should be, stepDistance - facing
			var scalar:Vector2D = getFacing().addBy( stepDistance ).scaleBy( getRadius() );
		    var positionOfStep  = getPosition().add( getFacing() ).multiply( scalar ) //* stepDistance + getFacing() * getRadius();

		    return canWalkTo( positionOfStep );
		}

		public function canStepBackward(positionOfStep:Vector2D):Boolean
		{
			var stepDistance:Number = getRadius() * 2;

			//PositionOfStep = Pos() - Facing() * StepDistance - Facing() * BRadius();
			//TODO: Use facing and not heading
			var scalar = getFacing().subtractBy( stepDistance ).scaleBy( getRadius() );
			var positionOfStep:Vector2D = getPosition().subtract(getFacing()).multiply( scalar );

			return canWalkTo( positionOfStep );
		}

		public function changeState( state:IState ):void
		{
			_state = state;
		}
		
		public function getHealth():uint 
		{
			return _health;
		}
		
		public function setHealth(value:Number):void 
		{
			_health = value;
		}

		// If health > damage we are still kicking
		public function isAlive( ):Boolean
		{
			return _health == 0;
		};
	}

}