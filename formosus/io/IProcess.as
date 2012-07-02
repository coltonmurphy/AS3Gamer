package formosus.io 
{

	/**
	 * @author Mark
	 */
	public interface IProcess 
	{
		/**
		 * Indicates if the object is progressiong with it's task
		 * 
		 * @return Returns if the object is still processing 
		 */
		function get isProcessing():Boolean;
		
		/**
		 * Indicates if the object is done with it's task
		 * 
		 * @return Returns if the object is done
		 */
		function get isDone():Boolean;
	}
}
