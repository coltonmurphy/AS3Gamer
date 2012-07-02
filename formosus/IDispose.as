package formosus 
{
	/**
	 * 
	 * @author Mark
	 */
	public interface IDispose 
	{
		/**
		 * Returns if the current object already is disposed
		 * 
		 * @return Returns if the current object already is disposed
		 */
		function get isDisposed():Boolean
		
		/**
		 * Disposes all resources of an object
		 */
		function dispose():void;
	}
}
