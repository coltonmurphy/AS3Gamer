package com.cjm.game.ai.pathfinding 
{
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IPath 
	{
		public function setPath( vs:Vector.<Vector3D> ):Boolean;
		public function getPath( ):Vector.<Vector3D>;
	}
	
}