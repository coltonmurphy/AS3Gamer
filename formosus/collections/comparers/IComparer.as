package formosus.collections.comparers 
{
	/**
	 * @author Mark
	 */
	public interface IComparer 
	{
		/**
		 * Compare two subjects. 
		 * 
		 * @param a Subject a
		 * @param b Subject b
		 * 
		 * @see formosus.collections.ICollection#sort
		 * 
		 * @return A integer ranging from -1 to 1. 
		 */
		function compare(a:Object, b:Object):int;
	}
}
