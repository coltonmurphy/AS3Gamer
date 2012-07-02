package formosus.collections 
{
	/**
	 * @author Mark
	 */
	public class Queue extends List implements IQueue
	{
		/**
		 * Creates a new instance of Queue.
		 * 
		 * @see formosus.collections.ICollection
		 * @see Array
		 *  
		 * @param list A list to start with. Can either be a Array or ICollection.
		 */
		public function Queue(list:* = null)
		{
			super(list);
		}

		
		/**
		 * @inheritDoc
		 */
		public function enqueue(obj:*):void
		{
			this._storage.unshift(obj);
			this._dispatcherItemAdded.dispatch(obj);
		}

		/**
		 * @inheritDoc
		 */
		public function dequeue():*
		{
			var obj:Object = this._storage.shift();
			
			this._dispatcherItemRemoved.dispatch(obj);
			
			return obj;
		}
	}
}
