package cjm.game.signals 
{
	import org.osflash.signals.ISignal;
	import org.osflash.signals.ISlot;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class GameAction extends Signal implements ISignal 
	{
		
		public function GameAction(...valueClasses) 
		{
			super(valueClasses);
			
		}
		
		/* INTERFACE org.osflash.signals.ISignal */
		
		public function add(listener:Function):ISlot 
		{
			super.add(listener)
		}
		
		public function get valueClasses():Array 
		{
			return _valueClasses;
		}
		
		public function set valueClasses(value:Array):void 
		{
			_valueClasses = value;
		}
		
		public function get numListeners():uint 
		{
			return _numListeners;
		}
		
		public function addOnce(listener:Function):ISlot 
		{
			
		}
		
		public function dispatch(...valueObjects):void 
		{
			
		}
		
		public function remove(listener:Function):ISlot 
		{
			
		}
		
		public function removeAll():void 
		{
			
		}
		
	}

}