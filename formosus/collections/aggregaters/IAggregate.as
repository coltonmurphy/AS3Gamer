package formosus.collections.aggregaters 
{
	/**
	 * @author Mark
	 */
	public interface IAggregate 
	{
		function aggregate(result:*, current:*, total:uint):void;
	}
}
