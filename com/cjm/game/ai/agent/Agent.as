package com.cjm.game.ai.agent
{
	/**
	 * ...
	 * @author Colton Murphy
	 */

	import com.cjm.game.ai.agent.state.AgentState;
	import com.cjm.game.ai.agent.state.AgentStateMachine;
	import com.cjm.game.ai.behaviors.steering.SteeringSystem;
	import com.cjm.game.ai.pathfinding.PathFinderSystem;
	import com.cjm.game.ai.pathfinding.PathPlanner;
	import com.cjm.game.core.GameMovingEntity;
	import com.cjm.game.weapon.WeaponSystem;
	import com.cjm.math.geom.Matrix2D;
	import com.cjm.math.geom.Vector2D;
	import com.cjm.math.MathUtil;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;

	
	public class Agent extends GameMovingEntity implements IAgent
	{
		//systems
		protected var _steeringSystem:SteeringSystem;
		protected var _weaponSystem:WeaponSystem;
		protected var _pathPlanner:PathPlanner;
		protected var _stateMachine:AgentStateMachine;
		protected var _alive:Boolean                    = false;
		protected var _defense:Number					= 1;
		protected var _offense:Number					= 1;
		protected var _life:Number    					= 1;
		protected var _intellegence:Number				= 1;
		protected var _awareness:Number;				= 1//line of sight radius
		protected var _view:Shape						= new Rectangle(1,1,1,1);
	    
		
		public function Agent( id :String ) 
		{
			super( id );
		
		}
		
		override public function initialize():void
		{
			//Initialize systems
			_stateMachine = AgentStateMachine.getInstance();
			_steeringSystem = new SteeringSystem( this );
			_weaponeSystem = new WeaponSystem( this );
			_pathPlanner   = new PathPlanner( this );
			
			_facing = _heading.clone();
		}
		
		public function update(timeElapsed:Number):void
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
		
		public function rotateFacingTowardPosition(target:Vector2D ):Boolean
		{
		    var toTarget:Vector2D = Vector2D.Vec2DNormalize(target.subtract( _position ));

		    var dot:Number = _facing.getDot(toTarget);//TODO:use heading?

		    //clamp to rectify any rounding errors
		    MathUtil.clamp(dot, -1, 1);

		    //determine the angle between the heading vector and the target
		    var angle:Number = Math.acos(dot);

		    //return true if the bot's facing is within WeaponAimTolerance degs of
		    //facing the target
		    var weaponAimTolerance:Number = 0.01; //2 degs approx

		    if (angle < weaponAimTolerance)
		    {
			  _facing = toTarget;
			  return true;
		    }

		    //clamp the amount to turn to the max turn rate
		    if ( angle > _maxTurnRate ) angle = _maxTurnRate;
		  
		    //The next few lines use a rotation matrix to rotate the player's facing
		    //vector accordingly
		    var mat:Matrix2D = new Matrix2D();
		  
		    //notice how the direction of rotation has to be determined when creating
		    //the rotation matrix
		    mat.rotate(angle * _facing.getSign(toTarget));	
		    mat.transformVector2D(_facing);

		    return false;
		}
		
		public function isAtPosition( pos:Vector2D):Boolean
		{
		    var tolerance:Number = 10;
		  
		     return Vector2D.Vec2DDistanceSq(_position, pos) < _radius;
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
		public function canWalkTo(pos:Vector2D)const
		{
		  return !_world.isPathObstructed(_position, pos, _radius);
		}
		
		//similar to above. Returns true if the bot can move between the two
		//given positions without bumping into any walls
		public function canWalkBetween( from:Vector2D,  to:Vector2D)const
		{
		 return !_world.isPathObstructed(from, to, _radius);
		}
		
		public function changeState( state:IState ):void
		{
			_state = state;
		}
		
		
		public function getDefense():Number 
		{
			return _defense;
		}
		
		public function setDefense(value:Number):void 
		{
			_defense = value;
		}
		
		public function getOffense():Number 
		{
			return _offense;
		}
		
		public function setOffense(value:Number):void 
		{
			_offense = value;
		}
		
		public function getLife():Number 
		{
			return _life;
		}
		
		public function setLife(value:Number):void 
		{
			_life = value;
		}
		
		public function getAwareness():Number 
		{
			return _awareness;
		}
		
		public function setAwareness(value:Number):void 
		{
			_awareness = value;
		}
		
		public function get view():* 
		{
			return _view;
		}
		
		public function set view(value:*):void 
		{
			_view = value;
		}
		
		public function getIntellegence():Number 
		{
			return _intellegence;
		}
		
		public function setIntellegence(value:Number):void 
		{
			_intellegence = value;
		}
		
		// If health > damage we are still kicking
		public function isAlive( ):Boolean
		{
			return _alive;
		};
	}

}