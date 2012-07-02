package formosus.specifications 
{
	/**
	 * @author Mark
	 */
	public class CompositeSpecification implements ISpecification 
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		protected var _x:ISpecification;
		protected var _y:ISpecification;


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		/**
		 * @inheritDoc
		 */
		public function and(specification:ISpecification):ISpecification
		{
			return new AndSpecification( this, specification );
		}
		
		/**
		 * @inheritDoc
		 */
		public function isSatisfiedBy(candidate:*):Boolean
		{
			throw new Error("Abstract template method, implement this method");
		}
		
		/**
		 * @inheritDoc 
		 */
		public function not():ISpecification
		{
			return new NotSpecification( this );
		}
		
		/**
		 * @inheritDoc
		 */
		public function or(specification:ISpecification):ISpecification
		{
			return new OrSpecification( this, specification );
		}
	}
}
