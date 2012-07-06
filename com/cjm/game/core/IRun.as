package cjm.game.core 
{
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface IRun 
	{
		public function get onRun:ISignal;
		public function run(...params):Boolean
	}
	
}