package com.cjm.game.weapon 
{
	import com.cjm.game.core.GameSystem;
	import com.cjm.game.core.IGameEntity;
	import com.cjm.game.core.IGameWorld;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class WeaponSystem extends GameSystem
	{
		protected var _owner:IGameEntity;
		
		public function WeaponSystem( owner:IGameEntity ) 
		{
			super( owner.getWorld() )
			
			_owner = owner;
		}
		
		override public function initialize():void
		{
			//Targeting system
		}
		
		public function changeWeapon( type:uint )
		{
			
		}
	}

}