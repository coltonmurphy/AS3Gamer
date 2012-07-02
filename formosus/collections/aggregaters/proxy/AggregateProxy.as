package formosus.collections.aggregaters.proxy 
{
	import formosus.collections.aggregaters.IAggregate;
	/**
	 * @author Mark
	 */
	public class AggregateProxy 
	{
		public static function property(name:String, aggr:IAggregate):IAggregate
		{
			return new ProxyPropertyAggregate(name, aggr);	
		}
	}
}
