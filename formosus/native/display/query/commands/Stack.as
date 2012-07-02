package formosus.native.display.query.commands 
{
	import flash.display.DisplayObject;
	/**
	 * @author Mark
	 */
	public class Stack implements IDisplayObjectCommand
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
		private var _stack:Vector.<DisplayObject>;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function Stack(stack:Vector.<DisplayObject>) 
		{
			this._stack = stack;
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		public function execute():void
		{
			this._stack.push(this.displayObject);
		}
	}
}
