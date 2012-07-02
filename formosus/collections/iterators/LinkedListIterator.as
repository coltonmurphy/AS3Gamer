package formosus.collections.iterators 
{
	import formosus.collections.ILinkedListItem;
	
	import formosus.collections.List;
	/**
	 * @author Mark
	 */
	public class LinkedListIterator implements IIterator 
	{
		private var _list:Vector.<Object>;
		private var _current:ILinkedListItem;

		/**
		 * Creates a LinkedList iterator.
		 * 
		 * @see formosus.collections.LinkedList
		 * 
		 * @param list A instance of a LinkedList to iterate over
		 */
		public function LinkedListIterator(list:List) 
		{
			this._list = list.toVector(); 
		}

		/**
		 * @inheritDoc
		 */
		public function next():Boolean
		{
			if(this._current == null && this._list.length)
			{
				this._current = ILinkedListItem(this._list[0]);		
			}
			else if(this._list.length)
			{
				this._current = this._current.next;
			}
			
			return this._current != null;
		}

		/**
		 * @inheritDoc
		 */
		public function current():*
		{
			return this._current;
		}

		/**
		 * @inheritDoc
		 */
		public function rewind():void
		{
			this._current = null;
		}
	}
}
