package com.cjm.patterns.behavioral.state
{
	import com.cjm.patterns.behavioral.command.ICommand;
	import com.cjm.patterns.core.IName;
	import com.cjm.patterns.core.IUpdate;
	import com.cjm.patterns.creational.core.IDestroy;
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