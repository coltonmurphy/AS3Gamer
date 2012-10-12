

package com.cjm.game.ai.pathfinding
{
	import com.cjm.game.ai.pathfinding.alg.GraphSearch;
	import com.cjm.game.core.GameSystem;
	
	public class PathFinderSystem extends GameSystem
	{

	  //a container of all the active search requests
	  private var  _searchRequests:Vector<PathPlanner>;

	  //this is the total number of search cycles allocated to the manager. 
	  //Each update-step these are divided equally amongst all registered path
	  //requests
	   private var  _seachCyclesPerUpdate:int;

	   
	  public function PathManager( cycleAmt:int )
	  {
		  _seachCyclesPerUpdate = cycleAmt
	  }


	  //returns the amount of path requests currently active.
	  public function  getNumActiveSearches():int{return _searchRequests.length;}


	///////////////////////////////////////////////////////////////////////////////
	//------------------------- UpdateSearches ------------------------------------
	//
	//  This method iterates through all the active path planning requests 
	//  updating their searches until the user specified total number of search
	//  cycles has been satisfied.
	//
	//  If a path is found or the search is unsuccessful the relevant agent is
	//  notified accordingly by Telegram
	//-----------------------------------------------------------------------------

	override public function update( dtime:Number ):void
	{
	    var cyclesRemaining:int = _seachCyclesPerUpdate;
		var pathCount:int = 0;
		
	    //iterate through the search requests until either all requests have been
	    //fulfilled or there are no search cycles remaining for this update-step.
	    //std::list<path_planner*>::iterator curPath = _searchRequests.begin();
	    while (cyclesRemaining-- && _searchRequests.length != 0)
	    {
			var curPath:GraphSearch = _searchRequests[pathCount] as GraphSearch;
	
		     //make one search cycle of this path request
		    var result:int = curPath.searchOnce();

			//if the search has terminated remove from the list
			if ( (result == GraphSearch.SOLVED) || (result == GraphSearch.UNSOLVED_COMPLETE) )
			{
			  //remove this path from the path list
			  var i:Number = _searchRequests.indexOf( curPath )
			  
			  if ( i )
			  {
				  _searchRequests.splice(i,1);  
			  }
					
			}
			//move on to the next
			else
			{
			  ++pathCount;
			}

			//the iterator may now be pointing to the end of the list. If this is so,
			// it must be reset to the beginning.
			if ( pathCount == _searchRequests.length)
			    pathCount = 0;

		}
	}

	//--------------------------- Register ----------------------------------------
	//
	//  this is called to register a search with the manager.
	//-----------------------------------------------------------------------------

	public function register(pPathPlanner:PathPlanner )
	{
	  //make sure the bot does not already have a current search in the queue
	  if( _searchRequests.indexOf( pPathPlanner ) < 0 )                 
	  { 
		 //add to the list
		 _searchRequests.push(pPathPlanner);
	  }
	}


	public function unRegister( pPathPlanner:PathPlanner )
	{
		var i:Number = _searchRequests.indexOf( pPathPlanner );
		
		if ( i > -1 )
		{
			_searchRequests.splice( i, 1 );
		}
		
	   //_searchRequests.remove(pPathPlanner);

	}
}






