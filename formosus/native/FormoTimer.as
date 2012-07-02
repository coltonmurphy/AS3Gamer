package formosus.native 
{
	import flash.utils.Timer;
	/**
	 * @author Mark
	 */
	public class FormoTimer extends Timer implements IDisposableEventDispatcher
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
		 * Creates a new FormoTimer object with the specified delay and repeatCount states. 
		 * 
		 * @param delay The delay between timer events, in milliseconds. 
		 * @param repeatCount Specifies the number of repetitions. If zero, the timer repeats infinitely. If nonzero, the timer runs the specified number of times and then stops. 
		 */
		public function FormoTimer(delay:Number, repeatCount:int = 0) 
		{
			super(delay, repeatCount);
			
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
				if(this.running)
				{
					this.stop();
				}
				
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
