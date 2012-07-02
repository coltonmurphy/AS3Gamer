package formosus.collections 
{
	import formosus.collections.comparers.PriorityComparer;
	import formosus.collections.comparers.IComparer;
	/**
	 * @author Mark
	 */
	public class PriorityQueue extends Queue 
	{
		protected var _priorityStrategy:IComparer;
		
		/**
		 * Creates a new instance of Queue.
		 * 
		 * @see formosus.collections.ICollection
		 * @see formosus.collections.ISort
		 * @see Array
		 * 
		 * @param strategy A strategy to use for priority sorting.  
		 * @param list A list to start with. Can either be a Array or ICollection.
		 */
		public function PriorityQueue( startegy:IComparer = null, list:* = null) 
		{
			this._priorityStrategy = startegy || new PriorityComparer();
			
			super(list);
		}

		/**
		 * @inheritDoc
		 */
		override public function enqueue(obj:*):void 
		{
			super.enqueue( obj );
			
			this._storage = this.sort( this._priorityStrategy ).toVector();
		}
		
		/**
		 * Returns the first item in the queue.
		 * 
		 * @return Returns the first item in the queue.
		 */
		public function front():*
		{
			return (this._storage.length) ? this._storage[0] : null;
		}
	}
}
