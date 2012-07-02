package formosus.native.display.query.commands 
{
	import flash.display.DisplayObject;
	import formosus.tasks.ICommand;
	/**
	 * @author Mark
	 */
	public interface IDisplayObjectCommand extends ICommand 
	{
		/**
		 * 
		 * @return 
		 */
		function get displayObject():DisplayObject;
		/**
		 * 
		 * @param value
		 */
		function set displayObject(value:DisplayObject):void;
	}
}
