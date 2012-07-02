package formosus.native.display.query.commands 
{

	import flash.display.DisplayObject;
	
	/**
	 * @author Mark
	 */
	public class Remove implements IDisplayObjectCommand 
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		public function get displayObject():DisplayObject
		{
			return _displayObject;
		}
		
		public function set displayObject(displayObject:DisplayObject):void
		{
			_displayObject = displayObject;
		}
		
		private var _displayObject:DisplayObject;


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		public function execute():void
		{
			if(this.displayObject.parent && this.displayObject.parent.contains(this.displayObject))
			{
				this.displayObject.parent.removeChild(this.displayObject);
			}
		}
	}
}
