package formosus.tasks.threading
{
	import formosus.tasks.Task;
	/**
	 * @author Mark
	 */
	public class AbstractThread extends Task implements IThread
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		public function get isDone():Boolean
		{
			return _isDone;
		}
		
		public function get isProcessing():Boolean
		{
			return _isProcessing;
		}
		
		public function get priority():uint
		{
			return _priority;
		}
		
		public function set priority(priority:uint):void
		{
			_priority = priority;
		}
		protected var _isDone:Boolean = false;
		protected var _isProcessing:Boolean = false;
		
		private var _priority:uint = 0;


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		/**
		 * @inheritDoc
		 */
		override public function execute() : void
		{
			//dispatch onInit event
			this.onInit.dispatch(this);
			//enqueue this thread to the pool
			ThreadPool.add(this);
		}

		override public function abort(reason:String):void 
		{
			this._isDone = true;
			this._isProcessing = false;
			
			super.abort( reason );
		}

		/**
		 * @inheritDoc
		 */
		public function tick():void
		{
			throw new Error("AbstractThread" );
		}
	}
}
