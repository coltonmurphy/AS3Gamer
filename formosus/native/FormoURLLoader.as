package formosus.native 
{

	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import formosus.io.IPreloadable;
	import formosus.io.IPreloader;
	import formosus.io.IProcess;
	import formosus.io.behaviors.PreloadableBehavior;
	import formosus.printf;
	import formosus.tasks.IObservableCommand;
	import formosus.tasks.ObservableCommandAbortSignal;
	import formosus.tasks.ObservableCommandErrorSignal;
	import formosus.tasks.ObservableCommandProgressSignal;
	import formosus.tasks.ObservableCommandSignal;
	/**
	 * @author Mark
	 */
	public class FormoURLLoader extends URLLoader implements IProcess, IPreloader, IObservableCommand, IDisposableEventDispatcher  
	{
		private namespace formosus = "http://formosus.net";

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
		public function get isDone():Boolean
		{
			return _isDone;
		}
				
		/**
		 * @inheritDoc
		 */
		public function get isProcessing():Boolean
		{
			return _isProcessing;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get lengthListeners():uint
		{
			return this._nativeEventManager.lengthListeners;	
		}
		
		/**
		 * @inheritDoc
		 */
		public function get onAbort():ObservableCommandAbortSignal
		{
			return _handleOnAbort;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get onComplete():ObservableCommandSignal
		{
			return _handleOnComplete;
		}
		
		/**
		 * @inheritDoc 
		 */
		public function get onError():ObservableCommandErrorSignal
		{
			return _handleOnError;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get onInit():ObservableCommandSignal
		{
			return _handleOnInit;
		}
		
		/**
		 * @inheritDoc 
		 */
		public function get onProgress():ObservableCommandProgressSignal
		{
			return _handleOnProgress;
		}

		/**
		 * @inheritDoc
		 */
		public function get preloader():IPreloadable
		{
			return this._preloader;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set preloader(value:IPreloadable):void
		{
			if(this._preloadBehavior)
			{
				this._preloadBehavior.dispose();
			}
			
			this._preloader = value;
			this._preloadBehavior = new PreloadableBehavior(this, value );
		}
		
		/**
		 * The address which the URLLoader is trying to load.
		 * 
		 * @return The address which the URLLoader is trying to load.
		 */
		public function get url():String
		{
			return this._url;
		}
		
		protected var _url:String;
		private var _handleOnAbort:ObservableCommandAbortSignal;
		private var _handleOnComplete:ObservableCommandSignal;
		private var _handleOnError:ObservableCommandErrorSignal;
		
		private var _handleOnInit:ObservableCommandSignal;
		private var _handleOnProgress:ObservableCommandProgressSignal;
		private var _isDisposed:Boolean = false;
		private var _isDone:Boolean = false;
		
		private var _isProcessing:Boolean = false;

		private var _nativeEventManager:NativeEventManager;
		private var _preloadBehavior:PreloadableBehavior;
		private var _preloader:IPreloadable;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		/**
		 * Creates a new instance of FormoURLLoader
		 * 
		 * @param url The address which the URLLoader should to load.
		 */
		public function FormoURLLoader(url:String) 
		{
			this._url = url;
			
			this._handleOnInit = new ObservableCommandSignal;
			this._handleOnComplete = new ObservableCommandSignal;
			this._handleOnError = new ObservableCommandErrorSignal;
			this._handleOnProgress = new ObservableCommandProgressSignal;
			this._handleOnAbort = new ObservableCommandAbortSignal;
			
			this._nativeEventManager = new NativeEventManager(this);
			
			this.addEventListener(ProgressEvent.PROGRESS, formosus::handleProgressEvent);
			this.addEventListener(Event.INIT, formosus::handleInit);
			this.addEventListener(Event.COMPLETE, formosus::handleComplete);	
			this.addEventListener(IOErrorEvent.IO_ERROR, formosus::handleError, false);
			this.addEventListener(IOErrorEvent.DISK_ERROR, formosus::handleError, false);
			this.addEventListener(IOErrorEvent.NETWORK_ERROR, formosus::handleError, false);
			this.addEventListener(IOErrorEvent.VERIFY_ERROR, formosus::handleError, false);
			this.addEventListener(SecurityErrorEvent.SECURITY_ERROR, formosus::handleError, false);
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		/**
		 * @inheritDoc
		 */
		public function abort(reason:String):void
		{
			try
			{
				this.close();	
			}
			catch (error:Error)
			{
				this.onError.dispatch(this, new Error(printf("Aborting failed: %s", error.message )) );
			}
			
			this._isProcessing = false;
			this._isDone = true;
			
			this.onAbort.dispatch(this, printf("Aborting %s because '%s'", this._url, reason ) );
		}
		
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
				this.removeAllEventListeners();
				
				this._nativeEventManager.dispose();
				
				this._handleOnAbort.removeAll();
				this._handleOnComplete.removeAll();
				this._handleOnError.removeAll();
				this._handleOnInit.removeAll();
				this._handleOnProgress.removeAll();
				
				this._isDisposed = true;
			}
		}
		
		/**
		 * @inheritDoc 
		 */
		public function execute():void
		{		
			this.load(new URLRequest(this._url));
		}
		
		override public function load(request:URLRequest):void 
		{
			this._isProcessing = true;
			this._isDone = false;
			
			super.load( request );
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

		//--------------------------------------
		//   Internal functions 
		//--------------------------------------

		formosus function handleComplete(e:Event):void
		{
			this._isProcessing = false;
			this._isDone = true;
			
			this.onComplete.dispatch(this);
		}
				
		formosus function handleError(e:ErrorEvent):void
		{
			this._isProcessing = false;
			this._isDone = true;
			
			this.onError.dispatch(this, new Error(printf("Error while loading '%s' - %s", this._url, e.text)));
		}
		
		formosus function handleInit(e:Event):void
		{
			this.onInit.dispatch(this);
		}
		
		formosus function handleProgressEvent(e:ProgressEvent):void
		{
			this.onProgress.dispatch(this, e.bytesLoaded / e.bytesTotal);
		}
	}
}
