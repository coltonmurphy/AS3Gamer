package com.cjm.game.core 
{
	import flash.geom.Vector3D;
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IGameMovingEntity extends IGameEntity
	{
		public function get onSetVelocity:ISignal;
		public function setVelocity(v:Vector3D):Boolean;
		public function getVelocity():Vector3D;
		
		public function get onSetHeading:ISignal;
		public function setHeading(v:Vector3D):Boolean;
		public function getHeading():Vector3D;
		
		public function get onSetMass:ISignal;
		public function setMass(m:uint):Boolean;
		public function getMass():uint;
		
		public function get onSetMaxSpeed:ISignal;
		public function setMaxSpeed(s:uint):Boolean;
		public function getMaxSpeed():uint;
		
		public function get onSetSpeed:ISignal;
		public function setSpeed(s:uint):Boolean;
		public function getSpeed():uint;
		
		public function get onSetMaxForce:ISignal;
		public function setMaxForce(g:uint):Boolean;
		public function getMaxForce():uint;
	
		public function get onSetTurnRate:ISignal;
		public function setTurnRate(g:uint):Boolean;
		public function getTurnRate():uint;
	}
	
}