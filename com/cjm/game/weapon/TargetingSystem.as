package com.cjm.game.weapon 
{
	import com.cjm.game.core.GameSystem;
	import com.cjm.game.core.IGameEntity;
	import com.cjm.game.core.IGameWorld;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class TargetingSystem extends GameSystem 
	{
		
		public function TargetingSystem(world:IGameWorld) 
		{
			super(world);
			
		}
		
		//Returns true is target is assigned
		public function isTargetPresent():Boolean
		{
			
		}
		
		public function isTargetWithinRange():Boolean
		{
			
		}
		
		//Line of sight
		public function isTargetShootable():Boolean
		{
			
		}
		
		public function getLastRecordedPosition():Vector3D
		{
			
		}
		
		public function getTimeTargetHasBeenVisible():Number
		{
			
		}
		
		public function getTimeTargetHasBeenOutOfRange():Number
		{
			
		}
		
		public function getTarget():IGameEntity
		{
			
		}
		
		public function clearTarget():void
		{
			
		}
		
	}

}