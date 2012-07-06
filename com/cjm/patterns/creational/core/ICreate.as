package  cjm.patterns.creational.core
{
	import org.osflash.signals.ISignal;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public interface ICreate 
	{
		
		public function get onCreate:ISignal;
		public function create( obj:* ):Boolean
	}
	
}