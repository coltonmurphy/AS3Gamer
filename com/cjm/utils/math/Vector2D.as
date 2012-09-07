package com.cjm.utils.math 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Vector2D extends Point 
	{
		public function Vector2D(x:Number=0, y:Number=0) 
		{
			super(x, y);
		}
		
		public function zero():void
		{
			x = 0; y = 0;
		}
		
		public function isZero():void
		{
			return x == 0 && y == 0;
		}
		
		public function get lengthSq():Number
		{
			return (x*x + y*y);
		}
		
		/*Returns dot product, an angle between 2 vectors.
		 * For vectors U and V, formula: U*V=UxVx + UyVy
		 */
		public function getDot(v:Vector2D):Number
		{
			return x * v.x + y * v.y;
		}
		
		/*Returns positive if passed vector is clockwise of this vector, 
		negative if counterclockwise
		clockwise = 1, counterclockwise = -1
		*/
		public function getSign( v:Vector2D ):int
		{
			 if (y*v.x > x*v.y)
			  { 
				return -1;
			  }
			  else 
			  {
				return 1;
			  }
		}
		
		/*Returns a vector perpendicular to this one*/
		public function getPerp():Vector2D
		{
			return new Vector2D(-y, x);
		}
		
		//Set max length of vector
		public function truncate( maxLength:Number ):void
		{
			if ( length > maxLength )
			{
				normalize( maxLength );//normalize is scalar to argument and should work fine
			}
		}
		
		/*Returns the distance between vectors*/
		public function getDistance( v:Vector2D ):Number
		{
			return Math.sqrt(distanceSq(v));
		}
		
		/*Returns the distance between vectors*/
		public function getDistanceSq( v:Vector2D ):Number
		{
			var yDist = v.y - y;
			var xDist = v.x - x;

			return yDist*yDist + xDist*xDist;
		}
		
		/*Reflect -
		  given a normalized vector this method reflects the vector it
		  is operating upon.*/ 
		public function reflect( norm:Vector2D ):void
		{
			var clne = clone();
			var scalar:Number = 2;
			var dot:Vector2D = getDot( norm );
			var rev:Vector2D = norm.getReverse();
			var result = clne.add(2.0 * getDot( norm ) * norm.getReverse());//TODO: convert mult operator for vectors and scalars
			return result;
		}
		
		/*Returns the reverse vector of this vector, does not change this vector*/
		public function getReverse():Vector2D
		{
			return new Vector2D(-x,-y);
		}
		
		public static function Vec2DNormalize(v:Vector2D):Vector2D
		{
		   var  len = v.length;

			if ( len > (1 - Number.MIN_VALUE ) )//TODO: Verify if epsilon differential is ported correctly
			{
		
				v.x /= len;
				v.y /= len;
			}

			return v;
		}


		public static function Vec2DDistance( v1:Vector2D, v2:Vector2D):Number
		{
			var yD = v2.y - v1.y;
			var xD = v2.x - v1.x;

		    return Math.sqrt(yD*yD + xD*xD);
		}

		public static function Vec2DDistanceSq(v1:Vector2D, v2:Vector2D):Number
		{

		    var yD = v2.y - v1.y;
			var xD = v2.x - v1.x;

		    return yD*yD + xD*xD;
		}

		public static function Vec2DLength(v:Vector2D)
		{
		  return Math.sqrt(v.x*v.x + v.y*v.y);
		}

		public static function Vec2DLengthSq(v:Vector2D)
		{
		  return (v.x*v.x + v.y*v.y);
		}
	}
}