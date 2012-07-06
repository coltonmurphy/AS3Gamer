package com.cjm.patterns.multi.mvc 
{
	import com.cjm.patterns.behavioral.command.ICommand;
	import com.cjm.patterns.core.IName;
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IFacade implements ISingleton, IInvoker
	{
		public function get onInitController():ISignal;
		public function get onInitView():ISignal
		public function get onInitModel():ISignal
		
		protected function mapView
		public function setCommand( i:IName, c:ICommand ):Boolean;
		public function setCommand( i:IName, c:ICommand ):Boolean;
		public function hasCommand( i:IName ):Boolean;
		public function removeCommand( i:IName, c:ICommand ):Boolean;
	}
	
}