package formosus.native.display.query 
{
	import formosus.native.ISprite;
	import formosus.native.display.query.iterators.FrameAnyIterator;
	import formosus.native.display.query.iterators.FrameLabelIterator;
	import formosus.native.display.query.iterators.FrameSpecificIterator;
	/**
	 * @author Mark
	 */
	public class DisplayObjectQuery 
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		private var _displayObject:ISprite;
		private var _recursive:Boolean;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		/**
		 * 
		 * @param displayObject
		 * @param recursive
		 */
		public function DisplayObjectQuery(displayObject:ISprite, recursive:Boolean = false) 
		{
			this._recursive = recursive;
			this._displayObject = displayObject;
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		/**
		 * 
		 * @return 
		 */
		public function anyFrame():DisplayObjectListQuery
		{
			return new DisplayObjectListQuery( this._displayObject, new FrameAnyIterator(), null, this._recursive);
		}
		
		/**
		 * 
		 * @param frames
		 * @return 
		 */
		public function specificFrame(...frames:Array):DisplayObjectListQuery
		{
			return new DisplayObjectListQuery( this._displayObject, new FrameSpecificIterator( frames ), null, this._recursive);
		}
		
		/**
		 * 
		 * @param labels
		 * @return 
		 */
		public function withLabel(...labels:Array):DisplayObjectListQuery
		{
			return new DisplayObjectListQuery( this._displayObject, new FrameLabelIterator( labels ), null, this._recursive);	
		}
	}
}
