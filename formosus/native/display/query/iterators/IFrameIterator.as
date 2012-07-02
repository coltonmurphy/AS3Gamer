package formosus.native.display.query.iterators 
{
	import formosus.collections.iterators.IIterator;

	import flash.display.DisplayObject;
	/**
	 * @author Mark
	 */
	public interface IFrameIterator extends IIterator
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
