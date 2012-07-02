package formosus.ai.pathfinding 
{
	import formosus.IDispose;
	import formosus.tasks.threading.IThread;

	import org.osflash.signals.Signal;
	/**
	 * Defines a interface for different path finding strategies
	 * 
	 * @author Mark
	 */
	public interface IPathfinder extends IDispose
	{
		/**
		 * Signal for when the path is found
		 * 
		 * @return Signal for when the path is found 
		 */
		function get onPathFound():PathFoundSignal;
		
		/**
		 * Signal for when the path is not found
		 * 
		 * @return Signal for when the path is not found
		 */
		function get onPathNotFound():Signal;
		
		/**
		 * Performs a path finding search 
		 * 
		 * @param start The start node
		 * @param end The end node
		 * @param diagonal Determines if the algorithm should using diagonal
		 * 
		 * @see formosus.tasks.threading.ThreadPool
		 * @see formosus.tasks.threading.IThread
		 * @see formosus.tasks.threading.AbstractThread
		 * 
		 * @return A concrete instance of IThread. The internal class derives from AbstractThread. Adding it to the ThreadPool is not needed, a simple .execute() call will be enough.
		 */
		function find(start:MapNode, end:MapNode, diagonal:Boolean = false):IThread;
		
		/**
		 * Initializes the pathfinder
		 * 
		 * @param map The map
		 */
		function init(map:Map):void;
	}
}
