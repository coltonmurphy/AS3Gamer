package cjm.patterns.behavioral.observer
{
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface INotification extends IEntity
	{
		public function getBody():*
		public function setBody(b:*):*
		public function getNote():String
		public function setNote(s:String):*

	}
	
}