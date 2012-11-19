#ifndef GEOMETRY_H
#define GEOMETRY_H
//------------------------------------------------------------------------
//
//Name:   geometry.h 
//
//Desc:   useful 2D geometry functions
//
//Author: Mat Buckland (fup@ai-junkie.com)
//
//------------------------------------------------------------------------

package com.cjm.math.geom
{
	public class Geometry2D
	{
		//given a plane and a ray this function determins how far along the ray 
		//an interestion occurs. Returns negative if the ray is parallel
		public static function getDistanceToRayPlaneIntersection( rayOrigin:Vector2D,
													  rayHeading:Vector2D,
													  planePoint:Vector2D,  //any point on the plane
													  planeNormal:Vector2D):Number
		{
		  
		  var d     : Number = - planeNormal.getDot(planePoint);
		  var numer : Number = planeNormal.getDot(rayOrigin) + d;
		  var denom : Number = planeNormal.getDot(rayHeading);
		  
		  // normal is parallel to vector
		  if ((denom < 0.000001) && (denom > -0.000001))
		  {
		   return (-1.0);
		  }

		  return -(numer / denom);	
		}

		//------------------------- WhereIsPoint --------------------------------------
		private static const plane_backside:int = 0;
		private static const plane_front:int    = 1;
		private static const on_plane:int       = 2;
		
		public static function whereIsPoint( point:Vector2D,
									   pointOnPlane:Vector2D, //any point on the plane
									   planeNormal:Vector2D):int 
		{
			var dir:Vector2D = pointOnPlane.subtract(point);
			var d:Number = dir.getDot( planeNormal );
			 
			if ( d < -0.000001 )
			{
			    return plane_front;	
			}

			else if ( d> 0.000001 )
			{
			     return plane_backside;	
			}

			return on_plane;	
		}


		private static const pi:Number = 3.14159;
		//-------------------------- GetRayCircleIntersect -----------------------------
		public static function getRayCircleIntersect( rayOrigin:Vector2D,
											 rayHeading:Vector2D,
											 circleOrigin:Vector2D,
											 radius:Number):Number
		{
			
		    var toCircle:Vector2D  = circleOrigin.subtract(rayOrigin);
		    var length:Number      = toCircle.length();
		    var v:Number           = toCircle.getDot(rayHeading);
		    var d :Number          = radius*radius - (length*length - v*v);

		    // If there was no intersection, return -1
		    if (d < 0.0) return (-1.0);

		    // Return the distance to the [first] intersecting point
		    return (v - Math.sqrt(d));
		}

		//----------------------------- DoRayCircleIntersect --------------------------
		public static function doRayCircleIntersect( rayOrigin:Vector2D,
													 rayHeading:Vector2D,
													 circleOrigin:Vector2D,
													 radius:Number):Boolean
		{
			
		    var toCircle:Vector2D  = circleOrigin.subtract(rayOrigin);
		    var length:Number      = toCircle.length();
		    var v:Number           = toCircle.getDot(rayHeading);
		    var d :Number          = radius*radius - (length*length - v*v);

		    // If there was no intersection, return -1
		    return (d < 0.0);
		}


		//------------------------------------------------------------------------
		//  Given a point 'point' and a circle of radius 'radius' centered at 'centerV' this function
		//  determines the two points on the circle that intersect with the 
		//  tangents from 'point' to the circle. Returns false if 'point' is within the circle.
		//
		//  thanks to Dave Eberly for this one.
		//------------------------------------------------------------------------
		public static function getTangentPoints ( centerV:Vector2D,  radius:Number, point:Vector2D , tanV1:Vector2D, tanV2:Vector2D):Boolean
		{
			var vectors:Vector.<Vector2D> = new Vector.<Vector2D>;
			
			var pmC :Vector2D = point.subtract( centerV );
			var sqrLen:Number = pmC.lengthSq();
			var rSqr = radius*radius;
		    if ( SqrLen <= rSqr )
		    {
			    // P is inside or on the circle
			    return vectors;
		    }

		  var invSqrLen:Number = 1/sqrLen;
		  var root:Number = Math.sqrt(Math.abs(sqrLen - rSqr));
		  var tanV1:Vector2D = new Vector2D();
		  var tanV2:Vector2D = new Vector2D();
		  tanV1.x = C.x + radius*(radius*pmC.x - pmC.y*root)*invSqrLen;
		  tanV1.y = C.y + radius*(radius*pmC.y + pmC.x*root)*invSqrLen;
		  tanV2.x = C.x + radius*(radius*pmC.x + pmC.y*root)*invSqrLen;
		  tanV2.y = C.y + radius*(radius*pmC.y - pmC.x*root)*invSqrLen;

		  return vectors;
		}

		//------------------------- DistToLineSegment ----------------------------
		//
		//  given a line segment AB and a point P, this function calculates the 
		//  perpendicular distance between them
		//------------------------------------------------------------------------
		public static function getDistToLineSegment( A:Vector2D,
										             B:Vector2D,
										             P:Vector2D):Number
		{
		  //if the angle is obtuse between PA and AB is obtuse then the closest
		  //vertex must be A
		  var dotA:Number = (P.x - A.x)*(B.x - A.x) + (P.y - A.y)*(B.y - A.y);

		  if (dotA <= 0) return Vector2D.Vec2DDistance(A, P);

		  //if the angle is obtuse between PB and AB is obtuse then the closest
		  //vertex must be B
		  var dotB:Number = (P.x - B.x)*(A.x - B.x) + (P.y - B.y)*(A.y - B.y);
		 
		  if (dotB <= 0) return Vector2D.Vec2DDistance(B, P);
			
		  //calculate the point along AB that is the closest to P
		  var Point:Vector2D = A + ((B - A) * dotA)/(dotA + dotB);

		  //calculate the distance P-Point
		  return Vector2D.Vec2DDistance(P,Point);
		}

		//------------------------- DistToLineSegmentSq ----------------------------
		//
		//  as above, but avoiding sqrt
		//------------------------------------------------------------------------
		public static function getDistToLineSegmentSq( A:Vector2D,
										               B:Vector2D,
										               P:Vector2D):Number
		{
		  //if the angle is obtuse between PA and AB is obtuse then the closest
		  //vertex must be A
		  var dotA:Number = (P.x - A.x)*(B.x - A.x) + (P.y - A.y)*(B.y - A.y);

		  if (dotA <= 0) return Vector2D.Vec2DDistanceSq(A, P);

		  //if the angle is obtuse between PB and AB is obtuse then the closest
		  //vertex must be B
		  var dotB:Number = (P.x - B.x)*(A.x - B.x) + (P.y - B.y)*(A.y - B.y);
		 
		  if (dotB <= 0) return Vector2D.Vec2DDistanceSq(B, P);
			
		  //calculate the point along AB that is the closest to P
		  var Point:Vector2D = A + ((B - A) * dotA)/(dotA + dotB);

		  //calculate the distance P-Point
		  return Vector2D.Vec2DDistanceSq(P,Point);
		}


		//--------------------LineIntersection2D-------------------------
		//
		//	Given 2 lines in 2D space AB, CD this returns true if an 
		//	intersection occurs.
		//
		//----------------------------------------------------------------- 

		public static function lineIntersection2D( A:Vector2D,
									           B:Vector2D,
											   C:Vector2D, 
											   D:Vector2D):Boolean
		{
			var rTop:Number = (A.y-C.y)*(D.x-C.x)-(A.x-C.x)*(D.y-C.y);
		    var sTop:Number = (A.y-C.y)*(B.x-A.x)-(A.x-C.x)*(B.y-A.y);
			var Bot:Number = (B.x-A.x)*(D.y-C.y)-(B.y-A.y)*(D.x-C.x);

		    if (Bot == 0)//parallel
		    {
				return false;
		    }

			var invBot:Number = 1.0/Bot;
			var r:Number = rTop * invBot;
			var s:Number = sTop * invBot;

			if( (r > 0) && (r < 1) && (s > 0) && (s < 1) )
		    {
			   //lines intersect
			   return true;
		    }

		    //lines do not intersect
		    return false;
		}

		//--------------------LineIntersection2D-------------------------
		//
		//	Given 2 lines in 2D space AB, CD this returns the distance the intersection
		//  occurs along AB
		//
		//----------------------------------------------------------------- 

		public static function getDistanceToLineIntersection2D(  A:Vector2D,
									                      B:Vector2D,
												          C:Vector2D, 
												          D:Vector2D):Number
		{

		    var rTop = (A.y-C.y)*(D.x-C.x)-(A.x-C.x)*(D.y-C.y);
		    var sTop = (A.y-C.y)*(B.x-A.x)-(A.x-C.x)*(B.y-A.y);

			var Bot = (B.x-A.x)*(D.y-C.y)-(B.y-A.y)*(D.x-C.x);


		    if (Bot == 0)//parallel
		    {
			    if (rTop==0 && sTop == 0)
				{
				  return 0;
				}
				
				return -1;
		    }

		    var r = rTop/Bot;
		    var s = sTop/Bot;

			if( (r > 0) && (r < 1) && (s > 0) && (s < 1) )
		    {
			 
				return Vector2D.Vec2DDistance(A,B) * r;
		    }
		
			return 0; 
		}

		//-------------------- LineIntersection2D-------------------------
		//
		//	Given 2 lines in 2D space AB, CD this returns true if an 
		//	intersection occurs and sets dist to the distance the intersection
		//  occurs along AB. Also returns the 2d vector point to the point of
		//  intersection
		//----------------------------------------------------------------- 
		public static function getVectorOfLineIntersection2D( A:Vector2D,
									         B:Vector2D,
									         C:Vector2D, 
										     D:Vector2D):Vector2D
		{

		    var rTop = (A.y-C.y)*(D.x-C.x)-(A.x-C.x)*(D.y-C.y);
			var rBot = (B.x-A.x)*(D.y-C.y)-(B.y-A.y)*(D.x-C.x);

			var sTop = (A.y-C.y)*(B.x-A.x)-(A.x-C.x)*(B.y-A.y);
			var sBot = (B.x-A.x)*(D.y-C.y)-(B.y-A.y)*(D.x-C.x);

			if ( (rBot == 0) || (sBot == 0))
			{
				//lines are parallel
				return null;
			}

			var r = rTop/rBot;
			var s = sTop/sBot;

			if( (r > 0) && (r < 1) && (s > 0) && (s < 1) )
		    {
			    //p = A + r * (B - A);
			    return  A.clone().addBy( r ).multiply(B.subtract(A));
		    }

			return null;
		}

		//----------------------- ObjectIntersection2D ---------------------------
		//
		//  tests two polygons for intersection. *Does not check for enclosure*
		//------------------------------------------------------------------------
		public static function objectIntersection2D(object1:Vector.<<Vector2D>> ,object2:Vector.<<Vector2D>>):Boolean
		{
		  //test each line segment of object1 against each segment of object2
		  for (var r=0; r<object1.length-1; ++r)//.size() == length
		  {
			for (var t=0; t<object2.length-1; ++t)
			{
			  if (GetLineIntersection2D(object2[t],
									 object2[t+1],
									 object1[r],
									 object1[r+1]))
			  {
				return true;
			  }
			}
		  }

		  return false;
		}

		//----------------------- SegmentObjectIntersection2D --------------------
		//
		//  tests a line segment against a polygon for intersection
		//  *Does not check for enclosure*
		//------------------------------------------------------------------------
		public static function segmentObjectIntersection2D( A:Vector2D, B:Vector2D, object:Vector.<<Vector2D>> )
		{
		  //test AB against each segment of object
		  for (var r=0; r<object.length-1; ++r)
		  {
			if (LineIntersection2D(A, B, object[r], object[r+1]))
			{
			  return true;
			}
		  }

		  return false;
		}


		//----------------------------- TwoCirclesOverlapped ---------------------
		//
		//  Returns true if the two circles overlap
		//------------------------------------------------------------------------
		public static function twoCirclesOverlapped( x1:Number,  y1:Number,  r1:Number, 
												  x2:Number,  y2:Number,  r2:Number):Boolean
		{
		    var dist = Math.sqrt( (x1-x2) * (x1-x2) + (y1-y2) * (y1-y2));

		    if ((dist < (r1+r2)) || (dist < Math.abs(r1-r2)))
		    {
				return true;
		    }

		    return false;
		}

		//----------------------------- TwoCirclesOverlapped ---------------------
		//
		//  Returns true if the two circles overlap
		//------------------------------------------------------------------------
		public static function twoCirclesOverlappedVec2D( c1:Vector2D, r1:Number, c2:Vector2D, r2:Number ):Boolean
		{
		    var dist:Number = c1.getDistance( c2 );

		    if ((dist < (r1+r2)) || (dist Math.abs(r1-r2)))
		    {
				return true;
		    }

		    return false;
		}

		//--------------------------- TwoCirclesEnclosed ---------------------------
		//
		//  returns true if one circle encloses the other
		//-------------------------------------------------------------------------
		public static function twoCirclesEnclosed( x1:Number,  y1:Number,  r1:Number, x2:Number,  y2:Number,  r2:Number):Boolean
		{
			var dist:Number = Math.sqrt( (x1-x2) * (x1-x2) +
											(y1-y2) * (y1-y2));

		    return dist < Math.abs(r1-r2)
		}

		//------------------------ TwoCirclesIntersectionPoints ------------------
		//
		//  Given two circles this function calculates the intersection points
		//  of any overlap.
		//
		//  returns false if no overlap found
		//
		// see http://astronomy.swin.edu.au/~pbourke/geometry/2circle/
		//------------------------------------------------------------------------ 
		public static function getTwoCirclesIntersectionPoints( x1:Number,  y1:Number,  r1:Number, x2:Number,  y2:Number,  r2:Number):Vector.<Vector2D>
		{
			var result:Vector.<Vector2D> = new Vector.<Vector2D>;
			
		    //first check to see if they overlap
		    if (!CirclesOverlapped(x1,y1,r1,x2,y2,r2))
		    {
				return result;
		    }

		    //calculate the distance between the circle centers
		    var d = Math.sqrt( (x1-x2) * (x1-x2) + (y1-y2) * (y1-y2));
		  
		    //Now calculate the distance from the center of each circle to the center
		    //of the line which connects the intersection points.
		    var a = (r1 - r2 + (d * d)) / (2 * d);
		    var b = (r2 - r1 + (d * d)) / (2 * d);
		  
		    //MAYBE A TEST FOR EXACT OVERLAP? 

		    //calculate the point P2 which is the center of the line which 
		    //connects the intersection points
		    var p2X = x1 + a * (x2 - x1) / d;
		    var p2Y = y1 + a * (y2 - y1) / d;

		    //calculate first point
		    var h1 = Math.sqrt((r1 * r1) - (a * a));
		    var p3X = p2X - h1 * (y2 - y1) / d;
		    var p3Y = p2Y + h1 * (x2 - x1) / d;

			result.push(new Vector2D(p3X, p3Y));
			
		    //calculate second point
		    var h2 = Math.sqrt((r2 * r2) - (a * a));
		    var p4X = p2X + h2 * (y2 - y1) / d;
		    var p4Y = p2Y - h2 * (x2 - x1) / d;

            result.push(new Vector2D(p4X, p4Y));
			
		    return result;
		}

		//------------------------ TwoCirclesIntersectionArea --------------------
		//
		//  Tests to see if two circles overlap and if so calculates the area
		//  defined by the union
		//
		// see http://mathforum.org/library/drmath/view/54785.html
		//-----------------------------------------------------------------------
		public static function getTwoCirclesIntersectionArea( x1:Number,  y1:Number,  r1:Number,  x2:Number,  y2:Number,  r2:Number):Number
		{
		  //first calculate the intersection points
		  var iX1; 
		  var iY1; 
		  var iX2; 
		  var iY2;

		  if(getCirclesIntersectionPoints(x1,y1,r1,x2,y2,r2,iX1,iY1,iX2,iY2).length == 0)
		  {
			 return 0.0; //no overlap
		  }

		  //calculate the distance between the circle centers
		  var d:Number = Math.sqrt( (x1-x2) * (x1-x2) + (y1-y2) * (y1-y2));

		  //find the angles given that A and B are the two circle centers
		  //and C and D are the intersection points
		  var CBD:Number = 2 * Math.acos((r2*r2 + d*d - r1*r1) / (r2 * d * 2)); 

		  var CAD:Number = 2 * Math.acos((r1*r1 + d*d - r2*r2) / (r1 * d * 2));


		  //Then we find the segment of each of the circles cut off by the 
		  //chord CD, by taking the area of the sector of the circle BCD and
		  //subtracting the area of triangle BCD. Similarly we find the area
		  //of the sector ACD and subtract the area of triangle ACD.

		  var area:Number = (0.5f * CBD * r2 * r2 - 0.5f * r2 * r2 * Math.sin(CBD)) + (0.5f * CAD * r1 * r1 - 0.5f * r1 * r1 * Math.sin(CAD));

		  return area;
		}

		//-------------------------------- CircleArea ---------------------------
		//
		//  given the radius, calculates the area of a circle
		//-----------------------------------------------------------------------
		public static function getCircleArea( radius:Number ):Number
		{
		    return Math.PI * radius * radius;
		}


		//----------------------- PointInCircle ----------------------------------
		//
		//  returns true if the point p is within the radius of the given circle
		//------------------------------------------------------------------------
		public static function isPointInCircle( cpos:Vector2D, radius:Number , point:Vector2D):Boolean
		{
		    var distSq:Number = point.getDistanceSq( cpos );

		    if ( distSq < (radius*radius))
		    {
			   return true;
		    }

		    return false;
		}

		//--------------------- LineSegmentCircleIntersection ---------------------------
		//
		//  returns true if the line segemnt AB intersects with a circle at
		//  position P with radius radius
		//------------------------------------------------------------------------
		public static function  lineSegmentCircleIntersection( A:Vector2D,//edge/line start
													  B:Vector2D,//edge/line end
													  C:Vector2D,//circle position
													  radius:Number//circle radius
													  ):Boolean
		{
		  //first determine the distance from the center of the circle to
		  //the line segment (working in distance squared space)
		  var dist = GetDistToLineSegmentSq(A, B, C);

		  if (dist < radius*radius)
		  {
			return true;
		  }

		  else
		  {
			return false;
		  }

		}

		//------------------- GetLineSegmentCircleClosestIntersectionPoint ------------
		//
		//  given a line segment AB and a circle position and radius, this function
		//  determines if there is an intersection and stores the position of the 
		//  closest intersection in the reference IntersectionPoint
		//
		//  returns false if no intersection point is found
		//-----------------------------------------------------------------------------
		public static function  getLineSegmentCircleClosestIntersectionPoint( A:Vector2D,
																  B:Vector2D,
																  pos:Vector2D,
																  radius:Number,
																  IntersectionPoint:Vector2D /*is a deep reference*/):Boolean
		{
		  var toBNorm:Vector2D = Vector2D.Vec2DNormalize(B.subtract(A))//TODO: should clone vector math?;

		  //move the circle into the local space defined by the vector B-A with origin
		  //at A
		  var LocalPos:Vector2D = Geometry2D.pointToLocalSpace(pos, toBNorm, toBNorm.getPerp(), A);

		  var ipFound:Boolean = false;

		  //if the local position + the radius is negative then the circle lays behind
		  //point A so there is no intersection possible. If the local x pos minus the 
		  //radius is greater than length A-B then the circle cannot intersect the 
		  //line segment
		  if ( (LocalPos.x+radius >= 0) &&
			 ( (LocalPos.x-radius)*(LocalPos.x-radius) <= Vec2DDistanceSq(B, A)) )
		  {
			 //if the distance from the x axis to the object's position is less
			 //than its radius then there is a potential intersection.
			 if (Math.abs(LocalPos.y) < radius)//fabs
			 {
				//now to do a line/circle intersection test. The center of the 
				//circle is represented by A, B. The intersection points are 
				//given by the formulae x = A +/-sqrt(r^2-B^2), y=0. We only 
				//need to look at the smallest positive value of x.
				var a:Number = LocalPos.x;
				var b:Number = LocalPos.y;       

				var ip:Number = a - Math.sqrt(radius*radius - b*b);

				if (ip <= 0)
				{
				  ip = a + Math.sqrt(radius*radius - b*b);
				}

				ipFound = true;

				IntersectionPoint = A.add(toBNorm).scaleBy(ip);//A+ toBNorm*ip;
			 }
		   }

		  return ipFound;
		}

		
		//--------------------------- WorldTransform -----------------------------
		//
		//  given a std::vector of 2D vectors, a position, orientation and scale,
		//  this function transforms the 2D vectors into the object's world space
		//------------------------------------------------------------------------
		public static function worldTransform(points:Vector.<Vector2D>, pos:Vector2D,forward:Vector2D, side:Vector2D,scale:Vector2D):Vector<Vector2D>
		{
			//copy the original vertices into the buffer about to be transformed
		    var tranVector2Ds:Vector.<Vector2D> = points.slice();
		  
		    //create a transformation matrix
		    var m :Matrix2D = new Matrix2D();
			
			//scale
		    if ( (scale.x != 1.0) || (scale.y != 1.0) )
		    {
				m.scale(scale.x, scale.y);
		    }

			//rotate
			m.rotateVec2D(forward, side);

			//and translate
			m.translate(pos.x, pos.y);
			
		    //now transform the object's vertices
		    m.transformVector2Ds(tranVector2Ds);

		    return tranVector2Ds;
		}
		
		//--------------------- PointToWorldSpace --------------------------------
		//
		//  Transforms a point from the agent's local space into world space
		//------------------------------------------------------------------------
		public static function pointToWorldSpace( point:Vector2D,
										   entityHeading:Vector2D,
										   entitySide:Vector2D,
										   entityPosition:Vector2D):Vector2D
		{
			//make a copy of the point
		    var p:Vector2D = point.clone();
		  
		    //create a transformation matrix
			var m :Matrix2D = new Matrix2D();

			//rotate
			m.rotateVec2D(entityHeading, entitySide);

			//and translate
			m.translate(entityPosition.x, entityPosition.y);
			
		    //now transform the vertices
		    m.transformVector2D(p);

		   nreturn p;
		}
		
		//--------------------- VectorToWorldSpace --------------------------------
		//
		//  Transforms a vector from the agent's local space into world space
		//------------------------------------------------------------------------
		public static function vectorToWorldSpace( v:Vector2D,
										    entityHeading:Vector2D,
										    entitySide:Vector2D):Vector2D
		{
			//make a copy of the point
			var vec = v.clone();
		  
		    //create a transformation matrix
			var m :Matrix2D = new Matrix2D();

			//rotate
			m.rotateVec2D(entityHeading, entitySide);

		    //now transform the vertices
		    m.transformVector2D(vec);

		    return vec;
		}
		
		//--------------------- PointToLocalSpace --------------------------------
		//
		//------------------------------------------------------------------------
		public static function pointToLocalSpace( p:Vector2D,
												  entityHeading:Vector2D, 
												  entitySide:Vector2D, 
												  entityPosition:Vector2D):Vector2D
		{
			//make a copy of the point
		    var tp = p.clone();
		  
		    //create a transformation matrix
			var m:Matrix2D = new Matrix2D();

		    var tx:Number = -entityPosition.getDot(entityHeading);
		    var ty:Number = -entityPosition.getDot(entitySide);

		    //create the transformation matrix
		    m._11(entityHeading.x); 
			m._12(entitySide.x);
		    m._21(entityHeading.y); 
			m._22(entitySide.y);
		    m._31(tx);           
			m._32(ty);
			
		    //now transform the vertices
		    m.transformVector2D(tp);

		    return tp;
		}

		//--------------------- VectorToLocalSpace --------------------------------
		//
		//------------------------------------------------------------------------
		public static function vectorToLocalSpace(vec:Vector2D,
												  entityHeading:Vector2D, 
												  entitySide:Vector2D )
		{ 
			//make a copy of the point
		    var tp:Vector2D = vec.clone();
		  
		    //create a transformation matrix
			var m:Matrix2D = new Matrix2D();

		    //create the transformation matrix
		    m._11(entityHeading.x);
			m._12(entitySide.x);
		    m._21(entityHeading.y);
			m._22(entitySide.y);
			
		    //now transform the vertices
		    m.transformVector2D(tp);

		    return tp;
		}

		//-------------------------- Vec2DRotateAroundOrigin --------------------------
		//
		//  rotates a vector ang rads around the origin
		//-----------------------------------------------------------------------------
		public static function vec2DRotateAroundOrigin( v:Vector2D, ang:Number):void
		{
		  //create a transformation matrix
		  var m:Matrix2D = new Matrix2D();

		  //rotate
		  m.rotate(ang);
			
		  //now transform the object's vertices
		  mat.transformVector2Ds(v);
		}

		//------------------------ Create Whiskers -----------------------------------
		//
		//  given an origin, a facing direction, a 'field of view' describing the 
		//  limit of the outer whiskers, a whisker length and the number of whiskers
		//  this method returns a vector containing the end positions of a series
		//  of whiskers radiating away from the origin and with equal distance between
		//  them. (like the spokes of a wheel clipped to a specific segment size)
		//----------------------------------------------------------------------------
		public static function createWhiskers( amount:uint, length:Number,fov:Number,
													      facing:Vector2D,
													      origin:Vector2D):Vector.<Vector2D>
		{
		  //this is the magnitude of the angle separating each whisker
		  var sectorSize:Number = fov/Number(amount-1);

		  var whiskers:Vector<Vector2D> = new Vector.<Vector2D>();
		  var temp:Vector2D = new Vector2D;
		  var angle:Number = -fov*0.5; 
		
		  for ( var w=0:uint; w<amount; ++w)
		  {
			//create the whisker extending outwards at this angle
			temp = facing;
			vec2DRotateAroundOrigin(temp, angle);
			whiskers.push(origin.addBy( length) .multiply( temp ));

			angle+=sectorSize;
		  }

		  return whiskers;
		}
	}
}




