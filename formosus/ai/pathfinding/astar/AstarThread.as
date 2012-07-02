package formosus.ai.pathfinding.astar 
{
	import formosus.ai.pathfinding.IPathfinder;
	import formosus.ai.pathfinding.Map;
	import formosus.ai.pathfinding.MapNode;
	import formosus.ai.pathfinding.astar.heuristic.DiagonalSort;
	import formosus.ai.pathfinding.astar.heuristic.ManhattanSort;
	import formosus.collections.ILinkedListItem;
	import formosus.collections.comparers.IComparer;
	import formosus.collections.List;
	import formosus.tasks.threading.AbstractThread;
	/**
	 * @author Mark
	 */
	internal class AstarThread extends AbstractThread 
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		private var _diagonal:Boolean;
		private var _end:MapNode;
		private var _listClosed:List;
		private var _listOpen:AstarPriorityQueue;
		private var _map:Map;
		private var _pathfinder:IPathfinder;
		private var _sortStrategy:IComparer;
		private var _start:MapNode;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function AstarThread(pathfinder:IPathfinder, map:Map, start:MapNode, end:MapNode, diagonal:Boolean)
		{
			this._pathfinder = pathfinder;
			this._map = map;
			this._start = start;
			this._end = end;
			this._sortStrategy = sortStrategy;
			this._diagonal = diagonal;
			
			var sortStrategy:IComparer = diagonal
						  ? new DiagonalSort(end)
						  : new ManhattanSort(end);
			
			this._listOpen = new AstarPriorityQueue(sortStrategy);
			this._listOpen.enqueue( start );
			
			this._listClosed = new List();
		}

		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		/**
		 * @inheritDoc
		 */
		override public function tick():void 
		{
			var currentNode:MapNode = this._listOpen.front();
			var neighbors:Vector.<MapNode>;
			var lenNeighbors:uint = 0;
			
			if(currentNode == null || currentNode.equals( this._end  ))
			{
				this._isDone = true;
				this._isProcessing = false;
				
				if(currentNode == null)
				{
					this._pathfinder.onPathNotFound.dispatch();
				}
				else
				{
					this._pathfinder.onPathFound.dispatch( this.getPath( currentNode ) );
				}
			}
			else
			{
				//remove it from the open list
				this._listOpen.dequeue();
								
				//push it on the closed list
				this._listClosed.add( currentNode );
				
				//get the neightbours
				neighbors = this._map.getNeighbors( currentNode, this._diagonal );
				//set the length of the neighbors
				lenNeighbors = neighbors.length;
				
				//iterate through the neighbors
				while(--lenNeighbors > -1)
				{
					if( !this._listClosed.contains( neighbors[lenNeighbors] ) && !this._listOpen.contains( neighbors[lenNeighbors] ) )
					{							
						neighbors[lenNeighbors].next = currentNode;	
						
						this._listOpen.enqueue(neighbors[lenNeighbors]);			
					}
				}
				
				this._listOpen.delayedSort();
			}
		}

		//--------------------------------------
		//   Private functions 
		//--------------------------------------

		private function getPath(currentNode:ILinkedListItem):Vector.<MapNode> 
		{
			var path:Vector.<MapNode> = new Vector.<MapNode>();
						
			while(currentNode != null)
			{
				path.push( currentNode );
				
				currentNode = currentNode.next;
			}
			
			return path.reverse();
		}

		override public function dispose():void 
		{
			this._listClosed = null;
			this._listOpen = null;
			
			super.dispose( );
		}
	}
}
