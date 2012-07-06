package com.cjm.patterns.behavioral.command 
{
	import com.cjm.patterns.behavioral.observer.INotification;
	import com.cjm.patterns.core.Abstract;
	import com.cjm.patterns.core.Entity;
	import com.cjm.patterns.multi.mvc.IFacade;
	import com.cjm.patterns.structural.core.IContext;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Command extends Abstract implements ICommand 
	{
		public var facade:IFacade;
		private var _context:IContext;
		private var _note:INotification;
		private var _onExecute:ISignal;
		private var _onUndo:ISignal;
		
		public function execute( c:IContext, n:INotification ):Boolean
		{
			_context = c;
			_note = n;
			onExecute.dispatch(c,n);
		};
		
		public function undo( ):Boolean
		{
		
			onUndo.dispatch(_context,_note);
		};
		
		public function get onExecute():ISignal 
		{
			return return _onExecute || (_onExecute = new Signal(_context,_note ));
		}
		
		public function get onUndo():ISignal 
		{
			return return _onUndo || (_onUndo = new Signal(_context,_note ));
		}
	}

}