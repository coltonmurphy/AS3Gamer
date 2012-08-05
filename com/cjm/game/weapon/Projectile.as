package com.cjm.game.weapon 
{
	import flash.geom.Vector3D;
	import org.osflash.signals.ISignal;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Projectile implements IProjectile 
	{
		private var _onSetTarget:ISignal;
		private var _onSetVelocity:ISignal;
		private var _target:Vector3D;
		private var _origin:Vector3D;
		private var _maxDamage:Number;
		
		public function Projectile() 
		{
			
		}
		
		/* INTERFACE com.cjm.game.ai.agent.weapon.IProjectile */
		
		public function get onSetTarget():ISignal 
		{
			return _onSetTarget;
		}
		
		public function setTarget(t:Vector3D) 
		{
			_onSetTarget.dispatch(_target,t);
			
			_target = t
		}
		
		public function getTarget():Vector3D 
		{
			return _target;
		}
		
		public function getOrigin():Vector3D 
		{
			return _origin;
		}
		
		public function get onSetMaxDamage():ISignal 
		{
			return _onSetMaxDamage;
		}
		
		public function setMaxDamage(max:uint):Boolean 
		{
			return _onSetTarget;
		}
		
		public function getMaxDamage():uint 
		{
			
		}
		
		public function onSetDamageRadius():ISignal 
		{
			
		}
		
		public function setDamageRadius(max:uint):Boolean 
		{
			
		}
		
		public function getDamageRadius():uint 
		{
			
		}
		
		public function onCollision():ISignal 
		{
			
		}
		
		public function getCollisionPoint():Vector3D 
		{
			
		}
		
		public function get onSetVelocity():ISignal 
		{
			return _onSetVelocity;
		}
		
		public function setVelocity(v:Vector3D):Boolean 
		{
			
		}
		
		public function getVelocity():Vector3D 
		{
			
		}
		
		public function get onSetHeading():ISignal 
		{
			return _onSetHeading;
		}
		
		public function setHeading(v:Vector3D):Boolean 
		{
			
		}
		
		public function getHeading():Vector3D 
		{
			
		}
		
		public function get onSetMass():ISignal 
		{
			return _onSetMass;
		}
		
		public function setMass(m:uint):Boolean 
		{
			
		}
		
		public function getMass():uint 
		{
			
		}
		
		public function get onSetMaxSpeed():ISignal 
		{
			return _onSetMaxSpeed;
		}
		
		public function setMaxSpeed(s:uint):Boolean 
		{
			
		}
		
		public function getMaxSpeed():uint 
		{
			
		}
		
		public function get onSetSpeed():ISignal 
		{
			return _onSetSpeed;
		}
		
		public function setSpeed(s:uint):Boolean 
		{
			
		}
		
		public function getSpeed():uint 
		{
			
		}
		
		public function get onSetMaxForce():ISignal 
		{
			return _onSetMaxForce;
		}
		
		public function setMaxForce(g:uint):Boolean 
		{
			
		}
		
		public function getMaxForce():uint 
		{
			
		}
		
		public function get onSetTurnRate():ISignal 
		{
			return _onSetTurnRate;
		}
		
		public function setTurnRate(g:uint):Boolean 
		{
			
		}
		
		public function getTurnRate():uint 
		{
			
		}
		
		public function get onSetScale():ISignal 
		{
			return _onSetScale;
		}
		
		public function get onSetPosition():ISignal 
		{
			return _onSetPosition;
		}
		
		public function get onSetRadius():ISignal 
		{
			return _onSetRadius;
		}
		
		public function get onUpdate():ISignal 
		{
			return _onUpdate;
		}
		
		public function setScale(s:Number):void 
		{
			
		}
		
		public function getScale():Number 
		{
			
		}
		
		public function setPosition(v:Vector3D):void 
		{
			
		}
		
		public function getPosition():Vector3D 
		{
			
		}
		
		public function setRadius(b:Number):void 
		{
			
		}
		
		public function getRadius(b):Number 
		{
			
		}
		
		public function update(b):Number 
		{
			
		}
		
		public function getType():String 
		{
			
		}
		
		public function setType(t:String):void 
		{
			
		}
		
		public function destroy():void 
		{
			
		}
		
		public function getID():String 
		{
			
		}
		
		public function setID(id:String):void 
		{
			
		}
		
	}

}