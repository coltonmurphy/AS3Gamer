package com.cjm.game.trigger 
{
	import com.cjm.game.core.GameSystem;
	import com.cjm.game.core.IGameWorld;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class TriggerSystem extends GameSystem 
	{
		public function TriggerSystem( w:IGameWorld ) 
		{
			super( w );
		}
		
		override public function update( time:Number ):void 
		{
			super.update( time );//update triggers
			
			//Try eligeable triggers
			for each( t:ITrigger in _list )
			{
				if ( t.isReadyForUpdate() && t.isAlive() )
					 t.doTry();
			}
		}
		
		override public function render(...params):void
		{
			//Render visible triggers
		}
	}
}