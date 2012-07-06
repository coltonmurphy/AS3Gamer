package cjm.patterns.core
{
	import cjm.patterns.core.IAbstract;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IEntity extends IAbstract
	{
		public function getType():String
		public function setType(t:String):void;
	}

}