package com.cjm.view 
{
	import flash.display.Graphics;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Line 
	{
		protected var _canvas:Graphics;
		protected var _hasStarted::Boolean;
		
		public function Line( g:Graphics ) 
		{
			_canvas = g;
			_hasStarted = false;
			_canvas.lineStyle(1);
		}
		
		public function to( x:Number, y:Number ):void
		{
			if ( ! _hasStarted )
			{
				_canvas.moveTo( x, y );
			}
			else
			{
				_canvas.lineTo( x, y );
			}
		}
	}
}