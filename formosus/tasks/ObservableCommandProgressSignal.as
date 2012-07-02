package formosus.tasks 
{
	import org.osflash.signals.Signal;
	/**
	 * @author Mark
	 */
	public class ObservableCommandProgressSignal extends Signal 
	{
		public function ObservableCommandProgressSignal()
		{
			super(IObservableCommand, Number);
		}
	}
}
