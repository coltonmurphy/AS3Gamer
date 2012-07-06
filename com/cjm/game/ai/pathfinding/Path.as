package cjm.game.ai.pathfinding 
{
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public final class Path 
	{
		private var _vectors:Vector.<INode>;
		public function Path( sv:Vector.<INode> = null ) 
		{
			setNodes( sv );
		}
		
		public function setPath(sv:Vector.<INode>):Boolean
		{
			_vectors = sv;
			return true;
		}
		
		public function getPath():Vector.<INode> 
		{
			return _vectors;
		}
		
	}

}