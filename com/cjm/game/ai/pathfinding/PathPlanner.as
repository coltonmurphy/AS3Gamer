import com.cjm.collections.iterators.Iterator;
import com.cjm.game.ai.agent.IAgent;
import com.cjm.game.ai.pathfinding.IPath;
import com.cjm.game.trigger.ITrigger;
import com.cjm.math.geom.Vector2D;

package com.cjm.game.ai.pathfinding
{
	//Derived from a Cpp library, in mid translation/modification
	public class PathPlanner
	{
		private static const no_closest_node_found:int = -1;
		
		public function PathPlanner( owner:IAgent )
		{
			_owner = owner;
			_navGraph = _owner.getWorld().getMap().getNavGraph()//TODO: use map or no?
			_currentSearch = null
		}



		//------------------------------ GetReadyForNewSearch -----------------------------------
		//
		//  called by the search manager when a search has been terminated to free
		//  up the memory used when an instance of the search was created
		//-----------------------------------------------------------------------------
		 public function getReadyForNewSearch():void
		{
		  //unregister any existing search with the path manager
		  _owner.getWorld().getPathManager().unregister(this);

		  //clean up memory used by any existing search
		    
		  _currentSearch = null;
		}

			//---------------------------- GetCostToNode ----------------------------------
			//
			//  returns the cost to travel from the bot's current position to a specific 
			 // graph node. This method makes use of the pre-calculated lookup table
			//-----------------------------------------------------------------------------
			public function getCostToNode( NodeIdx:int ):void
			{
			  //find the closest visible node to the bots position
			  //TODO: right now, nd = node index relative to nav graph element index
			  var nd:int = getClosestNodeToPosition(_owner.getPosition());//TODO: return int or node as type?

			  //add the cost to this node
			  //TODO: use heuristics???
			  var cost:Number = Vector2D.Vec2DDistance(_owner.getPosition(), _navGraph.getNode(nd).getPosition());

			  //add the cost to the target node and return
			  //TODO: add mapping data
			  return cost + _owner.getWorld().getMap().calculateCostToTravelBetweenNodes(nd, NodeIdx);
			}

			//------------------------ GetCostToClosestItem ---------------------------
			//
			//  returns the cost to the closest instance of the giver type. This method
			//  makes use of the pre-calculated lookup table. Returns -1 if no active
			//  trigger found
			//-----------------------------------------------------------------------------
			public function getCostToClosestItem( GiverType:int ):Number//TODO: create enum table of pickup types
			{
				//find the closest visible node to the bots position
				var nd:int = getClosestNodeToPosition(_owner.getPosition());//TODO: node or int???

				//if no closest node found return failure
				if (nd == INVALID_NODE_INDEX) return -1;//TODO: define INVALID_NODE_INDEX

				var closestSoFar = Number.MAX_VALUE;

				//iterate through all the triggers to find the closest *active* trigger of 
				//type GiverType
				//const Raven_Map::TriggerSystem::TriggerList& triggers = _owner.getWorld().GetMap().GetTriggers();

				var it:Iterator  = _owner.getWorld().getMap().getTriggers();
				var cit:ITrigger = triggers.begin()
				//Raven_Map::TriggerSystem::TriggerList::const_iterator it;
				while ( it.next() /*!= triggers.end()*/ )
				{
					var cit:ITrigger = it.current() as ITrigger;
				  
					if ( cit.getEntityType() == GiverType) && cit.isActive())
					{
						 var cost = _owner.getWorld().getMap().calculateCostToTravelBetweenNodes(nd, cit.GraphNodeIndex());

						if (cost < closestSoFar)
						{
						   closestSoFar = cost;
						}
					}
				}

				//return a negative value if no active trigger of the type found
				if ( closestSoFar == Number.MAX_VALUE )
				{
					return -1;
				}

				return closestSoFar;
			}


		//----------------------------- GetPath ------------------------------------
		//
		//  called by an agent after it has been notified that a search has terminated
		//  successfully. The method extracts the path from _currentSearch, adds
		//  additional edges appropriate to the search type and returns it as a list of
		//  PathEdges.
		//-----------------------------------------------------------------------------
		 public function GetPath():IPath
		{
		  
		  var path:Vector.<PathEdge> =  _currentSearch.getPathAsPathEdges();

		  var closest:int = getClosestNodeToPosition( _owner.getPosition() );

		 
		  path.unshift(PathEdge(_owner.getPosition(),
									getNodePosition(closest),
									NavGraphEdge::normal));

		  
		  //if the bot requested a path to a location then an edge leading to the
		  //destination must be added
		  if (_currentSearch.getType() == Graph_SearchTimeSliced<EdgeType>::AStar)
		  {  
			path.push(PathEdge(path.back().getDestination(),
									m_vDestinationPos,
									NavGraphEdge.NORMAL));
		  }

		  //smooth paths if required
		  if (UserOptions.smoothPathsQuick)
		  {
			smoothPathEdgesQuick(path);
		  }

		  if (UserOptions.smoothPathsPrecise)
		  {
			SmoothPathEdgesPrecise(path);
		  }

		  return path;
		}

		//--------------------------- SmoothPathEdgesQuick ----------------------------
		//
		//  smooths a path by removing extraneous edges.
		//-----------------------------------------------------------------------------
		public function smoothPathEdgesQuick( path:Path ):void
		{
		  //create a couple of iterators and point them at the front of the path
		  var e1:Iterator = path.getIterator();
		  var e2:Iterator = path.getIterator();

		  //increment e2 so it points to the edge following e1.
		  e2.next();

		  //while e2 is not the last edge in the path, step through the edges checking
		  //to see if the agent can move without obstruction from the source node of
		  //e1 to the destination node of e2. If the agent can move between those 
		  //positions then the two edges are replaced with a single edge.
		  while (e2.current() != path.end())
		  {
			//check for obstruction, adjust and remove the edges accordingly
			if ( (e2.current().getBehavior() == EdgeType.NORMAL) &&
				  _owner.canWalkBetween(e1.current().getSource(), e2.current().getDestination()) )
			{
			  e1.setDestination(e2..current().getDestination());
			  //e2 = path.erase(e2);
			  e2.index = path.erase(e2);
			}

			else
			{
			  e1.index = e2.index;
			  e2.next();
			}
		  }
		}


		//----------------------- SmoothPathEdgesPrecise ---------------------------------
		//
		//  smooths a path by removing extraneous edges.
		//-----------------------------------------------------------------------------
		public function smoothPathEdgesPrecise( path:IPath ):void
		{
		  //create a couple of iterators
		  var e1:Iterator = path.getIterator()//TODO: getEdgeIterator
		  var e2:Iterator = path.getIterator()

		  //point e1 to the beginning of the path
		  var e1Current:PathEdge = path.begin();
		  var e2Current:PathEdge = path.begin();
		  
		  while (e1Current != path.end())
		  {
			//point e2 to the edge immediately following e1
			e2.cursor = e1.cursor + 1; 
			//++e2;

			//while e2 is not the last edge in the path, step through the edges
			//checking to see if the agent can move without obstruction from the 
			//source node of e1 to the destination node of e2. If the agent can move
			//between those positions then the any edges between e1 and e2 are
			//replaced with a single edge.
			while ( e2Current != path.end() )
			{
			  //check for obstruction, adjust and remove the edges accordingly
			  if ( ( e2Current.getBehavior() == EdgeType.NORMAL ) &&
					 _owner.canWalkBetween( e1Current.getSource(), e2Current.getDestination() ) )
			  {
				e1Current.setDestination( e2Current.getDestination() );
				// e2.cursor = path.erase(++e1, ++e2);
				e2.cursor = path.erase(e1.cursor+1, e2.cursor+1);
				e1.cursor = e2.cursor;
				e1.prev();
			  }
			  else
			  {
				e2Current = e2.next();
			  }
			}

			e1Current = e1.next();
		  }
		}



		//---------------------------- CycleOnce --------------------------------------
		//
		//  the path manager calls this to iterate once though the search cycle
		//  of the currently assigned search algorithm.
		//-----------------------------------------------------------------------------
		 public function searchOnce():int
		{
		  assert (_currentSearch && "<public function CycleOnce>: No search object instantiated");

		  var result:int = _currentSearch.searchOnce();

		

		  //let the bot know a path has been found
		  else if (result == GraphSearch.SOLVED)
		  {
			//if the search was for an item type then the final node in the path will
			//represent a giver trigger. Consequently, it's worth passing the pointer
			//to the trigger in the extra info field of the message. (The pointer
			//will just be NULL if no trigger)
			var pTrigger:ITrigger = _navGraph.getNode( _currentSearch.getPathToTarget().back() ).getExtraInfo();

			Dispatcher.DispatchMsg(SEND_MSG_IMMEDIATELY,
									SENDER_ID_IRRELEVANT,
									_owner.ID(),
									Msg_PathReady,
									pTrigger);
		  }

		  return result;
		}

		//------------------------ GetClosestNodeToPosition ---------------------------
		//
		//  returns the index of the closest visible graph node to the given position
		//-----------------------------------------------------------------------------
		public function getClosestNodeToPosition( pos:Vector2D ): int
		{
		  var closestSoFar     = Number.MAX_VALUE;
		  var closestNode:int  = no_closest_node_found;

		  //when the cell space is queried this the the range searched for neighboring
		  //graph nodes. This value is inversely proportional to the density of a 
		  //navigation graph (less dense = bigger values)
		  var range:Number = _owner.getWorld().getMap().getCellSpaceNeighborhoodRange();

		  //calculate the graph nodes that are neighboring this position
		  _owner.getWorld().getMap().getCellSpace().calculateNeighbors(pos, range);

		  //iterate through the neighbors and sum up all the position vectors
		  for ( var pN = _owner.getWorld().getMap().getCellSpace().begin();
				!_owner.getWorld().getMap().getCellSpace().end();     
				pN = _owner.getWorld().getMap().getCellSpace().next())
		  {
			//if the path between this node and pos is unobstructed calculate the
			//distance
			if ( _owner.canWalkBetween( pos, pN.getPosition() ) )
			{
			  var dist:Number = Vector2D.Vec2DDistanceSq( pos, pN.getPosition() );

			  //keep a record of the closest so far
			  if ( dist < closestSoFar )
			  {
				  closestSoFar = dist;
				  closestNode  = pN.index();
			  }
			}
		  }
		   
		  return closestNode;
		}

		//--------------------------- RequestPathToPosition ------------------------------
		//
		//  Given a target, this method first determines if nodes can be reached from 
		//  the  agent's current position and the target position. If either end point
		//  is unreachable the method returns false. 
		//
		//  If nodes are reachable from both positions then an instance of the time-
		//  sliced A* search is created and registered with the search manager. the
		//  method then returns true.
		//        
		//-----------------------------------------------------------------------------
		 public function requestPathToPosition(TargetPos:Vector2D ):Boolean
		{ 

		  getReadyForNewSearch();

		  //make a note of the target position.
		  m_vDestinationPos = TargetPos;

		  //if the target is walkable from the bot's position a path does not need to
		  //be calculated, the bot can go straight to the position by ARRIVING at
		  //the current waypoint
		  if (_owner.canWalkTo(TargetPos))
		  { 
			return true;
		  }
		  
		  //find the closest visible node to the bots position
		  int closestNodeToBot = getClosestNodeToPosition(_owner.getPosition());

		  //remove the destination node from the list and return false if no visible
		  //node found. This will occur if the navgraph is badly designed or if the bot
		  //has managed to get itself *inside* the geometry (surrounded by walls),
		  //or an obstacle.
		  if (closestNodeToBot == no_closest_node_found)
		  { 
			return false; 
		  }

		  //find the closest visible node to the target position
		  var closestNodeToTarget = getClosestNodeToPosition(TargetPos);
		  
		  //return false if there is a problem locating a visible node from the target.
		  //This sort of thing occurs much more frequently than the above. For
		  //example, if the user clicks inside an area bounded by walls or inside an
		  //object.
		  if (ClosestNodeToTarget == no_closest_node_found)
		  { 
			return false; 
		  }

		  //create an instance of a the distributed A* search class
		  typedef Graph_SearchAStar_TS<Raven_Map::NavGraph, Heuristic_Euclid> AStar;
		   
		  _currentSearch = new AStar(_navGraph,
									   ClosestNodeToBot,
									   ClosestNodeToTarget);

		  //and register the search with the path manager
		  _owner.getWorld().GetPathManager().Register(this);

		  return true;
		}


		//------------------------------ RequestPathToItem -----------------------------
		//
		// Given an item type, this method determines the closest reachable graph node
		// to the bot's position and then creates a instance of the time-sliced 
		// Dijkstra's algorithm, which it registers with the search manager
		//
		//-----------------------------------------------------------------------------
		 public function requestPathToItem(unsigned int ItemType):void
		{    
		  //clear the waypoint list and delete any active search
		  getReadyForNewSearch();

		  //find the closest visible node to the bots position
		  var ClosestNodeToBot:int = getClosestNodeToPosition(_owner.getPosition());

		  //remove the destination node from the list and return false if no visible
		  //node found. This will occur if the navgraph is badly designed or if the bot
		  //has managed to get itself *inside* the geometry (surrounded by walls),
		  //or an obstacle
		  if (ClosestNodeToBot == no_closest_node_found)
		  { 
			return false; 
		  }

		  //create an instance of the search algorithm
		  typedef FindActiveTrigger<Trigger<Raven_Bot> > t_con; 
		  typedef Graph_SearchDijkstras_TS<Raven_Map::NavGraph, t_con> DijSearch;
		  
		  _currentSearch = new DijSearch(_navGraph,
										   ClosestNodeToBot,
										   ItemType);  

		  //register the search with the path manager
		  _owner.getWorld().getPathManager().register(this);

		  return true;
		}

		//------------------------------ getNodePosition ------------------------------
		//
		//  used to retrieve the position of a graph node from its index. (takes
		//  into account the enumerations 'non_graph_source_node' and 
		//  'non_graph_target_node'
		//----------------------------------------------------------------------------- 
		 public function getNodePosition(int idx):Vector2D
		{
		  return _navGraph.getNode(idx).Pos();
		}
	}
}



  
 


