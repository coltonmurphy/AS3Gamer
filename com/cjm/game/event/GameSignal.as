package com.cjm.game.event 
{
	import org.osflash.signals.ISignal;
	import org.osflash.signals.ISlot;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class GameSignal extends Signal implements ISignal 
	{
		public function GameSignal(...valueClasses) 
		{
			super(valueClasses);
			
		}
	}
}