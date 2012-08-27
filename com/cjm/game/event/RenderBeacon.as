package com.cjm.game.event 
{
	import com.cjm.game.core.IRender;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class RenderBeacon extends GameSignalBeacon
	{
		protected var _type = IRender;
		
		public function RenderBeacon() 
		{
			
		}

	}
}