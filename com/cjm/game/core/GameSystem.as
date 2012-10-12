package com.cjm.game.core 
{
	import com.cjm.game.event.GameSignal;
	import org.osflash.signals.ISignal;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class GameSystem implements IGameSystem 
	{
		protected var _active:Boolean;
		protected var _list:Vector.<IGameEntity>;
		protected var _world:IGameWorld   = null;
		
		public function GameSystem( world:IGameWorld ) 
		{
			_world = world;
			_active = false;
		}
		
		/* INTERFACE com.cjm.game.core.IGameSystem */
		public function initialize(  ):void 
		{
	
		}
		
		//Used for game entity update and removal
		public function update( time:Number ):void 
		{

		
		}
		
		public function getWorld():IGameWorld
		{
			return _world;
		}

		public function setActive(b:Boolean):void 
		{
			_active = b;
		}
		
		public function getActive():Boolean 
		{
			return _active;
		}

		
		
		
		public function destroy( ):void 
		{
			_active = null;
		}
	}
}