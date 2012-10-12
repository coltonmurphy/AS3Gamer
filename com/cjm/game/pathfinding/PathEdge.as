

//-----------------------------------------------------------------------------
//
//  Name:   PathEdge.as
//
//  Desc:   class to represent a path edge. This path can be used by a path
//          planner in the creation of paths. 
//

package com.cjm.game.pathfinding
{
	import com.cjm.math.geom.Vector2D;
	public class Edge
	{
		//positions of the source and destination nodes this edge connects
		private var _source:Vector2D;
		private var _destination:Vector2D;

		//the behavior associated with traversing this edge
		private var _behavior:int;
		private var _doorID:int;

		public function Edge( source:Vector2D, destination:Vector2D, behavior:int = 0, doorID:int = 0):void
		{
			_source      = source;
			_destination = destination;
			_behavior    = behavior;
			_door        = doorID;
		}

		public function getDestination():Vector2D 
		{
			return _destination;
		}
		
		public function setDestination( dest:Vector2D ):void
		{
			_destination = dest;
		}
	  
		public function getSource():Vector2D
		{
			return _source;
		}
		
		public function setSource(s:Vector2D)
		{
			_source = s;
		}

		public function getDistance():Number 
		{
			return _source.getDistance( _destination );
		}
		
		public function getDoorID():int
		{
		   return _door;
		}
	 
		public function getBehavior():int
		{
		  return _behavior;
		}
	};
}


