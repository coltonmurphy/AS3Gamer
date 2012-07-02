package formosus.specifications.string 
{
	import formosus.specifications.CompositeSpecification;
	import formosus.utils.types.StringUtils;
	/**
	 * @author Mark
	 */
	public class Contains extends CompositeSpecification 
	{
		protected var _contains:String;
		protected var _caseSensitive:Boolean;

		/**
		 * Creates a string-based contains specification.
		 * 
		 * @param contains The needle it should contain.
		 * @param caseSensitive Determines if the check should be case-sensitive.
		 */
		public function Contains(contains:String, caseSensitive:Boolean = true)
		{
			this._caseSensitive = caseSensitive;
			this._contains = contains;
		}

		/**
		 * @inheritDoc
		 */
		override public function isSatisfiedBy(candidate:*):Boolean 
		{
			return this._caseSensitive
				? StringUtils.contains(String(candidate), this._contains )
				: StringUtils.contains(String(candidate).toLocaleLowerCase(), this._contains.toLocaleLowerCase() );
		}
	}
}
