package com.cjm.collections 
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Iterator 
	{
		protected var _data:Array;
		protected var _cursor:int;
		
		public function Iterator( data:* ) 
		{
			_data = Array( data );
			
			reset();
		}

		public static function getIterator( data:* ):Iterator
		{
			return new Iterator( data );
		}
		
		public function getCurrent():*
		{
			return _data[_cursor];
		}
		
		public function getFront():*
		{
			return _data[_data.length];
		}
		
		public function getBack():*
		{
			return _data[_data.length];
		}
		
		public function hasNext():Boolean
		{
			return _cursor < (_data.length - 1);
		}
		
		public function getNext():*
		{
			return _data[++_cursor];
		}
		
		public function hasPrevious():Boolean
		{
			return _cursor > 0;
		}
		
		public function getPrevious():*
		{
			_cursor--;
			return _data[_cursor];
		}

		public function reset():void
		{
			_cursor = -1;
		}

		public function length():Number
		{
			return _data.length;
		}
	}

}