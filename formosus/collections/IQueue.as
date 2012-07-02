package formosus.collections 
{
	/**
	 * @author Mark
	 */
	public interface IQueue 
	{
		/**
		 * Adds a new item to the front of the Queue
		 * 
		 * @see formosus.collections.Queue
		 * @see formosus.collections.PriorityQueue
		 * 
		 * @param obj The object to add to the Queue.
		 */
		function enqueue(obj:*):void;
		/**
		 * Gets the first item in the Queue
		 * 
		 * @see formosus.collections.Queue
		 * @see formosus.collections.PriorityQueue
		 * 
		 * @return  Gets the first item in the Queue
		 */
		function dequeue():*;
	}
}
