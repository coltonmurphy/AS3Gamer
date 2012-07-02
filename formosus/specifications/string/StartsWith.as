package formosus.specifications.string 
{
	import formosus.utils.types.StringUtils;
	import formosus.specifications.CompositeSpecification;
	/**
	 * @author Mark
	 */
	public class StartsWith extends CompositeSpecification 
	{
		protected var _startsWith:String;
		protected var _caseSensitive:Boolean;

		/**
		 * Creates a string-based starts-with specification.
		 * 
		 * @param startsWith The part of the string which it should start with.
		 * @param caseSensitive Determines if the check should be case-sensitive.
		 */
		public function StartsWith(startsWith:String, caseSensitive:Boolean = true)
		{
			this._caseSensitive = caseSensitive;
			this._startsWith = startsWith;
		}

		/**
		 * @inheritDoc
		 */
		override public function isSatisfiedBy(candidate:*):Boolean 
		{
			return this._caseSensitive
				? StringUtils.startsWith(String(candidate), this._startsWith )
				: StringUtils.startsWith(String(candidate).toLocaleLowerCase(), this._startsWith.toLocaleLowerCase() );
		}
	}
}
