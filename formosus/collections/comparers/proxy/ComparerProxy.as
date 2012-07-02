package formosus.collections.comparers.proxy 
{
	import formosus.collections.ICollection;
	import formosus.collections.comparers.CompositeComparer;
	import formosus.collections.comparers.IComparer;
	import formosus.collections.comparers.NumberComparer;
	import formosus.collections.comparers.StringComparer;
	/**
	 * @author Mark
	 */
	public class ComparerProxy 
	{
		/**
		 * Returns a property sorter which implements ISort
		 * 
		 * @see formosus.collections.sorting.ISort
		 * 
		 * @param name The name of the property to sort on.
		 * @param strategy The strategy to use for sorting.
		 * @return Returns a property sorter which implements ISort.
		 */
		public static function property(name:String, strategy:IComparer = null):IComparer
		{
			return new ProxyPropertyComparer( name, strategy );
		}
		
		/**
		 * Returns a method sorter which implements ISort 
		 * 
		 * @param name The name of the method to sort on.
		 * @param args The arguments needed to call the method.
		 * @param strategy The strategy to use for sorting.
		 * @return Returns a method sorter which implements ISort 
		 */
		public static function method(name:String, args:Array = null, strategy:IComparer = null):IComparer
		{
			return new ProxyMethodComparer(name, strategy, args);
		}
		
		internal static function getStrategy(x:Object, strategy:IComparer):IComparer
		{
			switch(true)
			{
				case x is ICollection:
					return new CompositeComparer(strategy);
				break;
				
				case x is Number:
				case x is uint:
				case x is int:
					return new NumberComparer();
				break;
				
				case x is String:
					return new StringComparer();				
				break;
			}
			
			return null;
		}
	}
}
