package com.cjm.game.core 
{
	import flash.geom.Vector3D;
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
		protected var _turnRate:Number				    = 10;
		protected var _velocity:Vector3D				= new Vector3D();
		protected var _heading:Vector3D				    = new Vector3D();
		
		
		public function GameMovingEntity() 
		{
			super();
			
		}
		
		/* INTERFACE com.cjm.game.core.IGameMovingEntity */
		
		public function get onSetVelocity():ISignal 
		{
			return _onSetVelocity;
		}
		
		public function setVelocity(v:Vector3D):Boolean 
		{
			_velocity = v;
		}
		
		public function getVelocity():Vector3D 
		{
			return _velocity;
		}
		
		public function get onSetHeading():ISignal 
		{
			return _onSetHeading;
		}
		
		public function setHeading(v:Vector3D):Boolean 
		{
			_heading - v;
		}
		
		public function getHeading():Vector3D 
		{
			return _heading;
		}
		
		public function get onSetMaxSpeed():ISignal 
		{
			return _onSetMaxSpeed;
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
		
		public function get onSetMaxForce():ISignal 
		{
			return _onSetMaxForce;
		}
		
		public function setMaxForce(f:uint):Boolean 
		{
			_maxForce = f
		}
		
		public function getMaxForce():uint 
		{
			return _maxForce
		}
		
		public function get onSetTurnRate():ISignal 
		{
			return _onSetTurnRate;
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