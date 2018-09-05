package com.cjm.patterns.behavioral.observer
{
	import com.cjm.patterns.core.IEntity;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface INotification extends IEntity
	{
		public function getBody():*
		public function setBody(b:*):*
		public function getString():String
		public function setString(s:String):*

	}
	
}