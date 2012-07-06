package com.cjm.patterns.behavioral.state
{
	import com.cjm.patterns.core.IUpdate;
	import com.cjm.patterns.creational.core.ICreate;
	import com.cjm.patterns.creational.core.IDestroy;
	import com.cjm.patterns.structural.composite.IComposite;
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IStateMachine extends IComposite, IUpdate, IDestroy, ICreate
	{
		public function get onChangeState:ISignal;
		public function changeState(from:IState,to:IState, ...params):Boolean;
	}
	
}