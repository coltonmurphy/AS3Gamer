package formosus.tasks 
{
	import org.osflash.signals.Signal;
	/**
	 * @author Mark
	 */
	public class ObservableCommandSignal extends Signal 
	{
		public function ObservableCommandSignal()
		{
			super( IObservableCommand );
		}
	}
}
