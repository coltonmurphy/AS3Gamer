package com.cjm.game.core 
{
	import com.cjm.math.geom.Vector2D;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IGameWorld extends IUpdate implements ITick, IRun
	{
		function initialize():void
		function render( ...params ):void;
		function tick( ...param ):void;
		function run():Boolean;
		function pause():Boolean; 
		
		//Tag for processing
		function tagObstaclesWithinViewRange( ige:IGameEntity, range:Number ):Boolean;
	}
	
}