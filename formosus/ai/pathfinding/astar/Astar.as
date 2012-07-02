package formosus.ai.pathfinding.astar 
{
	import formosus.ai.pathfinding.IPathfinder;
	import formosus.ai.pathfinding.Map;
	import formosus.ai.pathfinding.MapNode;
	import formosus.ai.pathfinding.PathFoundSignal;
	import formosus.tasks.threading.IThread;

	import org.osflash.signals.Signal;
	/**
	 * @author Mark
	 */
	public class Astar implements IPathfinder 
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		/**
		 * @inheritDoc
		 */
		public function get isDisposed():Boolean
		{
			return _isDisposed;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get onPathFound():PathFoundSignal
		{
			return _dispatcherPathFound;
		}
		
		/**
		 * @inheritDoc 
		 */
		public function get onPathNotFound():Signal
		{
			return _dispatcherPathNotFound;
		}
		private var _dispatcherPathFound:PathFoundSignal;
		private var _dispatcherPathNotFound:Signal;
		private var _isDisposed:Boolean = false;
		private var _map:Map;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		/**
		 * Creates a A-star path finder
		 */
		public function Astar() 
		{
			this._dispatcherPathFound = new PathFoundSignal();
			this._dispatcherPathNotFound = new Signal();
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		/**
		 * @inheritDoc
		 */
		public function dispose():void 
		{
			if(!this.isDisposed)
			{
				this._dispatcherPathFound.removeAll();
				this._dispatcherPathNotFound.removeAll();
				this._isDisposed = true;
			}
		}

		/**
		 * @inheritDoc
		 */
		public function find(start:MapNode, end:MapNode, diagonal:Boolean = false):IThread
		{									  
			return new AstarThread(this, this._map, start, end, diagonal );
		}

		/**
		 * @inheritDoc
		 */
		public function init(map:Map):void
		{
			this._map = map;
		}
	}
}
