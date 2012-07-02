package formosus.collections.comparers 
{
	
	/**
	 * @author Mark
	 */
	public class StringComparer implements IComparer 
	{
		/**
		 * @inheritDoc
		 */
		public function compare(a:Object, b:Object):int
		{
			return String(a).localeCompare(String(b));
		}
	}
}
