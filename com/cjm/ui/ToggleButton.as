package com.cjm.ui 
{
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Colton Murphy
	 */
	public class ToggleButton extends Button 
	{
		protected var _toggledOn:Boolean;
		
		public function ToggleButton() 
		{
			super();
		}
		
		protected function onClickEvent( event:MouseEvent ):void
		{
			if( event.type == MouseEvent.CLICK)
			{
				_toggledOn != _toggledOn;
			}
			
			//change display state
			//dispatch event or signal to notify display tree parents
		}
		
	}

}