package cjm.patterns.behavioral.state
{
	import cjm.patterns.core.IUpdate;
	import cjm.patterns.creational.core.ICreate;
	import cjm.patterns.creational.core.IDestroy;
	import cjm.patterns.structural.composite.IComposite;
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