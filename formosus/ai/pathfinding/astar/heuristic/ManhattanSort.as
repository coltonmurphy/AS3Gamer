package formosus.ai.pathfinding.astar.heuristic 
{
	import formosus.ai.pathfinding.MapNode;
	/**
	 * @author Mark
	 */
	public class ManhattanSort extends AbstractDistanceSort
	{
		/**
		 * Creates a instance of ManhattanSort, a pathfinding strategy.
		 * 
		 * @see http://theory.stanford.edu/~amitp/GameProgramming/Heuristics.html#S8
		 * 
		 * @param goal The goal we are looking for
		 */
		public function ManhattanSort(goal:MapNode) 
		{
			super(goal);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function distance(n:MapNode):uint
		{
			return (1 + n.weight) * (Math.abs( this._goal.position.x - n.position.x ) + Math.abs( this._goal.position.y - n.position.y ));
		}
	}
}
