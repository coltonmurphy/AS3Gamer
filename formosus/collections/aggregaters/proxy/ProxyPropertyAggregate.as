package formosus.collections.aggregaters.proxy 
{
	import formosus.collections.aggregaters.IAggregate;
	/**
	 * @author Mark
	 */
	internal class ProxyPropertyAggregate implements IAggregate 
	{
		private var _name:String;
		private var _aggr:IAggregate;

		public function ProxyPropertyAggregate(name:String, aggr:IAggregate) 
		{
			this._aggr = aggr;
			this._name = name;
		}

		public function aggregate(result:*, current:*, total:uint):void
		{
			if(Object(current).hasOwnProperty(this._name))
			{
				this._aggr.aggregate(result, Object(current)[this._name], total);
			}
		}
	}
}
