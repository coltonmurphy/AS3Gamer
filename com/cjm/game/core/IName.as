package com.cjm.game.core 
{
	import com.cjm.game.event.IGameSignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IName 
	{
		public function get onSetName : IGameSignal;
		public function getName( ):String;
		public function setName( n:String );
	}
	
}