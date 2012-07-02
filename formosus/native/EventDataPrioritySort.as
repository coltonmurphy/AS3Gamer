package formosus.native 
{
	import formosus.collections.comparers.IComparer;
	/**
	 * @author Mark
	 */
	internal class EventDataPrioritySort implements IComparer 
	{
		public function compare(a:Object, b:Object):int
		{
			var x:EventData = EventData(a);
			var y:EventData = EventData(b);
			
			if(x.priority > y.priority)
			{
				return 1;
			}
			else if(x.priority < y.priority)
			{
				return -1;
			}
			
			return 0;
		}
	}
}
