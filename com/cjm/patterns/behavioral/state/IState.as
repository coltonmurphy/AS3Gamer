package cjm.patterns.behavioral.state
{
	import cjm.patterns.behavioral.command.ICommand;
	import cjm.patterns.core.IName;
	import cjm.patterns.core.IUpdate;
	import cjm.patterns.creational.core.IDestroy;
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IState extends ICommand, IUpdate, IDestroy, IName
	{
	
		
		public function get onEnterState:ISignal;//Force signal member
		public function get onExitState:ISignal;
		
		public function enter(...params ):Boolean;
		public function exit( ...params ):Boolean;
		public function getState( ):IState;
	}
	
}