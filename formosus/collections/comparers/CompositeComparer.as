package formosus.collections.comparers 
{
	import formosus.collections.ICollection;
	/**
	 * @author Mark
	 */
	public class CompositeComparer implements IComparer 
	{
		private var _strategy:IComparer;

		public function CompositeComparer(strategy:IComparer) 
		{
			this._strategy = strategy;
		}

		public function compare(a:Object, b:Object):int
		{
			if( ICollection(a).sort( this._strategy ) > ICollection(b).sort( this._strategy ) ) 
			{
				return 1;
			}
			else if( ICollection(a).sort( this._strategy ) < ICollection(b).sort( this._strategy ) ) 
			{
				return -1;		
			}
			
			return 0;
		}
	}
}
