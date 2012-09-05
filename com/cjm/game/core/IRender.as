package com.cjm.game.core 
{
	import com.cjm.game.event.GameSignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IRender 
	{
		public function get renderSignal:GameSignal;
		public function render(...params):void
	}
	
}