package com.cjm.patterns.behavioral.command 
{
	import com.cjm.patterns.behavioral.observer.INotification;
	import com.cjm.patterns.creational.core.IDestroy;
	import com.cjm.patterns.structural.core.IContext;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface ICommand extends IDestroy
	{
		private function get onExecute:ISignal;
		public function get onUndo():ISignal
		public function execute( ...params ):void
		public function undo(  ):void
	}
	
}