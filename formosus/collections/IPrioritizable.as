package formosus.collections 
{
	/**
	 * @author Mark
	 */
	public interface IPrioritizable 
	{
		/**
		 * Returns the priority of the item. The higher the priority, the more priority it will get in PriorityQueue
		 * 
		 * @see formosus.collections.PriorityQueue
		 * 
		 * @return Returns the priority of the item. 
		 */
		function get priority():uint;
		/**
		 * Set the priority of the item. The higher the priority, the more priority it will get in PriorityQueue
		 * 
		 * @see formosus.collections.PriorityQueue
		 * 
		 * @param value The desired priority.
		 */
		function set priority(value:uint):void;
	}
}
