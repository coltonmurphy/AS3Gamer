package formosus.collections 
{
	import formosus.collections.iterators.IIterator;
	import formosus.collections.iterators.LinkedListIterator;
	/**
	 * @author Mark
	 */
	
	//TODO: Refactor this class
	public class LinkedList extends List
	{
		/**
		 * 
		 * @param v
		 */
		public function LinkedList(v:* = null)
		{
			super(v);
		}

		/**
		 * @inheritDoc
		 */
		override public function add(obj:*):void 
		{
			if(!obj is ILinkedListItem)
			{
				throw new Error("Object cannot be added to the linkedlist because it's not a ILinkedListItem");
			}
			
			super.add(obj);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function getIterator():IIterator 
		{
			return new LinkedListIterator(this);
		}
	}
}
