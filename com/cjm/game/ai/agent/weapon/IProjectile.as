package com.cjm.game.ai.agent.weapon 
{
	import com.cjm.game.core.IGameEntity;
	import com.cjm.game.core.IGameMovingEntity;
	import flash.geom.Vector3D;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IProjectile extends IGameMovingEntity
	{
		public function onSetTarget:ISignal;
		public function setTarget(t:Vector3D);
		public function getTarget():Vector3D;
		public function getOrigin():Vector3D;
		
		public function onMaxDamage:ISignal;
		public function setMaxDamage( max:uint ):Boolean;
		public function getMaxDamage():uint;
		
		public function onSetDamageRadius:ISignal;
		public function setDamageRadius( max:uint ):Boolean;
		public function getDamageRadius():uint;

		public function onCollision:ISignal;
		public function getCollisionPoint():Vector3D;
	}
	
}