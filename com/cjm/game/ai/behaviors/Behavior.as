package com.cjm.game.ai.behaviors 
{
	import com.cjm.game.core.IGameMovingEntity;
	import com.cjm.patterns.behavioral.state.IState;
	import com.cjm.patterns.behavioral.state.State;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Behavior implements IBehavior
	{
		protected var _owner:IGameMovingEntity;
		
		public function Behavior(gme:IGameMovingEntity) 
		{
			_owner = gme;
		}	
	}
}