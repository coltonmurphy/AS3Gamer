package formosus.io 
{

	/**
	 * @author Mark
	 */
	public interface IPreloader 
	{
		/**
		 * An concrete instance of IPreloadable
		 *  
		 * @return Returns a concrete instance of IPreloadable, if set 
		 * @see formosus.io.IPreloadble
		 */
		function get preloader():IPreloadable;
		/**
		 * Sets the concrete instance of IPreloadable 
		 * 
		 * @param value A concrete instance of IPreloadable
		 * @see formosus.io.IPreloadble
		 */
		function set preloader(value:IPreloadable):void;
	}
}
