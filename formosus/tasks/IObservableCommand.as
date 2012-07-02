package formosus.tasks 
{
	import formosus.IDispose;
	/**
	 * @author Mark
	 */
	public interface IObservableCommand extends ICommand, IDispose 
	{
		/**
		 * Signal fired when the command is aborted
		 * 
		 * @return A instance of ObservableCommandAbortSignal
		 */
		function get onAbort():ObservableCommandAbortSignal;
		
		/**
		 * Signal fired when the command is completed
		 * 
		 * @return A instance of ObservableCommandSignal
		 */
		function get onComplete():ObservableCommandSignal;
		
		/**
		 * Signal fired when an error occurs
		 * 
		 * @return A instance of ObservableCommandErrorSignal
		 */
		function get onError():ObservableCommandErrorSignal;
		
		/**
		 * Signal fired when the command is initialized
		 * 
		 * @return A instance of ObservableCommandSignal
		 */
		function get onInit():ObservableCommandSignal;
		
		/**
		 * Signal fired when the command progresses
		 * 
		 * @return A instance of ObservableCommandProgressSignal
		 */
		function get onProgress():ObservableCommandProgressSignal;

		/**
		 * Aborts execution of the command
		 * 
		 * @param reason A reason to cancel the command from executing
		 */
		function abort(reason:String):void;
	}
}
