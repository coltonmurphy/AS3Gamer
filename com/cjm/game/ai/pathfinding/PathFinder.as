package cjm.game.ai.pathfinding 
{
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class PathFinder 
	{
		
		public function PathFinder() 
		{
			
		}
		
		public static function find( g:IGraph, a:INode, b:INode ):IPath
		{
			var p:AStar = new AStar().findPath( g, a, b)
			p.findPath( g, a, b);
			return new Path(p.path);
		}
	}

}