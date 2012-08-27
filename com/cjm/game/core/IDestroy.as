package com.cjm.game.core
{
	import org.osflash.signals.ISignal;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IDestroy 
	{
		public function get onDestroy:ISignal;
		public function destroy():void
	}

}