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
		protected var _updateSignal:GameSignal;
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
		
		public function getEntities():Vector.<IGameEntity> 
		{
			return _list;
		}
		
		public function addEntity(e:IGameEntity):Vector.<IGameEntity> 
		{
			_list.push(e);
		}
		
		public function get updateSignal():GameSignal 
		{
			return _updateSignal;
		}
		
		//Used for game entity update and removal
		public function update( time:Number ):void 
		{
			for each( item:IGameEntity in _list )
			{
				if ( item.isToBeRemoved())
					 item.destroy();
				else
					item.update( time )
			}
			
			_updateSignal.dispatch( time )
		}
		
		public function destroy( ):void 
		{
			while( item:IGameEntity = _list.pop() )
			{
				item.destroy();
			}
			
			_list = null;
			_active = null;
			_updateSignal = null;
		}
	}
}