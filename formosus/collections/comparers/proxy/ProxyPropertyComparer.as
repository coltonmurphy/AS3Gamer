package formosus.collections.comparers.proxy 
{
	import formosus.collections.comparers.IComparer;
	import formosus.printf;
	/**
	 * @author Mark
	 */
	internal class ProxyPropertyComparer implements IComparer
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		private var _name:String;
		private var _strategy:IComparer;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		/**
		 * Creates a new instance of ProxyPropertySort
		 * 
		 * @param name The name of the property to sort on.
		 * @param strategy The startegy to use for sorting.
		 */
		public function ProxyPropertyComparer(name:String, strategy:IComparer = null) 
		{
			this._strategy = strategy;
			this._name = name;
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		/**
		 * @inheritDoc
		 */
		public function compare(a:Object, b:Object):int
		{
			trace("formosus.collections.sorting.proxy.ProxyPropertySort::sort(a, b = " + [a, b] + ")");
			
			if(a && b && a.hasOwnProperty(this._name) && b.hasOwnProperty(this._name))
			{
				this._strategy = this._strategy || ComparerProxy.getStrategy( a[this._name], this._strategy );
				
				if(this._strategy)
				{
					return this._strategy.compare( a[this._name], b[this._name] );
				}
				else
				{
					throw new Error(printf("Cannot select a sorting strategy, please define one yourself"));	
				}
			}
			else
			{
				
				throw new Error(printf("Cannot call property '%s' on this object, because it's not there", this._name));
			}
			
			return 0;
		}
	}
}
