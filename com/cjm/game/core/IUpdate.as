package com.cjm.game.core 
{
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IUpdate 
	{
		public function get updateSignal:ISignal;
		public function update( ...params ):Boolean
	}
	
}