package com.cjm.collections 
{
	/**
	 * @author Mark
	 */
	public class Queue extends List implements IQueue
	{
		/**
		 * Creates a new instance of Queue.
		 * 
		 * @param list A list to start with. Can either be a Array or ICollection.
		 */
		public function Queue(list:* = null)
		{
			super(list);
		}

		
		public function front():*
		{
			this._storage[0]//TODO: verify front is element 0;
		}
		/**
		 * @inheritDoc
		 */
		public function enqueue(obj:*):void
		{
			this._storage.unshift(obj);
		}

		/**
		 * @inheritDoc
		 */
		public function dequeue():*
		{
			var obj:Object = this._storage.shift();
			
			return obj;
		}
	}
}
