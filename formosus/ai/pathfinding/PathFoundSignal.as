package formosus.ai.pathfinding 
{
	import org.osflash.signals.Signal;
	/**
	 * @author Mark
	 */
	public class PathFoundSignal extends Signal 
	{
		public function PathFoundSignal()
		{
			super(Vector.<MapNode>);
		}
	}
}
