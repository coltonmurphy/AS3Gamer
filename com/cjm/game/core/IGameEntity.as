package com.cjm.game.core 
{
	import com.cjm.patterns.core.IEntity;
	import com.cjm.patterns.core.IUpdate;
	import flash.display.DisplayObject;
	import flash.geom.Vector3D;
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IGameEntity extends IUpdate implements IRender
	{
		protected function initialize(  ):void;//Scalable, systems, variable sets, called in construction
		
		public function render(...params):void;
		public function getGameWorld():IGameWorld;
		
		
		public function isToBeRemoved():Boolean;
		public function remove( ):void;
		public function destroy( ):void;
		public function isAlive( ):void;
		
		public function get taggedSignal:ISignal;
		public function isTagged():Boolean;
		public function setTagged(t:Boolean):void;
		
		public function get massSignal:ISignal;
		public function setMass(m:uint):Boolean;
		public function getMass():uint;
		
		public function get scaleSignal:ISignal;
		public function setScale(s:Number):void
		public function getScale():Number;
	
		public function get positionSignal:ISignal;
		public function setPosition(v:Vector3D):void
		public function getPosition():Vector3D;
		
		public function get radiusSignal:ISignal;
		public function setRadius(b:Number):void
		public function getRadius(b):Number;
		
		public function getDistance(s:Vector3D):Number
		
		public function get updateSignal:ISignal;
		public function update(b):Number
	}
	
}