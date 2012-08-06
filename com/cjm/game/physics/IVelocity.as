package com.cjm.game.physics 
{
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IVelocity 
	{
		public function getVector():Vector3D;
		public function invert():void;
		public function setSpeed();
		public function getSpeed();
		public function setDirection( rad:Number ):void;
		public function getDirection():Number;
	}
	
}