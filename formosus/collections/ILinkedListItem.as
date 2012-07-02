package formosus.collections 
{
	/**
	 * @author Mark
	 */
	public interface ILinkedListItem 
	{
		/**
		 * Returns the next linked ILinkedListItem.
		 * 
		 * @return Returns the next linked ILinkedListItem.
		 */
		function get next():ILinkedListItem;
	}
}
