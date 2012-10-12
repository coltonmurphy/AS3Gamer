

package com.cjm.math.geom
{
	public class Matrix2D
	{

	    private var _data:Matrix;

	    public function Matrix2D()
		{
			//initialize the matrix to an identity matrix
			Identity();
	    }

	  

	    //accessors to the matrix elements
	    public function get _11:Number{_data._11 = val;}
	    public function get _12:Number{_data._12 = val;}
	    public function get _13:Number{_data._13 = val;}

	    public function get _21:Number{_data._21 = val;}
	    public function get _22:Number{_data._22 = val;}
	    public function get _23:Number{_data._23 = val;}

	    public function get _31:Number{_data._31 = val;}
	    public function get _32:Number{_data._32 = val;}
	    public function get _33:Number{_data._33 = val;}


	    //multiply two matrices together
	    public function multiply( mIn:Matrix ):void
	    {
		    var mat_temp = new Matrix();
		  
		    //first row
		    mat_temp._11 = (_data._11*mIn._11) + (_data._12*mIn._21) + (_data._13*mIn._31);
		    mat_temp._12 = (_data._11*mIn._12) + (_data._12*mIn._22) + (_data._13*mIn._32);
		    mat_temp._13 = (_data._11*mIn._13) + (_data._12*mIn._23) + (_data._13*mIn._33);

		    //second
		    mat_temp._21 = (_data._21*mIn._11) + (_data._22*mIn._21) + (_data._23*mIn._31);
		    mat_temp._22 = (_data._21*mIn._12) + (_data._22*mIn._22) + (_data._23*mIn._32);
		    mat_temp._23 = (_data._21*mIn._13) + (_data._22*mIn._23) + (_data._23*mIn._33);

		    //third
		    mat_temp._31 = (_data._31*mIn._11) + (_data._32*mIn._21) + (_data._33*mIn._31);
		    mat_temp._32 = (_data._31*mIn._12) + (_data._32*mIn._22) + (_data._33*mIn._32);
		    mat_temp._33 = (_data._31*mIn._13) + (_data._32*mIn._23) + (_data._33*mIn._33);

		    _data = mat_temp;
	    }

		//applies a 2D transformation matrix to a std::vector of Vector2Ds
		public function transformVector2Ds(vPoint:Vector.<Vector2D>)
		{
			for (var i:uint=0; i<vPoint.length; ++i)
			{
			   var tempX:Number =(_data._11*vPoint[i].x) + (_data._21*vPoint[i].y) + (_data._31);
			   var tempY:Number = (_data._12*vPoint[i].x) + (_data._22*vPoint[i].y) + (_data._32);
			   vPoint[i].x = tempX;
			   vPoint[i].y = tempY;

			}
		}

		//applies a 2D transformation matrix to a single Vector2D
		public function transformVector2D( p:Vector2D )
		{
			var tempX =(_data._11*p.x) + (_data._21*p.y) + (_data._31);
			var tempY = (_data._12*p.x) + (_data._22*p.y) + (_data._32);
			p.x = tempX;
			p.y = tempY;
		}



	    //create an identity matrix
	    public function identity():void
	    {
		    _data._11 = 1; 
		    _data._12 = 0; 
		    _data._13 = 0;

		    _data._21 = 0; 
		    _data._22 = 1; 
		    _data._23 = 0;

		    _data._31 = 0; 
		    _data._32 = 0; 
		    _data._33 = 1;
	    }

	    //create a transformation matrix
	    public function translate( x:Number,  y:Number)
	    {
		  var mat:Matrix;
		  
		  mat._11 = 1; mat._12 = 0; mat._13 = 0;
		  
		  mat._21 = 0; mat._22 = 1; mat._23 = 0;
		  
		  mat._31 = x;    mat._32 = y;    mat._33 = 1;
		  
		  //and multiply
		  multiply(mat);
	  }

	    //create a scale matrix
		public function scale(double xScale, double yScale)
		{
		  var mat:Matrix = new Matrix();
		  
		  mat._11 = xScale; mat._12 = 0; mat._13 = 0;
		  
		  mat._21 = 0; mat._22 = yScale; mat._23 = 0;
		  
		  mat._31 = 0; mat._32 = 0; mat._33 = 1;
		  
		  //and multiply
		  multiply(mat);
		}


		//create a rotation matrix
		public function rotate( rot:Number)
		{
		    var mat:Matrix = new Matrix();

		    var sin:Number = Math.sin(rot);
		    var cos:Number = Math.cos(rot);
		  
		    mat._11 = cos;  
		    mat._12 = sin; 
		    mat._13 = 0;
		  
		    mat._21 = -sin; 
		    mat._22 = cos; 
		    mat._23 = 0;
		  
		    mat._31 = 0; 
		    mat._32 = 0;
		    mat._33 = 1;
		  
		    //and multiply
		    multiply(mat);
		}


		//create a rotation matrix from a 2D vector
		public function rotateVec2D( fwd:Vector2D,  side:Vector2D):void
		{
			var mat:Matrix = new Matrix();
			  
			mat._11 = fwd.x;  
			mat._12 = fwd.y; 
			mat._13 = 0;
			  
			mat._21 = side.x; 
		    mat._22 = side.y; 
			mat._23 = 0;
			  
			mat._31 = 0; 
			mat._32 = 0;
			mat._33 = 1;
			  
			//and multiply
			multiply(mat);
		}
    }


	private class Matrix
	{
		var _11, _12, _13;
		var _21, _22, _23;
		var _31, _32, _33;

	   public function Matrix()
		{
		  _11=0.0; _12=0.0; _13=0.0;
		  _21=0.0; _22=0.0; _23=0.0;
		  _31=0.0; _32=0.0; _33=0.0;
		}
	}
}
