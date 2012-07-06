package com.cjm.game.core 
{
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IRender 
	{
		public function get onRender:ISignal;
		public function render(...params):void
	}
	
}