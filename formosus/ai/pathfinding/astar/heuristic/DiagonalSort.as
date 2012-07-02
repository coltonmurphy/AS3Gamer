package formosus.ai.pathfinding.astar.heuristic 
{
	import formosus.ai.pathfinding.MapNode;
	/**
	 * @author Mark
	 */
	public class DiagonalSort extends AbstractDistanceSort
	{
		/**
		 * Creates a instance of DiagonalSort, a pathfinding strategy.
		 * 
		 * @see http://theory.stanford.edu/~amitp/GameProgramming/Heuristics.html#S9
		 * 
		 * @param goal The goal we are looking for
		 */
		public function DiagonalSort(goal:MapNode) 
		{
			super(goal);
		}

		/**
		 * @inheritDoc
		 */
		override protected function distance(n:MapNode):uint 
		{
			return (1 + n.weight) * Math.max( Math.abs(this._goal.position.x - n.position.x ), Math.abs(this._goal.position.y - n.position.y ) );
		}
	}
}
