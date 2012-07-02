package formosus.collections.comparers 
{
	/**
	 * @author Mark
	 */
	public class NumberComparer implements IComparer 
	{
		/**
		 * @inheritDoc
		 */
		public function compare(a:Object, b:Object):int
		{
			
			if( Number(a) > Number(b) )
			{
				return 1;
			}
			else if( Number(a) < Number(b) )
			{
				return -1;	
			}
			
			return 0;
		}
	}
}
