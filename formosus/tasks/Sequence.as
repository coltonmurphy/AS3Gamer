package formosus.tasks
{

	import flash.utils.Dictionary;
	import formosus.IDispose;
	
	import formosus.io.IPreloadable;
	import formosus.io.IPreloader;
	import formosus.io.IProcess;
	import formosus.io.behaviors.PreloadableBehavior;
	import formosus.printf;
	/**
	 * Composite implementation of Task.
	 * 
	 * @author Mark
	 */
	public class Sequence extends Task implements IPreloader, IDispose, IProcess
	{
		private namespace formosus = "http://formosus.net";

		//--------------------------------------
		//   Properties 
		//--------------------------------------


		/**
		 * Determines if the sequence will abort on a error of a sub-task
		 * 
		 * @return Determines if the sequence will abort on a error of a sub-task
		 */
		public function get abortOnError():Boolean
		{
			return _abortOnError;
		}
		
		/**
		 * Determines if the sequence will abort on a error of a sub-task
		 * 
		 * @param abortOnError Determines if the sequence will abort on a error of a sub-task
		 */
		public function set abortOnError(abortOnError:Boolean):void
		{
			_abortOnError = abortOnError;
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
			this._preloadBehavior = new PreloadableBehavior( this, value );
		}
		
		/**
		 * Determines how many tasks will run concurrent.
		 * 
		 * @return Determines how many tasks will run concurrent.
		 */
		public function get tasksConcurrent():int
		{
			return _tasksConcurrent;
		}
		
		/**
		 * Determines how many tasks will run concurrent.
		 * 
		 * @param taskConcurrent Determines how many tasks will run concurrent.
		 */
		public function set tasksConcurrent(taskConcurrent:int):void
		{
			_tasksConcurrent = taskConcurrent;
		}
		
		/**
		 * Indicates how many tasks have completed in the sequence
		 *  
		 * @return Returns how many tasks have completed in the sequence
		 */
		public function get tasksComplete():int
		{
			return this._tasksComplete;
		}
		
		/**
		 * Indicates how many tasks have failed in the sequence
		 *  
		 * @return Returns how many tasks have failed in the sequence
		 */
		public function get tasksFailed():int
		{
			return this._tasksFailed;
		}
		
		/**
		 * Indicates how many tasks there are in the sequence
		 *  
		 * @return Returns how many tasks there are in the sequence 
		 */
		public function get tasksTotal():int
		{
			return this._tasksTotal;
		}
		
		private var _abortOnError:Boolean;
		private var _blockWhileRunning:Boolean;
		private var _isDone:Boolean = false;
		private var _isProcessing:Boolean = false;
		private var _preloadBehavior:PreloadableBehavior;
		private var _preloader:IPreloadable;
		private var _tasksConcurrent:int;
		private var _taskQueue:Vector.<IObservableCommand>;
		private var _taskRunning:Vector.<IObservableCommand>;
		private var _taskRunningProgress:Dictionary;
		private var _tasksComplete:int;
		private var _tasksFailed:int;
		private var _tasksTotal:int = 0;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		/**
		 * Creates a new instance of a Sequence
		 * 
		 * @param concurrentTasks Determines how many tasks will run concurrent
		 * @param abortOnError Determines if the sequence will abort on a error
		 * @param blockWhileRunning Determines if the sequence accepts new tasks while running
		 */
		public function Sequence(concurrentTasks:int = 1, abortOnError:Boolean = true, blockWhileRunning:Boolean = true) 
		{
			super();
			
			this._taskQueue = new Vector.<IObservableCommand>();
			this._taskRunning = new Vector.<IObservableCommand>();
			this._taskRunningProgress = new Dictionary();
			this._tasksConcurrent = concurrentTasks;
			this._abortOnError = abortOnError;
			this._blockWhileRunning = blockWhileRunning;
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		/**
		 * @inheritDoc
		 */
		override public function abort(reason:String):void 
		{
			var l:int = this._taskRunning.length;
			
			while(l--)
			{
				this._taskRunning[l].dispose();
				this._taskRunning[l].abort(reason);
			}
			
			this._tasksFailed = this._taskRunning.length + this._taskQueue.length; 
			
			this._isProcessing = false;
			this._isDone = true;
			
			this._taskRunning = new Vector.<IObservableCommand>();
			this._taskQueue = new Vector.<IObservableCommand>();
			
			super.abort( reason );
		}

		/**
		 * Adds a new task to the sequence
		 * 
		 * @param command An concrete instance of IObservableCommand
		 */
		public function add(command:IObservableCommand):void
		{
			if(!this._isProcessing || !this._blockWhileRunning)
			{
				this._tasksTotal++;
				this._taskQueue.push(command);
			}
		}

		/**
		 * @inheritDoc
		 */
		override public function execute():void 
		{
			this._isProcessing = true;
			this._isDone = false;
			this._tasksTotal = this._taskQueue.length;
			this._tasksComplete = 0;
			this._tasksFailed = 0;
			this.onInit.dispatch(this);
			this.doNext();
		}

		//--------------------------------------
		//   Private functions 
		//--------------------------------------

		/**
		 * Executes the next task
		 */
		private function doNext():void 
		{
			var command:IObservableCommand;
			
			if( this._taskQueue.length == 0 && this._taskRunning.length == 0 )
			{
				this._tasksTotal = 0;
				this._isProcessing = false;
				this._isDone = true;
				this.onComplete.dispatch(this);
				
				return;
			}
			
			while(this._taskRunning.length < this._tasksConcurrent && this._taskQueue.length)
			{
				command = this._taskQueue.shift();
				
				if(command)
				{
					command.onComplete.add(formosus::handleTaskComplete);
					command.onError.add(formosus::handleTaskError);
					command.onAbort.add(formosus::handleTaskAbort);
					command.onProgress.add(formosus::handleTaskProgress);
					
					command.execute();
					
					this._taskRunning.push( command );
				}
			}
		}
		
		/**
		 * Removes the running task from the dictionary and deletes the task from the task running array
		 * 
		 * @param command The command
		 */
		private function removeRunningTask(command:IObservableCommand):void
		{
			delete this._taskRunningProgress[command];
			
			this._taskRunning.splice( this._taskRunning.indexOf( command ), 1 );
		}

		//--------------------------------------
		//   Internal functions 
		//--------------------------------------

		/**
		 * Internal event handler to handle task abortion
		 * 
		 * @param command The command
		 * @param reason The reason for canceling
		 */
		formosus function handleTaskAbort(command:IObservableCommand, reason:String):void 
		{
			//dispose the resources
			command.dispose();
			
			//remove the task
			this.removeRunningTask(command);
			
			if(this._abortOnError)
			{
				this.abort(reason);
			}
			else
			{
				this.doNext();
			}
		}

		/**
		 * Internal event handler to handle task completion
		 * 
		 * @param command The command
		 */
		formosus function handleTaskComplete(command:IObservableCommand):void 
		{
			//dispose the resources
			command.dispose();
			
			//increment task complete counter
			this._tasksComplete++;
			
			//remove the task
			this.removeRunningTask(command);
			
			//do the next task
			this.doNext();
		}

		/**
		 * Internal event handler to handle task errors
		 * 
		 * @param command The command
		 * @param error The error thrown by the task
		 */
		formosus function handleTaskError(command:IObservableCommand, error:Error):void 
		{
			//dispose the resources
			command.dispose();
			
			//remove the task
			this.removeRunningTask(command);
			
			if(this._abortOnError)
			{
				this.abort(printf("Aborting sequence because task failed: %s", error.message ) );
			}
			else
			{
				this.doNext();
				this._tasksFailed++;
			}
		}

		/**
		 * Internal event handler to handle task completion
		 * 
		 * @param command The command
		 * @param percentage The percentage of the current task
		 */
		formosus function handleTaskProgress(command:IObservableCommand, percentage:Number):void 
		{
			var concurrentTaskProgress:Number = 0;
			
			this._taskRunningProgress[command] = percentage;
			
			for each(var p:Number in this._taskRunningProgress ) concurrentTaskProgress += p;
			
			this.onProgress.dispatch(this,
				(concurrentTaskProgress / this._tasksTotal)
				+
				(this._tasksComplete / this._tasksTotal)
			);
		}
	}
}
