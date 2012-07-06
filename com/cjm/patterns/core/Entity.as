package com.cjm.patterns.core 
{
	import com.cjm.core.IEntity;
	import com.cjm.patterns.Abstract;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Entity extends Abstract implements IEntity 
	{
		protected var _type:String;
		
		public function Entity() 
		{
			
		}
		public function getType():String
		{
			throw new Error("Entity subclass must override getType() method");
		}
		public function setType(t:String):void
		{
			throw new Error("Entity subclass must override getType() method");
		};
	}

}