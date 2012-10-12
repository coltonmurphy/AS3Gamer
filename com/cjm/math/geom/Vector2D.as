package com.cjm.math.geom 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Vector2D 
	{
		protected var _x:Number;
		protected var _y:Number;
		
		public function Vector2D(x:Number=0, y:Number=0) 
		{
			_x = x;
			_y = y;
		}
		
		public function zero():void
		{
			_x = 0; _y = 0;
		}
		
		public function isZero():Boolean
		{
			return _x == 0 && _y == 0;
		}
		
		public function equals( v:Vector2D ):Boolean
		{
			return _x == v.x && _y == v.y;
		}
		
		public function length():Number
		{
			return Math.sqrt(lengthSq); 
		}
		
		public function lengthSq():Number
		{
			return (_x*_x + _y*_y);
		}
		
		public function get x():Number 
		{
			return _x;
		}
		
		public function set x(value:Number):void 
		{
			_x = value;
		}
		
		public function get y():Number 
		{
			return _y;
		}
		
		public function set y(value:Number):void 
		{
			_y = value;
		}
		
		public function clone():Vector2D
		{
			return new Vector2D( _x, _y );
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
			return new Vector2D(-_y, _x);
		}
		
		//Set max length of vector
		public function truncate( max:Number ):void
		{
			if ( length > max )
			{
				normalize( );//normalize is scalar to argument and should work fine
				scaleBy( max );
			}
		}
		
		/*Returns the distance between vectors*/
		public function getDistance( v:Vector2D ):Number
		{
			return Math.sqrt(getDistanceSq(v));
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
		public function reflect( norm:Vector2D ):Vector2D
		{
			var scalar:Number = 2;
			var dot:Number = getDot( norm ) * scalar;
			var rev:Vector2D = norm.getReverse().scaleBy( dot );
			add( rev );
			
			return this;
		}
		
		/*Returns the reverse vector of this vector, does not change this vector*/
		public function getReverse():Vector2D
		{
			return clone().reverse();
		}
		
		//return 'this' instance for chaining methods
		public function reverse():Vector2D
		{
			_x = -x;
			_y = -y;
			
			return this;
		}
		
		//return 'this' instance for chaining methods
		public function divideBy( amount:Number ):Vector2D
		{
			_x /= amount;
			_y /= amount;
			
			return this;
		}
		
		//return 'this' instance for chaining methods
		public function scaleBy( amount:Number ):Vector2D
		{
			_x *= amount;
			_y *= amount;
			
			return this;
		}
		
		//return 'this' instance for chaining methods
		public function addBy( amount:Number ):Vector2D
		{
			_x += amount;
			_y += amount;
			
			return this;
		}
		
		//return 'this' instance for chaining methods
		public function subtractBy( amount:Number ):Vector2D
		{
			_x -= amount;
			_y -= amount;
			
			return this;
		}
		
		//return 'this' instance for chaining methods
		public function divide( v:Vector2D ):Vector2D
		{
			_x /= v.x;
			_y /= v.y;
			
			return this;
		}
		
		//return 'this' instance for chaining methods
		public function multiply( v:Vector2D ):Vector2D
		{
			_x *= v.x;
			_y *= v.y;
			
			return this;
		}
		
		//return 'this' instance for chaining methods
		public function add( v:Vector2D ):Vector2D
		{
			_x += v.x;
			_y += v.y;
			
			return this;
		}
		
		//return 'this' instance for chaining methods
		public function subtract( v:Vector2D ):Vector2D
		{
			_x -= v.x;
			_y -= v.y;
			
			return this;
		}
		
		//return 'this' instance for chaining methods
		public function normalize():Vector2D
		{
			if (length < Number.MIN_VALUE)
			{
				zero();
			}
			var inv:Number = 1.0 / length;
			_x *= inv;
			_y *= inv;
			
			return this;
		}
		
		public static function Vec2DNormalize(v:Vector2D):Vector2D
		{
		   var  len = v.length;

			/*if ( len > (1 - Number.MIN_VALUE ) )//TODO: Verify if epsilon differential is ported correctly
			{
				v.x /= len;
				v.y /= len;
			}*/
			
			if (len < Number.MIN_VALUE)
			{
				v.zero();
			}
			var inv:Number = 1.0 / len;
			v.x *= inv;
			v.y *= inv;

			return v;
		}

		public static function Vec2DDistance( v1:Vector2D, v2:Vector2D):Number
		{
		    return Math.sqrt( Vec2DDistanceSq(v1,v2) );
		}

		public static function Vec2DDistanceSq(v1:Vector2D, v2:Vector2D):Number
		{
		    var yD = v2.y - v1.y;
			var xD = v2.x - v1.x;

		    return yD*yD + xD*xD;
		}

		public static function Vec2DLength(v:Vector2D):Number
		{
		  return Math.sqrt(v.x*v.x + v.y*v.y);
		}

		public static function Vec2DLengthSq(v:Vector2D):Number
		{
		  return (v.x*v.x + v.y*v.y);
		}
		
		//treats a window as a toroid
		public static function WrapAround( pos:Vector2D, MaxX:int, MaxY:int)
		{
		    if (pos.x > MaxX) {pos.x = 0.0;}

		    if (pos.x < 0)    {pos.x = Number(MaxX);}

		    if (pos.y < 0)    {pos.y = Number(MaxY);}

		    if (pos.y > MaxY) {pos.y = 0.0;}
		}

		//returns true if the point p is not inside the region defined by top_left
		//and bot_rgt
		public static function NotInsideRegion( p:Vector2D,  topleft:Vector2D,  btmrgt:Vector2D):Boolean
		{
		  return (p.x < topleft.x) || (p.x > btmrgt.x) || 
				 (p.y < topleft.y) || (p.y > btmrgt.y);
		}

		public static function InsideRegion(p:Vector2D,  topleft:Vector2D,  btmrgt:Vector2D):Boolean
		{
		  return !NotInsideRegion(p, topleft, btmrgt);
		}

		

		//------------------ isSecondInFOVOfFirst -------------------------------------
		//
		//  returns true if the target position is in the field of view of the entity
		//  positioned at posFirst facing in facingFirst
		//-----------------------------------------------------------------------------
		public static function isTargetInFOV( position:Vector2D, 
											  direction:Vector2D,
											  targetPosition:Vector2D, 
											  fov:Number):Boolean
		{
		  var toTarget:Vector2D = targetPosition.subtract( position ).normalize();

		  return direction.getDot(toTarget) >= Math.cos(fov/2.0);
		}
	}
}