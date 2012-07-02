package formosus.ai.pathfinding.astar {
	import formosus.collections.comparers.IComparer;
	import formosus.collections.PriorityQueue;

	/**
	 * @author Mark
	 */
	public class AstarPriorityQueue extends PriorityQueue 
	{
		public function AstarPriorityQueue(startegy:IComparer = null)
		{
			super( startegy );
		}

		override public function enqueue(obj:*):void 
		{
			this._storage.unshift(obj);
		}

		public function delayedSort():void
		{
			if(this._priorityStrategy)
			{
				this._storage = this.sort( this._priorityStrategy ).toVector();	
			}
		}
	}
}
