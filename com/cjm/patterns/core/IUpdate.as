package com.cjm.game.core 
{
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IUpdate 
	{
		public function get onUpdate:ISignal;
		public function update( ...params ):Boolean
	}
	
}