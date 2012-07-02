package formosus.collections.comparers.proxy 
{
	import formosus.collections.comparers.IComparer;
	import formosus.printf;
	/**
	 * @author Mark
	 */
	internal class ProxyMethodComparer implements IComparer 
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		private var _args:Array;
		private var _name:String;
		private var _strategy:IComparer;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		/**
		 * Creates a new ProxyMethodSort instance.
		 * 
		 * @param name The name of the method.
		 * @param strategy The sorting strategy to use.
		 * @param args The args which are needed to call the method.
		 */
		public function ProxyMethodComparer(name:String, strategy:IComparer, args:Array = null) 
		{
			this._strategy = strategy;
			this._name = name;
			this._args = args || [];
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		/**
		 * @inheritDoc
		 */
		public function compare(a:Object, b:Object):int
		{
			if(a && b && a.hasOwnProperty(this._name) && b.hasOwnProperty(this._name))
			{
				var x:Object = ( a[this._name] as Function ).apply(null, this._args);
				var y:Object = ( b[this._name] as Function ).apply(null, this._args);
				
				this._strategy = this._strategy || ComparerProxy.getStrategy( x, this._strategy );
				
				if(this._strategy)			
				{
					return this._strategy.compare(x, y);
				}
				else
				{
					throw new Error(printf("Cannot select a sorting strategy, please define one yourself"));
				}
			}
			else
			{
				throw new Error(printf("Cannot call method '%s' on this object, because it's not there", this._name));
			}
			
			return 0;
		}
	}
}
