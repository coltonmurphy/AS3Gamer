package com.cjm.patterns.core 
{
	import com.cjm.core.IEntity;
	import com.cjm.patterns.Abstract;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Entity extends Object implements IEntity 
	{
		protected var _type:String;
		protected var _name:String;
		
		public function Entity( type:String="Entity", name:String='None' ) 
		{
			_type = type;
			_name = name;
		}
		public function getType():String
		{
			return _type;
		}
	}
}