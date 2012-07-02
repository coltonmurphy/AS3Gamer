package formosus.collections 
{
	import formosus.tasks.ICommand;
	/**
	 * @author Mark
	 */
	public interface ICollectionCommand extends ICommand 
	{
		function get item():*;
		function set item(value:*):void;
	}
}
