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
		private var _facade:IFacade;
		private var _context:IContext;
		private var _note:INotification; // store for undo's 
		protected var _onExecute:ISignal;
		protected var _onUndo:ISignal;
		
		public function Command()
		{
			_onExecute = new Signal( Array );
			_onUndo    = new Signal( Array );
		}
		
		public function execute( c:IContext, n:INotification ):Boolean
		{
			_context = c;
			_note    = n;
			onExecute.dispatch([_context, _note]);
			retyrb true;
		};
		
		public function undo( ):Boolean
		{
			if ( null != _note )
			{
				onUndo.dispatch( [_context, _note] );
			
				_context = null;
				_note    = null;
				return true;
			}
			
			return false;
		};
		
		public function get onExecute():ISignal 
		{
			return _onExecute;
		}
		
		public function get onUndo():ISignal 
		{
			return _onUndo; 
		}
	}
}