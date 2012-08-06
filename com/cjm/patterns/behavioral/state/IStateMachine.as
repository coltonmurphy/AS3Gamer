package com.cjm.patterns.behavioral.state
{
	import com.cjm.game.core.IUpdate
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IStateMachine extends IUpdate
	{
		public function get onChangeState:ISignal;
		public function changeState(to:IState, ...params):Boolean;
		public function setCurrentState( to:IState, ...params):Boolean;
		public function setGlobalState(to:IState, ...params):Boolean;
		public function setPreviousState(to:IState, ...params):Boolean;
	}
	
}