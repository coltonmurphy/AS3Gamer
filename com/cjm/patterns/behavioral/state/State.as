package com.cjm.patterns.behavioral.state 
{
	import com.cjm.patterns.behavioral.command.Command;
	import org.osflash.signals.ISignal;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class State extends Command implements IState 
	{
		public function State() 
		{
			
		}
		
		/* INTERFACE com.cjm.patterns.behavioral.state.IState */
		
		public function get onEnterState():ISignal 
		{
			return _onEnterState;
		}
		
		public function get onExitState():ISignal 
		{
			return _onExitState;
		}
		
		public function enter(...params):Boolean 
		{
			_onEnterState.dispatch(params);
		}
		
		public function exit(...params):Boolean 
		{
			_onEnterState.dispatch(params);
		}
	}

}