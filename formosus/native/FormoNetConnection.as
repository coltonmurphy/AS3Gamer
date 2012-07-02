package formosus.native 
{
	import flash.net.NetConnection;
	/**
	 * @author Mark
	 */
	public class FormoNetConnection extends NetConnection implements IDisposableEventDispatcher 
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		/**
		 * @inheritDoc
		 */
		public function get isDisposed():Boolean
		{
			return this._isDisposed;
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

		public function FormoNetConnection()
		{
			this._nativeEventManager = new NativeEventManager(this);
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{	
			if(this._nativeEventManager.addEventListener(type, listener, useCapture, priority, useWeakReference))
			{
				super.addEventListener( type, listener, useCapture, priority, useWeakReference );
			}
		}


		/**
		 * @inheritDoc
		 */
		public function addEventListenerOnce(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			this._nativeEventManager.addEventListener(type, listener, useCapture, priority, useWeakReference, true);
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose():void
		{
			if(!this.isDisposed)
			{
				this._nativeEventManager.dispose();
				this._nativeEventManager = null;
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
			super.removeEventListener( type, listener, useCapture );
			
			this._nativeEventManager.removeEventListener( type, listener, useCapture );
		}
	}
}
