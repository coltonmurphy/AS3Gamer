package formosus.tasks.threading
{
	import formosus.collections.IPrioritizable;
	import formosus.io.IProcess;
	import formosus.tasks.IObservableCommand;
	/**
	 * @author Mark
	 */
	public interface IThread extends IObservableCommand, IProcess, IPrioritizable
	{				
		/**
		 * Template method. This method will be invoked by the ThreadPool on each iteration
		 * 
		 * @see formosus.tasks.threading.ThreadPool
		 */
		function tick():void;
	}
}
