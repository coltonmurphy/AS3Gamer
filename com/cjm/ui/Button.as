package com.cjm.ui 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class Button extends MovieClip implements IButton
	{
		protected var _textfield:TextField;
		protected var _label:TextField;
		
		public function Button() 
		{
			super();
			
			addEventListener( MouseEvent.CLICK, onClickEvent );
			addEventListener( MouseEvent.MIDDLE_CLICK, onClickEvent );
			addEventListener( MouseEvent.RIGHT_CLICK, onClickEvent );
			
			addEventListener( MouseEvent.MOUSE_DOWN, onMouseDownEvent );
			addEventListener( MouseEvent.MOUSE_OVER, onMouseOverEvent );
			addEventListener( MouseEvent.MOUSE_UP, onMouseUpEvent );
			
			addEventListener( MouseEvent.ROLL_OUT, onRollOutEvent );
			addEventListener( MouseEvent.ROLL_OVER, onRollOverEvent );
			addEventListener( MouseEvent.RELEASE_OUTSIDE, onReleaseOutsideEvent );
		}
		
		public function set label( value:String ):void
		{
			_textfield.text = _label = value;
		}
		
		override public function set enabled( value:Boolean ):void
		{
			super.enabled = value;
			
			mouseChildren = mouseEnabled = false;
			
			//Additional visible modifications / visible state
		}
		
		protected function onClickEvent( event:MouseEvent ):void
		{
			switch( event.type )
			{
				case MouseEvent.CLICK:
					//dispatch event or signal to notify display tree parents
				break
				case MouseEvent.MIDDLE_CLICK:
					//dispatch event or signal to notify display tree parents
				break
				case MouseEvent.RIGHT_CLICK:
					//dispatch event or signal to notify display tree parents
				break
			}
		}
		

		protected function onRollOverEvent( event:MouseEvent ):void
		{
			//Update timeline state, or other indicators
			//dispatch event or signal to notify display tree parents
		}
		
		protected function onRollOutEvent( event:MouseEvent ):void
		{
			//Update timeline state, or other indicators
			//dispatch event or signal to notify display tree parents
		}
		
		protected function onMouseOverEvent( event:MouseEvent ):void
		{
			//Update timeline state, or other indicators
			//dispatch event or signal to notify display tree parents
		}
		
		protected function onMouseOutEvent( event:MouseEvent ):void
		{
			//Update timeline state, or other indicators
			//dispatch event or signal to notify display tree parents
		}
		
		protected function onMouseUpEvent( event:MouseEvent ):void
		{
			//Update timeline state, or other indicators
			//Update timeline state, or other indicators
			//dispatch event or signal to notify display tree parents
		}
		
		protected function onMouseDownEvent( event:MouseEvent ):void
		{
			//Update timeline state, or other indicators
			//dispatch event or signal to notify display tree parents
		}
		
		protected function onReleaseOutsideEvent( event:MouseEvent ):void
		{
			//Update timeline state, or other indicators
			//dispatch event or signal to notify display tree parents
		}
	}

}