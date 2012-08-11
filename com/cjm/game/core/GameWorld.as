package com.cjm.game.core 
{
	import flash.geom.Vector3D;
	import org.osflash.signals.ISignal;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class GameWorld implements IGameWorld 
	{
		
		public function GameWorld() 
		{
			
		}
		
		/* INTERFACE com.cjm.game.core.IGameWorld */
		
		public function getInstance():IGameWorld 
		{
			
		}
		
		public function initializeSystems(...params):Boolean 
		{
			
		}
		
		public function render(...params):void 
		{
			
		}
		
		public function tick(...param):void 
		{
			
		}
		
		public function run():Boolean 
		{
			
		}
		
		public function pause():Boolean 
		{
			
		}
		
		public function draw():Boolean 
		{
			
		}
		
		public function tagObstaclesWithinViewRange(ige:IGameEntity, range:Number) 
		{
			
		}
		
		public function get onSetMass():ISignal 
		{
			return _onSetMass;
		}
		
		public function setMass(m:uint):Boolean 
		{
			
		}
		
		public function getMass():uint 
		{
			
		}
		
		public function get onSetScale():ISignal 
		{
			return _onSetScale;
		}
		
		public function setScale(s:Number):void 
		{
			
		}
		
		public function getScale():Number 
		{
			
		}
		
		public function get onSetPosition():ISignal 
		{
			return _onSetPosition;
		}
		
		public function setPosition(v:Vector3D):void 
		{
			
		}
		
		public function getPosition():Vector3D 
		{
			
		}
		
		public function get onSetRadius():ISignal 
		{
			return _onSetRadius;
		}
		
		public function setRadius(b:Number):void 
		{
			
		}
		
		public function getRadius(b):Number 
		{
			
		}
		
		public function getDistance(s:Vector3D):Number 
		{
			
		}
		
		public function get onUpdate():ISignal 
		{
			return _onUpdate;
		}
		
		public function update(b):Number 
		{
			
		}
		
		public function getType():String 
		{
			
		}
		
		public function setType(t:String):void 
		{
			
		}
		
		public function destroy():void 
		{
			
		}
		
		public function getID():String 
		{
			
		}
		
		public function setID(id:String):void 
		{
			
		}
		
	}

}