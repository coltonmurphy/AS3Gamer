package formosus.native.display.query.iterators 
{
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.display.FrameLabel;
	/**
	 * @author Mark
	 */
	public class FrameLabelIterator implements IFrameIterator
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		public function get displayObject():DisplayObject
		{
			return this._displayObject;
		}
		
		public function set displayObject(value:DisplayObject):void
		{
			this._displayObject = value;
			
			if(this._displayObject is MovieClip)
			{
				this.setLabels();
			}
		}
		
		private var _displayObject:DisplayObject;
		private var _labelsClip:Vector.<FrameLabel>;
		private var _labelsFilter:Array;
		private var _pointer:int;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function FrameLabelIterator(labels:Array) 
		{
			this._labelsFilter = labels;
			this.setLabels( );
			
			this.rewind();
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		public function current():*
		{
			return FrameLabel( this._labelsClip[this._pointer] ).frame;
		}
		
		
		public function next():Boolean
		{
			return --this._pointer > -1;
		}
		
		public function rewind():void
		{
			this._pointer = this._labelsClip.length;
		}

		//--------------------------------------
		//   Private functions 
		//--------------------------------------

		private function setLabels():void 
		{
			//create an vector to store the labels in
			this._labelsClip = new Vector.<FrameLabel>();
			
			//store the length of the array in a variable
			var lenLabels:int = MovieClip(this._displayObject).currentLabels.length;
			//make a variable to cast each array item to
			var label:FrameLabel;
			
			//decrease the setted length so we iterate backwords through the array
			while(--lenLabels > -1)
			{
				//cast the item in the array
				label = FrameLabel(MovieClip(this._displayObject).currentLabels[lenLabels]);
				
				if(this._labelsFilter.indexOf(label.name))
				{
					this._labelsClip.push( label );	
				}
			}
		}
	}
}
