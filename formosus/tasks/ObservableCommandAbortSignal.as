package formosus.tasks 
{
	import org.osflash.signals.Signal;
	/**
	 * @author Mark
	 */
	public class ObservableCommandAbortSignal extends Signal 
	{
		public function ObservableCommandAbortSignal()
		{
			super(IObservableCommand, String);
		}
	}
}
