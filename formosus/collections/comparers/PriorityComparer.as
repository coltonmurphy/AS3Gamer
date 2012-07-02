package formosus.collections.comparers 
{
	import formosus.collections.IPrioritizable;
	/**
	 * @author Mark
	 */
	public class PriorityComparer implements IComparer 
	{
		/**
		 * @inheritDoc
		 */
		public function compare(a:Object, b:Object):int
		{
			return new NumberComparer().compare(IPrioritizable(a).priority, IPrioritizable(b).priority);
		}
	}
}
