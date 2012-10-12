package com.cjm.collections.iterators 
{

	public interface IIterator 
	{
		function front():*;// first
		function back():*;//last, end
		function current():*;
		
		function next():Boolean;
		function prev():Boolean;
		
		function reset():void;
		
		function index():int;
	}
}
