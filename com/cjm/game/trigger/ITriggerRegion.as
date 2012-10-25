package com.cjm.game.trigger 
{
	import com.cjm.game.core.IGameEntity;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface ITriggerRegion 
	{
		function isTouching(e:IGameEntity, radius:Number):Boolean
	}
}