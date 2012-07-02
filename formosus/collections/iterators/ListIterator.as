package formosus.collections.iterators 
{
	import formosus.collections.ICollection;
	
	/**
	 * @author Mark
	 */
	public class ListIterator implements IIterator 
	{
		private var _items:Vector.<Object>;
		private var _pointer:int;

		/**
		 * Creates a List iterator.
		 * 
		 * @see formosus.collections.List
		 * 
		 * @param hashmap A instance of a List to iterate over
		 */
		public function ListIterator(list:ICollection) 
		{
			this._items = list.toVector();
			this._pointer = -1;
		}

		/**
		 * @inheritDoc
		 */
		public function next():Boolean
		{
			return ++this._pointer < this._items.length;
		}

		/**
		 * @inheritDoc
		 */
		public function current():*
		{
			return this._items[this._pointer];
		}
		
		/**
		 * @inheritDoc
		 */
		public function rewind():void
		{
			this._pointer = -1;
		}
	}
}
