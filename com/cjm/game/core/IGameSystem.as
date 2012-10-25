package com.cjm.game.core 
{
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IGameSystem extends IUpdate implements IRender, IDestroy
	{
	    function initialize( ):void;
		function getEntities():Vector.<IGameEntity>;
		function addEntity( e:IGameEntity );
		function setActive(b:Boolean):void;
		function getActive( ):Boolean;
		function destroy( ):void;
		function render( ...params ):void; 
	}
	
}