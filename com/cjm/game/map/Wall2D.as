package com.cjm.game.map
{
	import com.cjm.collections.iterators.Iterator;
	import com.cjm.math.geom.Geometry2D;
	import com.cjm.math.geom.Vector2D;
	import flash.display.Graphics;

	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Wall2D 
	{	
		protected  var  _from:Vector2D
        protected  var  _to:Vector2D
        protected  var  _normal:Vector2D

		public function Wall2D( from:Vector2D, to:Vector2D )
		{
			_from = from;
			_to   = to;
			calculateNormal();
		}
		
		public function calculateNormal():void
		{
			var temp:Vector2D = Vector2D.Vec2DNormalize(_to.subtract( _from ) );

			_normal = new Vector2D;
			_normal.x = -temp.y;
			_normal.y = temp.x;
		}

		public function render( ...params ):void
		{
			var gdi:Graphics = params[0] as Graphics;
			
			if ( null != gdi )
			{
				var renderNormals:Boolean = params[1] || false;
				//gdi.beginFill(0x0000FF, 30);//TODO: use flash drawing?
		        gdi.lineStyle(1, 0xFF00FF, 100);
				gdi.moveTo( _from.x, _from.y )
				gdi.lineTo( _to.x, _to.y );
				//gdi.endFill();
				//render the normals if rqd
				if (renderNormals == true)
				{
				  var midX:int = (int(_from.x+_to.x)/2);
				  var midY:int = (int(_from.y+_to.y)/2);

				  gdi.moveTo(midX, midY);
				  gdi.lineTo(int(midX+(_normal.x * 5)), int(midY+(_normal.y * 5)));
				}
			}
			
		}

		public function getFrom():Vector2D  {return _from;}
		public function setFrom( v:Vector2D ){_from = v; calculateNormal();}

		public function getTo():Vector2D     {return _to;}
		public function setTo( v:Vector2D ){_to = v; calculateNormal();}
		  
		public function getNormal():Vector2D {return _normal;}
		public function setNormal(n:Vector2D ){_normal = n;}
		  
		public function getCenter():Vector2D { return (_from.clone().add(_to).divideBy(2.0); }
		
		public static function doWallsObstructLineSegment( from:Vector2D,
                                        to:Vector2D,
                                       walls:Vector.<Wall2D>)
		{
		    //test against the walls
		    var iterator:Iterator = Iterator.getIterator( walls );

		    while (iterator.next())
		    {
				var current:Wall2D = iterator.current() as Wall2D;
			  
				if ( null != current )
				{
					//do a line segment intersection test
					if ( Geometry2D.lineIntersection2D(from, to, current.getFrom(), current.getTo() )
					{
					    return true;
					}
				}
		    }
																				   
		  return false;
		}


		//----------------------- doWallsObstructCylinderSides -------------------------
		//
		//  similar to above except this version checks to see if the sides described
		//  by the cylinder of length |AB| with the given radius intersect any walls.
		//  (this enables the trace to take into account any the bounding radii of
		//  entity objects)
		//-----------------------------------------------------------------------------
		public static function doWallsObstructCylinderSides(A:Vector2D,
															B:Vector2D,
															BoundingRadius:Number,
												            walls:Vector.<Wall2D>)
		{
		  //the line segments that make up the sides of the cylinder must be created
		  var toB:Vector2D = Vector2D.Vec2DNormalize(B.subtract(A))//TODO: clone vector2ds, deep reference issues?;

		  //A1B1 will be one side of the cylinder, A2B2 the other.
		  var A1:Vector2D;
		  var B1:Vector2D;
		  var A2:Vector2D;
		  var B2:Vector2D;

		  var radialEdge:Vector2D = toB.getPerp().scaleBy( BoundingRadius );

		  //create the two sides of the cylinder
		  A1 = A .add( radialEdge );//TODO:Clone vectors?
		  B1 = B .add( radialEdge );

		  A2 = A .subtract( radialEdge );
		  B2 = B .subtract( radialEdge );

		  //now test against them
		  if (!doWallsObstructLineSegment(A1, B1, walls))
		  {
			 return doWallsObstructLineSegment(A2, B2, walls);
		  }
		  
		  return true;
		}

		//------------------ FindClosestPointOfIntersectionWithWalls ------------------
		//
		//  tests a line segment against the container of walls  to calculate
		//  the closest intersection point, which is stored in the reference 'ip'. The
		//  distance to the point is assigned to the reference 'distance'
		//
		//  returns false if no intersection point found
		//-----------------------------------------------------------------------------


		public static function findClosestPointOfIntersectionWithWalls( A:Vector2D,
															            B:Vector2D,
															            distance:Number,//TODO: no deep references for number natives
															            ip:Vector2D,//NOTE: ip is a deep reference
															            walls:Vector.<Wall2D>)//NOTE: walls are a constant reference, irrelevant?
		{
			distance = Number.MAX_VALUE;

		    var iterator:Iterator = Iterator.getIterator( walls );

		    while (iterator.next())
		    {
				var current:Wall2D = iterator.current() as Wall2D;
			    var dist = 0.0;
			    var point:Vector2D;

				//TODO: need overloaded method to include dist and point deep references
				if (Geometry2D.lineIntersection2D(A, B, current.getFrom(), current.getTo(), dist, point))
				{
				    if (dist < distance)
				    {
					    distance = dist;
					    ip = point;
				    }
				}
		  }

		  if (distance < Number.MAX_VALUE) return true;

		  return false;
		}

		//------------------------ doWallsIntersectCircle -----------------------------
		//
		//  returns true if any walls intersect the circle of radius at point p
		//-----------------------------------------------------------------------------
	
		public static function doWallsIntersectCircle(walls:Vector.<Wall2D>,  p:Vector2D,  r:Number):Boolean
		{
		    //test against the walls
		    var iterator:Iterator = Iterator.getIterator( walls );

		    while (iterator.next())
		    {
				var current:Wall2D = iterator.current() as Wall2D;
				
				//do a line segment intersection test
				if (Geometry2D.lineSegmentCircleIntersection(current.getFrom(), current.getTo(), p, r))
				{
				   return true;
				}
		    }
																				   
		    return false;
		}
		
	}

}