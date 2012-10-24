package  
{
	import com.cjm.collections.iterators.IIterator;
	import com.cjm.graph.GraphEdge;
	import com.cjm.graph.GraphHelper;
	import com.cjm.graph.GraphNode;
	import com.cjm.graph.IEdge;
	import com.cjm.graph.IGraph;
	import com.cjm.math.geom.Vector2D;
	import com.cjm.pathfinding.alg.AStar;
	import com.cjm.pathfinding.alg.Dijkstra;
	import com.cjm.pathfinding.alg.GraphSearch;
	import com.cjm.pathfinding.PathPlanner;
	import com.cjm.graph.SparseGraph;
	import com.cjm.pathfinding.PathManager;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class ThoughtWorksTest 
	{
		public function ThoughtWorksTest() {	}
		
		public function run():void
		{
			testGraph( createSparseGraph() );
		}
		
		private function createSparseGraph():IGraph
		{
			//AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7
			var graph  = new SparseGraph( true );
			
			//NODES   //A,B,C,D,E
			//TODO:Locate new position if necessary
			var a:GraphNode = new GraphNode(0, new Vector2D, "A");
			var b:GraphNode = new GraphNode(1, new Vector2D, "B");
			var c:GraphNode = new GraphNode(2, new Vector2D, "C");
			var d:GraphNode = new GraphNode(3, new Vector2D, "D");
			var e:GraphNode = new GraphNode(4, new Vector2D, "E");
			
			graph.addNode( a );
			graph.addNode( b );
			graph.addNode( c );
			graph.addNode( d );
			graph.addNode( e );
			
			//EDGES    //AB AD AE, BC, CD CE, DC DE, EB
			graph.addEdge( new GraphEdge(a.getIndex(), b.getIndex(), 5 ))//Inserting hardcoded distance as per input data
			graph.addEdge( new GraphEdge(a.getIndex(), d.getIndex(), 5 ))//Inserting hardcoded distance as per input data
			graph.addEdge( new GraphEdge(a.getIndex(), e.getIndex(), 7 ))//Inserting hardcoded distance as per input data
			graph.addEdge( new GraphEdge(b.getIndex(), c.getIndex(), 4 ))//Inserting hardcoded distance as per input data
			graph.addEdge( new GraphEdge(c.getIndex(), d.getIndex(), 8 ))//Inserting hardcoded distance as per input data
			graph.addEdge( new GraphEdge(c.getIndex(), e.getIndex(), 2 ))//Inserting hardcoded distance as per input data
			graph.addEdge( new GraphEdge(d.getIndex(), c.getIndex(), 8 ))//Inserting hardcoded distance as per input data
			graph.addEdge( new GraphEdge(e.getIndex(), b.getIndex(), 3 ))//Inserting hardcoded distance as per input data

			return graph;
		}	
		
		public function testGraph( graph:IGraph ):void 
		{
			//index,index,distance  //015, 124, 238, 328, 346. 035. 242, 413, 047
			                        //AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7
			var FAILED_STR:String = "NO SUCH ROUTE";
			var costs:Vector.<Vector.<int>> =  GraphHelper.createAllPairsCostsTable( graph );
			
			//EnumNode indices to graph
			var a:int = 0; var b:int = 1;
			var c:int = 2; var d:int = 3;
			var e:int = 4;
			
			//Edge costs
			var ab:Number = costs[a][b];
			var bc:Number = costs[b][c];
			var cd:Number = costs[c][d];
			var dc:Number = costs[d][c];
			var ae:Number = costs[a][e];
			var eb:Number = costs[e][b];
			var ed:Number = costs[e][d];
			var ad:Number = costs[a][d];
			
			//Composite edges
			var abc:Number   = ab + bc;
			var adc:Number   = ad + dc;
			var aebcd:Number = ae + eb + bc + cd;
			var aed:Number   = ae + ed;
			//////////////////////////////////////////////////////////////
			//1.)Solution and answer printed.
			if (!isNaN(abc) )
			{
				Logger.log(abc.toString() );// A to B to C
			}
			else
			{
				Logger.log( FAILED_STR );// failed
			}
			
			//////////////////////////////////////////////////////////////
			//2.)Solution and answer printed.
			if (!isNaN(ad) )
			{
				Logger.log( ad.toString() );// A to D
			}
			else
			{
				Logger.log( FAILED_STR );// failed
			}
			
			//////////////////////////////////////////////////////////////
			//3.)Solution and answer printed.
			if (!isNaN(adc) )
			{
				Logger.log( adc.toString() );// A to D
			}
			else
			{
				Logger.log( FAILED_STR );// failed
			}
			
			//////////////////////////////////////////////////////////////
			//4.)Solution and answer printed.
			if (!isNaN(aebcd) )
			{
				Logger.log( aebcd.toString() );// A to E to B to C to D
			}
			else
			{
				Logger.log( FAILED_STR ) ;// failed
			}
			
			//////////////////////////////////////////////////////////////
			//5.)Solution and answer printed.
			if (!isNaN(aed) )
			{
				Logger.log(aed.toString() );// A to E to D
			}
			else
			{
				Logger.log(FAILED_STR );// A to B
			}
			
			
			
			//////////////////////////////////////////////////////////////
			//6.)Solution and answer printed.
			//The number of trips starting at C and ending at C with a maximum of 3 stops.  
			//In the sample data below, there are two such trips: C-D-C (2 stops). and C-E-B-C (3 stops).
			var ds:Dijkstra = new Dijkstra( graph, 2, 2 );
			ds.search();
			/*if ( ds.isSolved() )
			{
				var count:int = 0;
			    var spt:Vector.<Vector.<int>> = ds.getSPT();
				
				for (var i:int = 0; i < spt.length; i++ )
				{
					if (spt[i].length =< 4 )
					{
						++count
					}
				}
				
				Logger.log(count.toString() );
			}*/
			
			//////////////////////////////////////////////////////////////
			//7.)Solution and answer printed.
			// The number of trips starting at A and ending at C with exactly 4 stops.  
			// In the sample data below, there are three such trips: A to C (via B,C,D); A to C (via D,C,D); and A to C (via D,E,B).
			ds = new Dijkstra( graph, a, c );
			ds.search();
			if ( ds.isSolved() )
			{
				var count:int = 0;
			    var spt:Vector.<Vector.<int>> = ds.getSPT();
				
				for (var i:int = 0; i < spt.length; i++ )
				{
					if (spt[i].length = 5 )
					{
						++count
					}
				}
				
				Logger.log(count.toString() );
			}
			
			//////////////////////////////////////////////////////////////
			//8.)Solution and answer printed.
			// TThe length of the shortest route (in terms of distance to travel) from A to C
			var astar:AStar = new AStar( _graph, a, c );
			astar.search();
			
			if ( astar.isSolved() )
			{
			    var amt:int = astar.getCostToTarget();

				Logger.log( amt.toString() );
			}
			
			//////////////////////////////////////////////////////////////
			//9.)Solution and answer printed.
			// The length of the shortest route (in terms of distance to travel) from B to B.
		    astar = new AStar( _graph, b, b );
			astar.search();
			
			if ( astar.isSolved() )
			{
			    var amt:int = astar.getCostToTarget();

				Logger.log(amt.toString() );
			}
			
			//////////////////////////////////////////////////////////////
			//10.)Solution and answer printed.
			// The number of different routes from C to C with a distance of less than 30.  In the sample data.
		    ds = new Dijkstra( _graph, c, c );
			ds.search();
			
			if ( ds.isSolved() )
			{
			    var count:int = 0;
			    var spt:Vector.<IEdge> = ds.getSPT();
				
				for (var i:int = 0; i < spt.length; i++ )
				{
					var cost:Number = getPathCost( spt[i] );
					count = count + (cost < 30) ? 1 : 0;
				}
				
				Logger.log( count.toString() );
			}
		}
		
		private function createPerimeter( origin:int )
		{
			var results:Vector.<IEdge> = new Vector.<IEdge>
			var edgeItr:IIterator = _graph.getEdgeIterator( origin );
			
			
			
			while ( edgeItr.next())
			{
				var edge:IEdge = edgeItr.current() as IEdge;
				
				results.push(edge.get)
			}
		}
		
		private function getPathCost(data:Vector.<IEdge>):Number
		{
			var len = data.length;
			var cost:int = 0;
			while (--len > 0)
			{
				cost += _data[len].getCost();
			}
			return cost;
		}
		
		
	}
}

class Logger {
	
	private static const _prefix:String = "Output #";
	private static var _counter:int = 0;
	public static function log( str:String )
	{
		trace(_prefix.concat(String(++_counter)).concat(str));
	}
}