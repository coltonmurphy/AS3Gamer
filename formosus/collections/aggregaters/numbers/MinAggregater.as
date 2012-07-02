package formosus.collections.aggregaters.numbers 
{
	import formosus.collections.aggregaters.IAggregate;
	/**
	 * @author Mark
	 */
	public class MinAggregater implements IAggregate
	{
		public function aggregate(result:*, current:*, total:uint):void
		{
			result = Math.min(current, result);
		}
	}
}
