package com.cjm.game.core 
{
	import com.cjm.math.geom.Matrix2D;
	import com.cjm.math.geom.Vector2D;
	import com.cjm.math.MathUtil;
	import flash.geom.Vector2D;
	import org.osflash.signals.ISignal;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class GameMovingEntity extends GameEntity implements IGameMovingEntity 
	{
		protected var _speed:Number						= 0;
		protected var _maxSpeed:Number				    = 10;
		protected var _maxForce:Number				    = 10;
		protected var _maxTurnRate:Number				= 10;
		protected var _turnRate:Number				    = 10;
		protected var _velocity:Vector2D				= new Vector2D();
		protected var _heading:Vector2D				    = new Vector2D();
		protected var _side:Vector2D
		protected var _facing:Vector2D;
		
		public function GameMovingEntity( world:IGameWorld, 
									      position:Vector2D, 
									      radius:uint       = 1, 
										  velocity          = new Vector2D(0,0),
										  maxSpeed          = 3,
										  heading           = new Vector2D(1,0),
										  mass:uint         = 1
										  scale:Vector2D    = ew Vector2D(1,1) 
										  turnRate:Number   = 5,
										  maxForce:Number   = 5)
									     
   
		{
			super( world, position, radius, scale,  mass );
			
			_facing = _heading.clone();
			_side = _heading.getPerp();    
                 
		}
		
		//Set your current velocity by Vector
		public function setVelocity(v:Vector2D):void 
		{
			_velocity = v;
		}
		
		public function getVelocity():Vector2D 
		{
			return _velocity;
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

		    if ( angle < weaponAimTolerance )
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
		
		public function setHeading(v:Vector2D):void 
		{
			_heading - v;
			
			_side = _heading.getPerp();
		}
		
		public function getHeading():Vector2D 
		{
			return _heading;
		}
		
		public function setFacing(val:Vector2D):void
		{
			_facing = val;
		};
		public function getFacing():Vector2D
		{
			return _facing;
		};
		
		public function setMaxSpeed(s:uint):void 
		{
			_maxSpeed = s;
		}
		
		public function getMaxSpeed():uint 
		{
			return _maxSpeed;
		}
		
		public function setSpeed(s:uint):Boolean 
		{
			_speed = s;
		}
		
		public function getSpeed():uint 
		{
			return _speed;
		}

		public function setMaxForce(f:uint):void 
		{
			_maxForce = f
		}
		
		public function getMaxForce():uint 
		{
			return _maxForce
		}

		public function setTurnRate(t:uint):void 
		{
			_turnRate = t
		}
		
		public function getTurnRate():uint 
		{
			return _turnRate;
		}
	}
}