package com.cjm.game.core 
{
	import com.cjm.patterns.core.IEntity;
	import com.cjm.patterns.core.IUpdate;
	import flash.geom.Vector3D;
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IGameEntity extends IEntity
	{
		public function getGameWorld():IGameWorld;
		
		public function initializeSystems( ...params ):Boolean;
		
		public function get onSetTagged:ISignal;
		public function isTagged():Boolean;
		public function setTagged(t:Boolean):void;
		
		public function get onSetMass:ISignal;
		public function setMass(m:uint):Boolean;
		public function getMass():uint;
		
		public function get onSetScale:ISignal;
		public function setScale(s:Number):void
		public function getScale():Number;
	
		public function get onSetPosition:ISignal;
		public function setPosition(v:Vector3D):void
		public function getPosition():Vector3D;
		
		public function get onSetRadius:ISignal;
		public function setRadius(b:Number):void
		public function getRadius(b):Number;
		
		public function getDistance(s:Vector3D):Number
		
		public function get onUpdate:ISignal;
		public function update(b):Number
	}
	
}