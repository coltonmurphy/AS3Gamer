package formosus.native.display.query.iterators 
{
	import flash.display.DisplayObject;
	/**
	 * @author Mark
	 */
	public class FrameSpecificIterator implements IFrameIterator 
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
		private var _frames:Array;
		private var _pointer:Number;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function FrameSpecificIterator(...frames:Array) 
		{
			this._frames = frames;
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		public function current():*
		{
			return this._frames[this._pointer];	
		}
		
		public function next():Boolean
		{
			return --this._pointer > -1;
		}
		
		public function rewind():void
		{
			this._pointer = this._frames.length;
		}
	}
}
