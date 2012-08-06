package com.cjm.game.physics 
{
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Velocity implements IVelocity 
	{
		private var _dir:Number;//Radians
        private var _speed:Number;
		
		public function Velocity() 
		{
			
		}
		
		/* INTERFACE com.cjm.game.physics.IVelocity */
		
		public function getVector():Vector3D 
		{
			
		}
		
		public function invert():void 
		{
			_dir += Math.PI; 
			_dir %= ( Math.PI * 2 );
		}
		
		public function getSpeed() 
		{
			
		}
		
		public function setDirection(rad:Number):void 
		{
			
		}
		
		public function getDirection():Number 
		{
			
		}
		
	}

}