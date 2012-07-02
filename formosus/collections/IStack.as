package formosus.collections 
{
	/**
	 * 
	 * @author Mark
	 */
	public interface IStack 
	{
		/**
		 * Adds one element to the end of an stack.
		 * @param obj The object to add.
		 */
		function push(obj:*):void;
		/**
		 * Removes the last element from an stack and returns it.
		 * 
		 * @return The value of the last element (of any data type) in the specified stack. 
		 */
		function pop():*;
		/**
		 * Adds one element to the beginning of a stack.
		 * 
		 * @param obj The object to add.
		 */
		function unshift(obj:*):void;
		/**
		 * Removes the first element from a stack and returns that element.
		 * 
		 * @return  The value of the first element (of any data type) in the specified stack. 
		 */
		function shift():*;
	}
}
