package com.cjm.game.core 
{
	import com.cjm.math.geom.Vector2D;
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
		protected var _maxTurnRate:Number				    = 10;
		protected var _turnRate:Number				    = 10;
		protected var _velocity:Vector2D				= new Vector2D();
		protected var _heading:Vector2D				    = new Vector2D();
		protected var _side:Vector2D
		
		public function GameMovingEntity() 
		{
			super();
			
		}
		//Set your current velocity by Vector
		public function setVelocity(v:Vector2D):Boolean 
		{
			_velocity = v;
		}
		
		public function getVelocity():Vector2D 
		{
			return _velocity;
		}
		
		
		public function setHeading(v:Vector2D):Boolean 
		{
			_heading - v;
		}
		
		public function getHeading():Vector2D 
		{
			return _heading;
		}
		
		public function setMaxSpeed(s:uint):Boolean 
		{
			_maxSpeed = s;
		}
		
		public function getMaxSpeed():uint 
		{
			return _maxSpeed;
		}
		
		public function get onSetSpeed():ISignal 
		{
			return _onSetSpeed;
		}
		
		public function setSpeed(s:uint):Boolean 
		{
			_speed = s;
		}
		
		public function getSpeed():uint 
		{
			return _speed;
		}

		public function setMaxForce(f:uint):Boolean 
		{
			_maxForce = f
		}
		
		public function getMaxForce():uint 
		{
			return _maxForce
		}
		
		
		public function setTurnRate(t:uint):Boolean 
		{
			_turnRate = t
		}
		
		public function getTurnRate():uint 
		{
			return _turnRate;
		}

	}
}