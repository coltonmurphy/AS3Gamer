package formosus.native.display.query.iterators 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	/**
	 * @author Mark
	 */
	public class FrameAnyIterator implements IFrameIterator
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		public function get displayObject():DisplayObject
		{
			return _displayObject;
		}
		
		public function set displayObject(value:DisplayObject):void
		{
			_displayObject = value;
		}
		private var _displayObject:DisplayObject;
		private var _pointer:int;

		public function FrameAnyIterator() 
		{
			this.rewind();
		}

		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		public function current():*
		{
			return this._pointer;
		}
		
		
		public function next():Boolean
		{
			trace( "this._pointer: " + (this._pointer) );
			if(this._displayObject is MovieClip)trace(this.displayObject.name, MovieClip(this._displayObject).totalFrames);
			return this._displayObject is MovieClip
				 ? ++this._pointer <= MovieClip(this._displayObject).totalFrames
				 : ++this._pointer == 1 && this._displayObject is DisplayObject;
		}

		public function rewind():void
		{
			this._pointer = 0;
		}
	}
}
