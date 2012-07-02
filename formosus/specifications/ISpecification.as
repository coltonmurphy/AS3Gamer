package formosus.specifications 
{
	/**
	 * A implementation of the Specification pattern.
	 * 
	 * @see http://en.wikipedia.org/wiki/Specification_pattern
	 * 
	 * @author Mark
	 */
	public interface ISpecification 
	{
		/**
		 * Returns an instance of the AndSpecification
		 * 
		 * @see formosus.specifications.AndSpecification
		 * @see formosus.specifications.ISpecification
		 * 
		 * @param specification A concrete instance of ISpecification which specifies the 'and' operation.
		 * @return A concrete instance of ISpecification with the the specification wrapped in.
		 */
		function and(specification : ISpecification) : ISpecification
		/**
		 * Returns true or false if the candidate matches the demand of the specification.
		 * 
		 * @param candidate The candidate to check the specifation on.
		 * @return Returns true or false if the candidate matches the demand of the specification.
		 */
		function isSatisfiedBy(candidate : *) : Boolean
		/**
		 * Returns an instance of the NotSpecifation.
		 * 
		 * @see formosus.specifications.NotSpecification
		 * @see formosus.specifications.ISpecification
		 * 
		 * @return A concrete instance of ISpecification with the the specification wrapped in.
		 */
		function not() : ISpecification
		/**
		 * Returns an instance of the OrSpecification.
		 * 
		 * @see formosus.specifications.OrSpecification
		 * @see formosus.specifications.ISpecification
		 * 
		 * @param specification A concrete instance of ISpecification which specifies the 'or' operation. 
		 * 
		 * @return A concrete instance of ISpecification with the the specification wrapped in.
		 */
		function or(specification : ISpecification) : ISpecification
	}
}
