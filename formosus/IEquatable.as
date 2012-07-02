package formosus 
{

	/**
	 * @author Mark
	 */
	public interface IEquatable 
	{
		/**
		 * Compares two objects and returns a Boolean value if the are equal
		 * 
		 * @param other An concrete instance of an other IEquatable implemented object to compare if they are equal
		 * @return Returns true if the object is equal to the given object
		 */
		function equals(other:IEquatable):Boolean;
	}
}
