package formosus.specifications 
{
	/**
	 * @author Mark
	 */
	public class NotSpecification extends CompositeSpecification 
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		private var _wrapped:ISpecification;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		/**
		 * Creates a new instance of the NotSpeficiation.
		 * 
		 * @see formosus.specifications.ISpecification
		 * 
		 * @param wrapped The subject to apply the not specification on.
		 */
		public function NotSpecification(wrapped:ISpecification) 
		{
			this._wrapped = wrapped;
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		/**
		 * @inheritDoc
		 */
		override public function isSatisfiedBy(candidate:*):Boolean 
		{
			return !this._wrapped.isSatisfiedBy(candidate);
		}
	}
}
