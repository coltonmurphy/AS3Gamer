

package com.cjm.math.geom
{
	import com.cjm.core.IRender;


	public class InvertedAABBox2D implements IRender
	{
		private var  _topLeft:Vector2D;
		private var  _bottomRight:Vector2D;
		private var  _center:Vector2D;
	  
		public function InvertedAABBox2D( tl:Vector2D, br:Vector2D)
		{
		    _topLeft = tl;
		    _bottomRight = br;
		    _center = tl.clone().add(br).divideBy( 2 );
		}

	    //returns true if the bbox described by other intersects with this one
	    public function isOverlappedWith(const InvertedAABBox2D& other):Boolean
	    {
			return !((other.top() > bottom()) ||
				   (other.bottom() < top()) ||
				   (other.left() > right()) ||
				   (other.right() < left()));
	    }

	  
	    public function topLeft():Vector2D{return _topLeft;}
	    public function bottomRight():Vector2D{return _bottomRight;}

	    public function top():Number{return _topLeft.y;}
	    public function left():Number{return _topLeft.x;}
	    public function bottom():Number{return _bottomRight.y;}
	    public function right():Number{return _bottomRight.x;}
	    public function center():Vector2D{return _center;}

	    public function render(...params):void
	    {
		    var renderCenter:Boolean = params.length ? params[0] : false; 
			
			//todo: graphic collision detection
			//todo: possibly supply drawing context or dispatch info for rendering engine to prioritize and render updates, validation, collision, ect
			
			/*var gdi:*  we will likely create a singleton for centralized data comparison and renderings
		    gdi.line(left(), top(), right(), top() );
		    gdi.line(left(), bottom(), right(), bottom() );
		    gdi.line(left(), top(), left(), bottom() );
		    gdi.line(right(), top(), right(), bottom() );

			if (renderCenter)
			{
			    gdi.circle(_center, 5);
			}*/
	
	    }

	};
}

  
