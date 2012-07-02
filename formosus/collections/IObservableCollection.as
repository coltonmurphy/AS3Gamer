package formosus.collections 
{
	/**
	 * @author Mark
	 */
	public interface IObservableCollection extends ICollection 
	{
		/**
		 * 
		 * @return 
		 */
		function get onItemAdded():CollectionItemSignal;
		/**
		 * 
		 * @return 
		 */
		function get onItemRemoved():CollectionItemSignal;
	}
}
