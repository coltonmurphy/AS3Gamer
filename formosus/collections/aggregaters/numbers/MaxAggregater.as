package formosus.collections.aggregaters.numbers 
{
	import formosus.collections.aggregaters.IAggregate;
	/**
	 * @author Mark
	 */
	public class MaxAggregater implements IAggregate 
	{
		public function aggregate(result:*, current:*, total:uint):void
		{
			result = Math.max(result, current);
		}
	}
}
