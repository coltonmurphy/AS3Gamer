package cjm.patterns.core 
{
	/**
	 * ...
	 * @author Colton Murphy
	 */

	public class Abstract implements IAbstract
	{
		protected var _id:String = "AbstractInstance";
		
		public function Abstract( ) { }
		
		public function getID():String
		{
			throw new Error("Abstract must override getID() method");
		}
		
		public function setID(id:String):void
		{
			throw new Error("Abstract must override setID( id ) method");
		}
	}

}