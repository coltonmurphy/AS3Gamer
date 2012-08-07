package com.cjm.game.core 
{
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface ITick 
	{
		public function get onTick:ISignal;
		public function tick( amt:uint ):void
	}
	
}