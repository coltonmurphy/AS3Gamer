package formosus.native 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	/**
	 * @author Mark
	 */
	public class FormoEventDispatcher extends EventDispatcher implements IDisposableEventDispatcher 
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		/**
		 * @inheritDoc
		 */
		public function get isDisposed():Boolean
		{
			return _isDisposed;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get lengthListeners():uint
		{
			return this._nativeEventManager.lengthListeners;	
		}
		
		private var _isDisposed:Boolean = false;
		private var _nativeEventManager:NativeEventManager;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		/**
		 * Aggregates an instance of the EventDispatcher class.
		 *  
		 * The EventDispatcher class is generally used as a base class, which means that most developers do not need to use this constructor function. However, advanced developers who are implementing the IEventDispatcher interface need to use this constructor. If you are unable to extend the EventDispatcher class and must instead implement the IEventDispatcher interface, use this constructor to aggregate an instance of the EventDispatcher class.
		 * 
		 * @param target The target object for events dispatched to the EventDispatcher object. This parameter is used when the EventDispatcher instance is aggregated by a class that implements IEventDispatcher; it is necessary so that the containing object can be the target for events. Do not use this parameter in simple cases in which a class extends EventDispatcher.
		 */
		public function FormoEventDispatcher(target:IEventDispatcher = null)
		{
			super( target );
			
			this._nativeEventManager = new NativeEventManager(this);
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			if(this._nativeEventManager.addEventListener(type, listener, useCapture, priority, useWeakReference ))
			{
				super.addEventListener( type, listener, useCapture, priority, useWeakReference );
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function addEventListenerOnce(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			if(this._nativeEventManager.addEventListener(type, listener, useCapture, priority, useWeakReference, true ))
			{
				super.addEventListener( type, listener, useCapture, priority, useWeakReference );
			}
		}

		/**
		 * @inheritDoc
		 */
		public function dispose():void
		{
			if(!this.isDisposed)
			{
				this._nativeEventManager.dispose();
				this._isDisposed = true;
			}
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllEventListeners():void
		{
			this._nativeEventManager.removeAllEventListeners();
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllEventListenersWithType(type:String):void
		{
			this._nativeEventManager.removeAllEventListenersWithType(type);
		}


		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			this._nativeEventManager.removeEventListener(type, listener, useCapture);
			
			super.removeEventListener( type, listener, useCapture );
		}
	}
}
