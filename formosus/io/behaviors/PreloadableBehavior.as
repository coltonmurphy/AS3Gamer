package formosus.io.behaviors 
{
	import formosus.IDispose;
	import formosus.io.IPreloadable;
	import formosus.tasks.IObservableCommand;
	/**
	 * @author Mark
	 */
	public class PreloadableBehavior implements IDispose
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		/**
		 * @inheritDoc
		 */
		public function get isDisposed():Boolean
		{
			return isDisposed;
		}
		private var _dispatcher:IObservableCommand;
		private var _isDisposed:Boolean = false;
		private var _target:IPreloadable;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function PreloadableBehavior(dispatcher:IObservableCommand, target:IPreloadable) 
		{
			this._target = target;
			this._dispatcher = dispatcher;
			
			this._dispatcher.onComplete.add(this.handleComplete);
			this._dispatcher.onInit.add(this.handleInit);
			this._dispatcher.onProgress.add(this.handleProgress);
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		public function dispose():void
		{
			if(this.isDisposed)
			{
				this._dispatcher.onComplete.remove(this.handleComplete);
				this._dispatcher.onProgress.remove(this.handleProgress);
				this._dispatcher.onInit.remove(this.handleInit);
				this._isDisposed = true;	
			}
		}

		//--------------------------------------
		//   Private functions 
		//--------------------------------------

		private function handleComplete(command:IObservableCommand):void 
		{
			this._target.onComplete( );
			this.dispose();
		}

		private function handleInit(command:IObservableCommand):void 
		{
			this._target.onInit();
		}

		private function handleProgress(command:IObservableCommand, percentage:Number):void 
		{
			this._target.onProgress(percentage);
		}
	}
}
