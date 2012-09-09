package com.cjm.game.core 
{
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IGameWorld extends IUpdate implements ITick, IRun
	{
		public function initialize():void
		public function render( ...params ):void;
		public function tick( ...param ):void;
		public function run():Boolean;
		public function pause():Boolean;
		
		//Tag for processing
		public function tagObstaclesWithinViewRange( ige:IGameEntity, range:Number ):Boolean;
		
		//Calculate point to local space
		public function pointToLocalSpace( obstaclePos:Vector3D, myHeading:Number, mySide:Vector3D, myPos:Vector3D ):Vector3D;
		public function pointToGlobalSpace( obstaclePos:Vector3D, myHeading:Number, mySide:Vector3D, myPos:Vector3D ):Vector3D;
	}
	
}