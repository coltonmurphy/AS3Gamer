package com.cjm.collections 
{

	public class Stack extends List implements IStack
	{
	
		public function Stack(v:* = null)
		{
			super(v);
		}
		
		/**
		 * @inheritDoc
		 */
		public function push(obj:*):void
		{
			_storage.push(obj);
		}

		/**
		 * @inheritDoc
		 */
		public function pop():*
		{
			return _storage.pop();
		}

		/**
		 * @inheritDoc
		 */
		public function unshift(obj:*):void
		{
			_storage.unshift(obj);
		}

		/**
		 * @inheritDoc
		 */
		public function shift():*
		{
			return _storage.shift();
		}
		
		public function size():int
		{
			return _storage.length;
		}
	}
}
