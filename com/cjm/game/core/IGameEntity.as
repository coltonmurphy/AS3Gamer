package com.cjm.game.core 
{
	import com.cjm.math.geom.Vector2D;
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
		function initialize( ):void;//Scalable, systems, variable sets, called in construction
		
		function render(...params):void;
		function getWorld():IGameWorld;

		function isToBeRemoved():Boolean;
		function remove( ):void;
		function destroy( ):void;
		function isAlive( ):void;
		
		function isTagged():Boolean;
		function setTagged(t:Boolean):void;
		
		function setMass(m:uint):Boolean;
		function getMass():uint;

		function setScale(s:Number):void
		function getScale():Number;

		function setPosition(v:Vector2D):void
		function getPosition():Vector2D;
		
		function setRadius(b:Number):void
		function getRadius(b):Number;
		
		function getDistance(s:Vector3D):Number
	}
}