package formosus.tasks 
{
	import org.osflash.signals.Signal;
	/**
	 * @author Mark
	 */
	public class ObservableCommandErrorSignal extends Signal 
	{
		public function ObservableCommandErrorSignal()
		{
			super(IObservableCommand, Error);
		}
	}
}
