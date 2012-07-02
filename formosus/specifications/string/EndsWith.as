package formosus.specifications.string 
{
	import formosus.specifications.CompositeSpecification;
	import formosus.utils.types.StringUtils;
	/**
	 * @author Mark
	 */
	public class EndsWith extends CompositeSpecification
	{
		protected var _endsWith:String;
		protected var _caseSensitive:Boolean;

		/**
		 * Creates a string-based ends-with specification.
		 * 
		 * @param endsWith The part of the string which it should end with.
		 * @param caseSensitive Determines if the check should be case-sensitive.
		 */
		public function EndsWith(endsWith:String, caseSensitive:Boolean = true)
		{
			this._endsWith = endsWith;
			this._caseSensitive = caseSensitive;
		}

		/**
		 * @inheritDoc
		 */
		override public function isSatisfiedBy(candidate:*):Boolean 
		{			
			return this._caseSensitive
				? StringUtils.endsWith(String(candidate), this._endsWith )
				: StringUtils.endsWith(String(candidate).toLocaleLowerCase(), this._endsWith.toLocaleLowerCase() );
		}
	}
}
