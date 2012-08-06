package com.cjm.patterns.core
{
	import com.cjm.patterns.core.IAbstract;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IEntity extends IAbstract
	{
		public function getType():String
		public function setType(t:String):void;
		public function destroy():void;
		
	}

}