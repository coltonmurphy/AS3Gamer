

package com.cjm.math.geom
{
	import com.cjm.game.core.IRender;
	
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
			return !((other.top() > this.bottom()) ||
				   (other.bottom() < this.top()) ||
				   (other.left() > this.right()) ||
				   (other.right() < this.left()));
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
			
		    gdi.line((int)left(), top(), right(), top() );
		    gdi.line((int)left(), bottom(), right(), bottom() );
		    gdi.line((int)left(), top(), left(), bottom() );
		    gdi.line((int)Right(), top(), right(), bottom() );


			if (renderCenter)
			{
			    gdi.circle(_center, 5);
			}
	    }

	};
}

  
