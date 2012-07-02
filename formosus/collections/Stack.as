package formosus.collections 
{
	/**
	 * @author Mark
	 */
	public class Stack extends List implements IStack
	{
		/**
		 * Creates a new instance of a Stack.
		 * 
		 * @see formosus.collections.IStack
		 * @see formosus.collections.ICollection
		 * @see Array
		 *  
		 * @param list A list to start with. Can either be a Array or ICollection.
		 */
		public function Stack(v:* = null)
		{
			super(v);
		}
		
		/**
		 * @inheritDoc
		 */
		public function push(obj:*):void
		{
			this._storage.push(obj);
		}

		/**
		 * @inheritDoc
		 */
		public function pop():*
		{
			return this._storage.pop();
		}

		/**
		 * @inheritDoc
		 */
		public function unshift(obj:*):void
		{
			this._storage.unshift(obj);
		}

		/**
		 * @inheritDoc
		 */
		public function shift():*
		{
			return this._storage.shift();
		}
	}
}
