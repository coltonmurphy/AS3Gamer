package formosus.tasks 
{
	/**
	 * @author Mark
	 */
	public class Task implements IObservableCommand
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
		public function get onAbort():ObservableCommandAbortSignal
		{
			return _dispatcherAbort;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get onComplete():ObservableCommandSignal
		{
			return _dispatcherComplete;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get onError():ObservableCommandErrorSignal
		{
			return _dispatcherError;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get onInit():ObservableCommandSignal
		{
			return _dispatcherInit;
		}
		
		/**
		 * @inheritDoc 
		 */
		public function get onProgress():ObservableCommandProgressSignal
		{
			return _dispatcherProgress;
		}
		
		protected var _dispatcherAbort:ObservableCommandAbortSignal;
		protected var _dispatcherComplete:ObservableCommandSignal;
		protected var _dispatcherError:ObservableCommandErrorSignal;
		protected var _dispatcherInit:ObservableCommandSignal;
		protected var _dispatcherProgress:ObservableCommandProgressSignal;
		protected var _isDisposed:Boolean = false;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------
		
		/**
		 * Creates a new instance of a task
		 */
		public function Task() 
		{
			this._dispatcherInit = new ObservableCommandSignal();
			this._dispatcherComplete = new ObservableCommandSignal();
			this._dispatcherError = new ObservableCommandErrorSignal();
			this._dispatcherProgress = new ObservableCommandProgressSignal();
			this._dispatcherAbort = new ObservableCommandAbortSignal();
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function abort(reason:String):void
		{
			this.onAbort.dispatch( this, reason );
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose():void
		{
			if(!this.isDisposed)
			{
				this._dispatcherAbort.removeAll();
				this._dispatcherComplete.removeAll();
				this._dispatcherError.removeAll();
				this._dispatcherInit.removeAll();
				this._dispatcherProgress.removeAll();
				
				this._isDisposed = true;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function execute():void
		{
			throw new Error("Implement your execute logic");
		}
	}
}


