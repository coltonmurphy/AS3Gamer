package cjm.patterns.behavioral.command 
{
	import cjm.patterns.behavioral.observer.INotification;
	import cjm.patterns.creational.core.IDestroy;
	import cjm.patterns.structural.core.IContext;
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