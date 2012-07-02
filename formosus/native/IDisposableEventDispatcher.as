package formosus.native 
{
	import flash.events.IEventDispatcher;
	import formosus.IDispose;
	/**
	 * @author Mark
	 */
	public interface IDisposableEventDispatcher extends IDispose, IEventDispatcher
	{
		
		/**
		 * Returns how many listeners there are on the object.
		 * 
		 * @return Returns how many listeners there are on the object.
		 */
		function get lengthListeners():uint;
		
		/**
		 * Add a event listener which will be removed after the first dispatch of the event 
		 * 
		 * @param type The type of event. 
         * @param listener The listener function that processes the event.
         * @param useCapture Determines whether the listener works in the capture phase or the target and bubbling phases.
         * @param priority The priority level of the event listener.
		 */
		function addEventListenerOnce(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		
		/**
		 * Removes all the event listeners
		 */
		function removeAllEventListeners():void;
		
		/**
		 * Removes all the event listerns by the specified type.
		 *  
		 * @param type The type of event. 
		 */
		function removeAllEventListenersWithType(type:String):void;
	}
}
