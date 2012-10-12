package com.cjm.collections 
{
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IList 
	{
		public function size():int
		
		public function push(obj:*):void
		
		public function pop():*
		
		public function begin():*
		
		public function end():*
		
		public function clear():void
		
		public function contains(obj:*):Boolean
		
		public function isEmpty():Boolean
	
		public function erase(obj:*):*

		public function reverse():List

		public function toArray():Array
	}
	
}