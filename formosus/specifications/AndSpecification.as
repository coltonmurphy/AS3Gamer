package formosus.specifications 
{
	/**
	 * @author Mark
	 */
	public class AndSpecification extends CompositeSpecification
	{

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		/**
		 * Creates a new instance of the AndSpeficiation.
		 * 
		 * @see formosus.specifications.ISpecification
		 * 
		 * @param x Subject x for the spefication check.
		 * @param y Subject y for the spefication check.
		 */
		public function AndSpecification(x:ISpecification, y:ISpecification) 
		{
			this._x = x;
			this._y = y;
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override public function isSatisfiedBy(candidate:*):Boolean 
		{
			return this._x.isSatisfiedBy( candidate ) && this._y.isSatisfiedBy(candidate);
		}
	}
}
