package formosus.collections.iterators 
{
	/**
	 * @author Mark
	 */
	public interface IIterator 
	{
		/**
		 * Increments the pointer to the next segment of the list
		 * 
		 * @return Returns false when the internal pointer reaches it end
		 */
		function next():Boolean;
		/**
		 * Returns the current value
		 * 
		 * @return Could be anything
		 */
		function current():*;
		/**
		 * Rewind the iterator
		 */
		function rewind():void;
	}
}
