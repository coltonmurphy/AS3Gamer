package com.cjm.collections.iterators 
{

	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Iterator implements IIterator
	{
		protected var _data:Vector.<*>;
		protected var _index:int;
		
		public function Iterator( data:Vector.<*> ) 
		{
			_data = data ;
			
			reset();
		}

		public function current():*
		{
			return _data[_index];
		}
		
		public function next():Boolean
		{
			_index = Math.min( length-1, ++_index );
			
			return _index < length;
		}

		public function prev():Boolean
		{
			_index = Math.min( 0, --_index );
			
			return _index > -1;
		}

		public function reset():void
		{
			_index = 0;
		}

		public function get index():int 
		{
			return _index;
		}
		
		public function set index(value:int):void 
		{
			_index = value;
		}
	}

}