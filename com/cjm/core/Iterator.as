package com.cjm.core 
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Iterator 
	{
		protected var _data:Array;
		protected var _cursor:Number;
		
		public function Iterator( data:* ) 
		{
			_data = Array( data );
			
			reset();
		}
		
		public function end():INode
		{
			if ( length() > 0 )
			{
				return _data[_data.length - 1];
			}
			
			return null;
		}
		
		public function front():INode
		{
			if ( length() > 0 )
			{
				return _data[0];
			}
			
			return null;
		}
		
		public function reset():void
		{
			_cursor = 0;
		}
		
		public function next():INode
		{
			_cursor = MathUtil.clamp( ++_cursor, 0, length() );
		   
			return _data[_cursor];
		}
		
		public function length():uint
		{
			return _data.length;
		}
	}

}