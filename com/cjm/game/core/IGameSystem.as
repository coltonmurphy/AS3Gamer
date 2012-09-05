package com.cjm.game.core 
{
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IGameSystem extends IUpdate implements IRender, IDestroy
	{
		public function initialize():void;
		public function setActive(b:Boolean):void;
		public function getActive( ):Boolean;
		public function destroy( ):void;
	}
	
}