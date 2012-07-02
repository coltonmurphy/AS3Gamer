package formosus.ai.pathfinding.astar.heuristic 
{
	import formosus.ai.pathfinding.MapNode;
	import formosus.collections.comparers.IComparer;
	/**
	 * @author Mark
	 */
	public class AbstractDistanceSort implements IComparer
	{

		//--------------------------------------
		//   Properties 
		//--------------------------------------

		/**
		 * The goal we are looking for
		 * 
		 * @default The goal we are looking for specified in the constructor
		 */
		protected var _goal:MapNode;

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		/**
		 * Creates an instance of AbstractDistanceSort, however this class should not be instantiated directly.
		 * 
		 * This class acts as a foundation for the concrete strategies.
		 * 
		 * @see formosus.ai.pathfinding.heuristic.DiagonalSort
		 * @see formosus.ai.pathfinding.heuristic.ManhattenSort
		 * 
		 * @param goal The goal we are looking for
		 */
		public function AbstractDistanceSort(goal:MapNode) 
		{
			this._goal = goal;
		}


		//--------------------------------------
		//   Public functions 
		//--------------------------------------

		/**
		 * @inheritDoc
		 */
		public function compare(a:Object, b:Object):int
		{
			var x:MapNode = MapNode(a);
			var y:MapNode = MapNode(b);
			
			var xDistance:uint = this.distance(x);
			var yDistance:uint = this.distance(y);
			
			if(xDistance > yDistance)
			{
				return -1;
			}
			else if(xDistance < yDistance)
			{
				return 1;
			}
			else if(xDistance == yDistance)
			{
				return 0;
			}
			
			return 0;
		}

		//--------------------------------------
		//   Protected functions 
		//--------------------------------------

		/**
		 * Template method for calculating the distance between the currentNode and endNode 
		 * 
		 * @param n The current node
		 * @return The distance calculated by the formula
		 */
		protected function distance(n:MapNode):uint
		{
			return 0;
		}
	}
}
