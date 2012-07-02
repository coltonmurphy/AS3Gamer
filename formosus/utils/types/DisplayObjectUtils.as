package formosus.utils.types 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;

	/**
	 * @author Mark
	 */
	public class DisplayObjectUtils 
	{
		public static function clearContent(displayObject:DisplayObject):void
		{
			if (displayObject is DisplayObjectContainer)
			{
				while ((displayObject as DisplayObjectContainer).numChildren > 0)
				{
					(displayObject as DisplayObjectContainer).removeChildAt(0);
				}
			}
			if (displayObject is Sprite)
			{
				(displayObject as Sprite).graphics.clear();
			}
			else if (displayObject is Shape)
			{
				(displayObject as Shape).graphics.clear();
			}
		}
	}
}
