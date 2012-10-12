package com.cjm.collections 
{
	import com.cjm.collections.iterators.IIterator;
	import com.cjm.collections.iterators.Iterator;
	import com.cjm.collections.iterators.ListIterator;

	public class List implements IList
	{
		protected var _storage:Vector.<Object> = new Vector.<Object>();
		
		public function List(list:* = null)
		{
			if( null != list)
			{
				if ( null != list["length"] )
				{
					var len:uint = list.length;
					
					while(--len > -1)push( list[len] );
				}	
			}
		}

		//--------------------------------------
		//   Public functions 
		//--------------------------------------

	
		public function size():int
		{
			return _storage.length;
		}
		
		public function get length():int
		{
			return _storage.length;
		}
		
		public function add(obj:*):void
		{
			_storage.push(obj);
		}
		
		public function remove(obj:*):*
		{
			if ( var i = _storage.indexOf( obj ))
			{
				_storage.splice( i, 1);
			}
		}
		
		public function begin():*
		{
			return (length == 0) ? null : _storage[0];
		}
		
		public function end():*
		{
			return (length == 0) ? null : _storage[length - 1];
		}
		
		public function clear():void
		{
			_storage = new Vector.<Object>();
		}
		
		public function contains(obj:*):Boolean
		{
			return _storage.indexOf( obj ) > -1;
		}

		public function isEmpty():Boolean
		{
			return _storage.length == 0;
		}

		
		

		public function reverse():List
		{
			return new List(toArray().reverse());
		}

		public function toArray():Array
		{
			var a:Array = [];
			var l:uint = _storage.length;
			
			while(--l > -1)
			{
				a.push( _storage[l] );
			}
			
			return a;
		}
		
		public function toVector():Vector.<Object>
		{
			return _storage;
		}
	}
}
